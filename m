Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7B7C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:22:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31CC2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fbVw9pXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31CC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=D0O9lOGT9vhpfQ8byNThEQzXzVMhFQ3Sj9BPi/8xxIo=; b=fbVw9pXrleqL32
	tDRGXcCNC2MFdDOq3uPAGD5yjgfgkwPsigiSeQL3ZzWdd30thtMl2m2AlLdRhACUaEElQk/0w+8bQ
	JMYLz5NQsW93Sg1/CWAzQHYwtb7H1YG8ZufTKa2LgGNsubnAHQmwa1zsaRsMJg3ZR+shgEkaZPHGj
	XFPCuRwGpD/yzLO/FJFt1xrjeI192H5yeBUa25m4pOLZc04nRumSdZ7HQMUks9U305F4ukr6Ts0qB
	bKNB9YbyVnfzXlje/CdbpDa7EP1WnZ48NVOprfp4hlUB2+vy1PIq/43G/Rn6T8Wv+jdPZsmTXTLx9
	5JYPyNWl2sms9/RdrIwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1fC-0000FC-Es; Wed, 12 Dec 2018 10:22:46 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1eW-00086M-SA
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:22:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 921D720DBC; Wed, 12 Dec 2018 11:21:53 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2517620733;
 Wed, 12 Dec 2018 11:21:43 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 00/12] Bring suspend to RAM support to PCIe Aardvark driver
Date: Wed, 12 Dec 2018 11:21:30 +0100
Message-Id: <20181212102142.16053-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_022205_411252_CD967929 
X-CRM114-Status: GOOD (  14.85  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpBcyBwYXJ0IG9mIGFuIGVmZm9ydCB0byBicmluZyBzdXNwZW5kIHRvIFJBTSBzdXBw
b3J0IHRvIEFybWFkYSAzNzAwClNvQ3MgKG1haW4gdGFyZ2V0OiBFU1BSRVNTT2JpbiksIHRoaXMg
c2VyaWVzIGhhbmRsZXMgdGhlIHdvcmsgYXJvdW5kCnRoZSBQQ0llIElQLgoKRmlyc3QsIG1vcmUg
Y29uZmlndXJhdGlvbiBpcyBkb25lIGluIHRoZSAnc2V0dXAnIGhlbHBlciBhcyBpbnNwaXJlZApm
cm9tIHRoZSBVLUJvb3QgZHJpdmVyLiBUaGlzIGlzIG5lZWRlZCB0byBlbnRpcmVseSBpbml0aWFs
aXplIHRoZSBJUApkdXJpbmcgZnV0dXJlIHJlc3VtZSBvcGVyYXRpb24gKHBhdGNoIDEpLgoKVGhl
biwgcmVzZXQgR1BJTywgUEhZIGFuZCBjbG9jayBzdXBwb3J0IGFyZSBpbnRyb2R1Y2VkIChwYXRj
aCAyLTQpLiBBcwpjdXJyZW50IGRldmljZSB0cmVlcyBkbyBub3QgcHJvdmlkZSB0aGUgY29ycmVz
cG9uZGluZyBwcm9wZXJ0aWVzLCBub3QKZmluZGluZyBvbmUgb2YgdGhlc2UgcHJvcGVydGllcyBp
cyBub3QgYW4gZXJyb3IgYW5kIGp1c3QgcHJvZHVjZXMgYQp3YXJuaW5nLiBIb3dldmVyLCBpZiB0
aGUgcHJvcGVydHkgaXMgcHJlc2VudCwgYW4gZXJyb3IgZHVyaW5nIFBIWQppbml0aWFsaXphdGlv
biB3aWxsIGZhaWwgdGhlIHByb2JlIG9mIHRoZSBkcml2ZXIuCgpOb3RlOiBUbyBiZSBzdXJlIHRo
ZSBjbG9jayB3aWxsIGJlIHJlc3VtZWQgYmVmb3JlIHRoaXMgZHJpdmVyLCBhIGZpcnN0CnNlcmll
cyBhZGRpbmcgbGlua3MgYmV0d2VlbiBjbG9ja3MgYW5kIGNvbnN1bWVycyBoYXMgYmVlbiBzdWJt
aXR0ZWQsCnNlZSBbMV0uIEFueXdheSwgaGF2aW5nIHRoZSBjbG9jayBzZXJpZXMgYXBwbGllZCBm
aXJzdCBpcyBub3QgbmVlZGVkLgoKUGF0Y2ggNSBhZGRzIHN1c3BlbmQvcmVzdW1lIGhvb2tzLCBy
ZS11c2luZyBhbGwgdGhlIGFib3ZlLgoKRmluYWxseSwgYmluZGluZ3MgYW5kIGRldmljZSB0cmVl
cyBhcmUgdXBkYXRlZCB0byByZWZsZWN0IHRoZSBoYXJkd2FyZQoocGF0Y2ggNi0xMikuIFdoaWxl
IHRoZSBjbG9jayBkZXBlbmRzIG9uIHRoZSBTb0MsIHRoZSByZXNldCBHUElPIGFuZAp0aGUgUEhZ
IGRlcGVuZHMgb24gdGhlIGJvYXJkIHNvIHRoZSBjbG9jayBpcyBhZGRlZCBpbiB0aGUKYXJtYWRh
LTM3eHguZHRzaSBmaWxlIHdoaWxlIHRoZSB0d28gb3RoZXIgcHJvcGVydGllcyBhcmUgYWRkZWQg
aW4KYXJtYWRhLTM3MjAtZXNwcmVzc29iaW4uZHRzLgoKWzFdIGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL3BpcGVybWFpbC9saW51eC1hcm0ta2VybmVsLzIwMTgtTm92ZW1iZXIvNjE0NTI3Lmh0
bWwKClRoYW5rcywKTWlxdcOobAoKQ2hhbmdlcyBzaW5jZSB2MToKPT09PT09PT09PT09PT09PT0K
KiBDaGFuZ2UgdGhlIGNhcGl0YWxpemF0aW9uIGluIGNvbW1pdCB0aXRsZXMgdG8gZm9sbG93IHRo
ZSBQQ0kKICBzdWJzeXN0ZW0gcnVsZXMuCiogQWRkZWQgU3VnZ2VzdGVkLWJ5IHRhZyB0byB0aGUg
cGF0Y2ggYWRkaW5nIFBIWSBzdXBwb3J0IGFuZCB0byB0aGUKICBwYXRjaCBhZGRpbmcgdGhlIFBI
WSBwcm9wZXJ0eSBpbiB0aGUgRFQuCiogQWRkZWQgUm9iJ3MgUmV2aWV3ZWQtYnkgdGFncyBvbiBi
aW5kaW5ncy4KKiBJIGFtIGZvbGxvd2luZyB0aGUgZGlzY3Vzc2lvbiBhYm91dCBjYWxsaW5nIGZ1
bmN0aW9ucyB0aGF0IG1pZ2h0CiAgc2xlZXAgaW4gYSBOT0lSUSBjb250ZXh0LiBBcyB0aGVyZSBp
cyBubyByZWFsIHByb2JsZW0geWV0IChhcyBwZXIgbXkKICB1bmRlcnN0YW5kaW5nKSwgSSBkaWQg
bm90IGNoYW5nZSBhbnl0aGluZyBvbiB0aGlzIHJlZ2FyZC4KCgpNaXF1ZWwgUmF5bmFsICgxMik6
CiAgUENJOiBhYXJkdmFyazogQ29uZmlndXJlIG1vcmUgcmVnaXN0ZXJzIGluIHRoZSBjb25maWd1
cmF0aW9uIGhlbHBlcgogIFBDSTogYWFyZHZhcms6IEFkZCByZXNldCBHUElPIHN1cHBvcnQKICBQ
Q0k6IGFhcmR2YXJrOiBBZGQgUEhZIHN1cHBvcnQKICBQQ0k6IGFhcmR2YXJrOiBBZGQgY2xvY2sg
c3VwcG9ydAogIFBDSTogYWFyZHZhcms6IEFkZCBzdXNwZW5kIHRvIFJBTSBzdXBwb3J0CiAgZHQt
YmluZGluZ3M6IFBDSTogYWFyZHZhcms6IERlc2NyaWJlIHRoZSByZXNldC1ncGlvcyBwcm9wZXJ0
eQogIGR0LWJpbmRpbmdzOiBQQ0k6IGFhcmR2YXJrOiBEZXNjcmliZSB0aGUgY2xvY2tzIHByb3Bl
cnR5CiAgZHQtYmluZGluZ3M6IFBDSTogYWFyZHZhcms6IERlc2NyaWJlIHRoZSBQSFkgcHJvcGVy
dHkKICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1hZGEtMzd4eDogZGVjbGFyZSBQQ0llIHJlc2V0
IHBpbgogIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zNzIwLWVzcHJlc3NvYmluOiBkZWNs
YXJlIFBDSWUgcmVzZXQgR1BJTwogIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zN3h4OiBk
ZWNsYXJlIFBDSWUgY2xvY2sKICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1hZGEtMzcyMC1lc3By
ZXNzb2JpbjogZGVjbGFyZSBQQ0llIFBIWQoKIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9h
YXJkdmFyay1wY2kudHh0ICB8ICAgOSArCiAuLi4vZHRzL21hcnZlbGwvYXJtYWRhLTM3MjAtZXNw
cmVzc29iaW4uZHRzICAgfCAgIDQgKwogYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFk
YS0zN3h4LmR0c2kgIHwgICA1ICsKIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWFhcmR2YXJr
LmMgICAgICAgICB8IDIxNCArKysrKysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgMjMy
IGluc2VydGlvbnMoKykKCi0tIAoyLjE5LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
