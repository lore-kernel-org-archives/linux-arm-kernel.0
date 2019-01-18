Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CE7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:52:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F342086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eMuDY7V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F342086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fYebb1dpPq3M2sdTBPM4YOXpIwLPz4+BgLoTY0X2o9A=; b=eMuDY7V6bI/Aux
	YzIHKY3ddeeOEMCznRaj4Pdy+LYkAjVr90lOssRdqleZrUnTxtmA4xbC2wbaCm95ew2EKtce8S9gq
	m3E31CwCl/l4/NvF1EkJHA5KN7CCd2AoQWBMr0LE1vz17CxRVYlRlKpAZivKuoVtHEEzBvLiJShGo
	txjtUH2asB6QfgbDdFxnYxhuIiVUVnK2OIpcvHxlkOuqMBw8mx1MK2hohPicbJhJAFSwydKwkyvpA
	3t7WAokNNVpl0PjdXykjjTn+j6uyZIjt8o0Wcg37pU+CUbqbJ6uUr2A7MAZnfa+5WVvnjgbpfVpH5
	MjlsoWpUyDOxc38d/eJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXNL-0003bK-K0; Fri, 18 Jan 2019 16:52:11 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXNH-0003ah-ML
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:52:09 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3BF76207A3; Fri, 18 Jan 2019 17:52:06 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr
 [109.213.9.46])
 by mail.bootlin.com (Postfix) with ESMTPSA id 28F1A2074A;
 Fri, 18 Jan 2019 17:51:54 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark
 driver
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
Date: Fri, 18 Jan 2019 17:51:52 +0100
In-Reply-To: <20190108162441.5278-1-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Tue, 8 Jan 2019 17:24:25 +0100")
Message-ID: <87va2llxhz.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_085207_997503_1E446F0B 
X-CRM114-Status: GOOD (  26.71  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWlxdWVsLAogCiBPbiBtYXIuLCBqYW52LiAwOCAyMDE5LCBNaXF1ZWwgUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKCj4gSGVsbG8sCj4KPiBBcyBwYXJ0IG9mIGFu
IGVmZm9ydCB0byBicmluZyBzdXNwZW5kIHRvIFJBTSBzdXBwb3J0IHRvIEFybWFkYSAzNzAwCj4g
U29DcyAobWFpbiB0YXJnZXQ6IEVTUFJFU1NPYmluKSwgdGhpcyBzZXJpZXMgaGFuZGxlcyB0aGUg
d29yayBhcm91bmQKPiB0aGUgUENJZSBJUC4KPgo+IEZpcnN0LCBtb3JlIGNvbmZpZ3VyYXRpb24g
aXMgZG9uZSBpbiB0aGUgJ3NldHVwJyBoZWxwZXIgYXMgaW5zcGlyZWQKPiBmcm9tIHRoZSBVLUJv
b3QgZHJpdmVyLiBUaGlzIGlzIG5lZWRlZCB0byBlbnRpcmVseSBpbml0aWFsaXplIHRoZSBJUAo+
IGR1cmluZyBmdXR1cmUgcmVzdW1lIG9wZXJhdGlvbiAocGF0Y2ggMSkuCj4KPiBUaGVuLCByZXNl
dCBHUElPLCBQSFkgYW5kIGNsb2NrIHN1cHBvcnQgYXJlIGludHJvZHVjZWQgKHBhdGNoIDItNCku
IEFzCj4gY3VycmVudCBkZXZpY2UgdHJlZXMgZG8gbm90IHByb3ZpZGUgdGhlIGNvcnJlc3BvbmRp
bmcgcHJvcGVydGllcywgbm90Cj4gZmluZGluZyBvbmUgb2YgdGhlc2UgcHJvcGVydGllcyBpcyBu
b3QgYW4gZXJyb3IgYW5kIGp1c3QgcHJvZHVjZXMgYQo+IHdhcm5pbmcuIEhvd2V2ZXIsIGlmIHRo
ZSBwcm9wZXJ0eSBpcyBwcmVzZW50LCBhbiBlcnJvciBkdXJpbmcgUEhZCj4gaW5pdGlhbGl6YXRp
b24gd2lsbCBmYWlsIHRoZSBwcm9iZSBvZiB0aGUgZHJpdmVyLgo+Cj4gTm90ZTogVG8gYmUgc3Vy
ZSB0aGUgY2xvY2sgd2lsbCBiZSByZXN1bWVkIGJlZm9yZSB0aGlzIGRyaXZlciwgYSBmaXJzdAo+
IHNlcmllcyBhZGRpbmcgbGlua3MgYmV0d2VlbiBjbG9ja3MgYW5kIGNvbnN1bWVycyBoYXMgYmVl
biBzdWJtaXR0ZWQsCj4gc2VlIFsxXS4gQW55d2F5LCBoYXZpbmcgdGhlIGNsb2NrIHNlcmllcyBh
cHBsaWVkIGZpcnN0IGlzIG5vdCBuZWVkZWQuCj4KPiBQYXRjaCA1IGFkZHMgc3VzcGVuZC9yZXN1
bWUgaG9va3MsIHJlLXVzaW5nIGFsbCB0aGUgYWJvdmUuCj4KPiBGaW5hbGx5LCBiaW5kaW5ncyBh
bmQgZGV2aWNlIHRyZWVzIGFyZSB1cGRhdGVkIHRvIHJlZmxlY3QgdGhlIGhhcmR3YXJlCj4gKHBh
dGNoIDYtMTIpLiBXaGlsZSB0aGUgY2xvY2sgZGVwZW5kcyBvbiB0aGUgU29DLCB0aGUgcmVzZXQg
R1BJTyBhbmQKPiB0aGUgUEhZIGRlcGVuZHMgb24gdGhlIGJvYXJkIHNvIHRoZSBjbG9jayBpcyBh
ZGRlZCBpbiB0aGUKPiBhcm1hZGEtMzd4eC5kdHNpIGZpbGUgd2hpbGUgdGhlIHR3byBvdGhlciBw
cm9wZXJ0aWVzIGFyZSBhZGRlZCBpbgo+IGFybWFkYS0zNzIwLWVzcHJlc3NvYmluLmR0cy4KPgo+
IFsxXSBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtYXJtLWtlcm5l
bC8yMDE5LUphbnVhcnkvNjIzODg1Lmh0bWwKPgo+IFRoYW5rcywKPiBNaXF1w6hsCj4KPgo+IENo
YW5nZXMgc2luY2UgdjI6Cj4gPT09PT09PT09PT09PT09PT0KPiAqIE1pbm9yIHBhdGNoZXMgcmVv
cmRlcmluZy4KPiAqIEFkZGVkIHBpbmN0cmwgcGF0Y2hlcyBmcm9tIEdyZWdvcnkgQ2xlbWVudCBm
aXhpbmcgdGhlIFBDSWUgcGlucy4gSGlzCj4gICBjaGFuZ2VzIGltcGxpZWQgbW9kaWZpY2F0aW9u
cyBpbiB0aGUgRFQvYmluZGluZ3MgcGF0Y2hlcyBhZGRpbmcgUENJZQo+ICAgcmVzZXQgcGluIHN1
cHBvcnQuCgpBY3R1YWxseSB0aGVzZSBwYXRjaGVzIGFyZSBub3QgaW4gdGhpcyBzZXJpZXMuIFlv
dSBwcm9wYWJseSBtZWFudCB0aGF0CnRoaXMgc2VyaWVzIGlzIGRlcGVuZCBvbiB0aGVzZSBwYXRj
aGVzLgoKSWYgbmVlZGVkLCBmb3IgcGVvYXBsZSB3aG8gd2FudGVkIHRvIHRlc3QgdGhpcyBzZXJp
ZXMsIHRoZSBwaW5jdHJsCmNoYW5nZXMgYXJlIG5vdyBpbiBsaW51eC1uZXh0IGFuZCBhbHNvIGlu
IHBpbmN0cmwvZm9yLW5leHQuCgpHcmVncHJ5Cgo+ICogQWRkZWQgYSBuZXcgcGF0Y2ggdGhhdCBl
bmxhcmdlcyB0aGUgUElPIHRpbWVvdXQgb2YgdGhlIGRyaXZlcgo+ICAgKGV4cGxhbmF0aW9ucyBp
biB0aGUgY29tbWl0IGxvZykuCj4gKiBXaXRoIHRoZSB0aW1lb3V0IGNoYW5nZWQsIHJlbW92ZWQg
dGhlICJleHBlcmltZW50YWwgZGVsYXkiIHRoYXQgd2FzCj4gICBuZWVkZWQgYXQgcmVzdW1lIHRp
bWUgYmVmb3JlIGFjY2Vzc2luZyBhbnkgcmVnaXN0ZXIuCj4KPiBDaGFuZ2VzIHNpbmNlIHYxOgo+
ID09PT09PT09PT09PT09PT09Cj4gKiBDaGFuZ2UgdGhlIGNhcGl0YWxpemF0aW9uIGluIGNvbW1p
dCB0aXRsZXMgdG8gZm9sbG93IHRoZSBQQ0kKPiAgIHN1YnN5c3RlbSBydWxlcy4KPiAqIEFkZGVk
IFN1Z2dlc3RlZC1ieSB0YWcgdG8gdGhlIHBhdGNoIGFkZGluZyBQSFkgc3VwcG9ydCBhbmQgdG8g
dGhlCj4gICBwYXRjaCBhZGRpbmcgdGhlIFBIWSBwcm9wZXJ0eSBpbiB0aGUgRFQuCj4gKiBBZGRl
ZCBSb2IncyBSZXZpZXdlZC1ieSB0YWdzIG9uIGJpbmRpbmdzLgo+ICogSSBhbSBmb2xsb3dpbmcg
dGhlIGRpc2N1c3Npb24gYWJvdXQgY2FsbGluZyBmdW5jdGlvbnMgdGhhdCBtaWdodAo+ICAgc2xl
ZXAgaW4gYSBOT0lSUSBjb250ZXh0LiBBcyB0aGVyZSBpcyBubyByZWFsIHByb2JsZW0geWV0IChh
cyBwZXIgbXkKPiAgIHVuZGVyc3RhbmRpbmcpLCBJIGRpZCBub3QgY2hhbmdlIGFueXRoaW5nIG9u
IHRoaXMgcmVnYXJkLgo+Cj4KPiBNaXF1ZWwgUmF5bmFsICgxNSk6Cj4gICBQQ0k6IGFhcmR2YXJr
OiBFbmxhcmdlIFBJTyB0aW1lb3V0Cj4gICBQQ0k6IGFhcmR2YXJrOiBDb25maWd1cmUgbW9yZSBy
ZWdpc3RlcnMgaW4gdGhlIGNvbmZpZ3VyYXRpb24gaGVscGVyCj4gICBQQ0k6IGFhcmR2YXJrOiBB
ZGQgY2xvY2sgc3VwcG9ydAo+ICAgUENJOiBhYXJkdmFyazogQWRkIFBIWSBzdXBwb3J0Cj4gICBQ
Q0k6IGFhcmR2YXJrOiBBZGQgUENJZSB3YXJtIHJlc2V0IHN1cHBvcnQKPiAgIFBDSTogYWFyZHZh
cms6IEFkZCBleHRlcm5hbCByZXNldCBHUElPIHN1cHBvcnQKPiAgIFBDSTogYWFyZHZhcms6IEFk
ZCBzdXNwZW5kIHRvIFJBTSBzdXBwb3J0Cj4gICBkdC1iaW5kaW5nczogUENJOiBhYXJkdmFyazog
RGVzY3JpYmUgdGhlIGNsb2NrcyBwcm9wZXJ0eQo+ICAgZHQtYmluZGluZ3M6IFBDSTogYWFyZHZh
cms6IERlc2NyaWJlIHRoZSBQSFkgcHJvcGVydHkKPiAgIGR0LWJpbmRpbmdzOiBQQ0k6IGFhcmR2
YXJrOiBEZXNjcmliZSB0aGUgUENJZSBlbmRwb2ludCBjYXJkIHJlc2V0IHBpbnMKPiAgIGR0LWJp
bmRpbmdzOiBQQ0k6IGFhcmR2YXJrOiBEZXNjcmliZSB0aGUgcmVzZXQtZ3Bpb3MgcHJvcGVydHkK
PiAgIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zN3h4OiBkZWNsYXJlIFBDSWUgY2xvY2sK
PiAgIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zNzIwLWVzcHJlc3NvYmluOiBkZWNsYXJl
IFBDSWUgUEhZCj4gICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1hZGEtMzd4eDogZGVjbGFyZSBQ
Q0llIHJlc2V0IHBpbgo+ICAgQVJNNjQ6IGR0czogbWFydmVsbDogYXJtYWRhLTM3MjAtZXNwcmVz
c29iaW46IGRlY2xhcmUgUENJZSB3YXJtIHJlc2V0Cj4gICAgIHBpbgo+Cj4gIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9hYXJkdmFyay1wY2kudHh0ICB8ICAxNCArKwo+ICAuLi4vZHRzL21h
cnZlbGwvYXJtYWRhLTM3MjAtZXNwcmVzc29iaW4uZHRzICAgfCAgIDMgKwo+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaSAgfCAgMTAgKwo+ICBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaS1hYXJkdmFyay5jICAgICAgICAgfCAyMTcgKysrKysrKysrKysrKysr
KystCj4gIDQgZmlsZXMgY2hhbmdlZCwgMjQzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pgo+IC0tIAo+IDIuMTkuMQo+CgotLSAKR3JlZ29yeSBDbGVtZW50LCBCb290bGluCkVtYmVkZGVk
IExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2Jvb3RsaW4uY29tCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
