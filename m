Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D79AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:49:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA5E20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rRC5aXgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA5E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9UyzJFROItjLnDS2c8y8Vb6wKa3F3lH+mcuQoAmT4N0=; b=rRC5aXgYLJ0KJF
	0P3NBsVJHhnmJL8ycODpj0zEiLxZjSkHUtBhsH/ofNdPnLgzlVpuP9B7mJLUucnY0bwqdWzONtUgt
	aHGjfSlqXonsL/DBNRzWtMrSQXNPL4K6eaq6aiAzHEuFT17D00rhuEFAn97VE/48CfNuyuo7LcIfY
	A4T/mQiNKI07yuRdXUFc5hXtpl0g5322edhowMEiXMx6SptlMV7ZXVIRWTzbmIlB71mm1E365VKRR
	+j/cLLf3RVfVN5ZhY1CR8r5cbOSe4j837PvwuFK73UpLSjLqazKSQjpAxaHTswm0OPYrT2cA+eQy4
	/CVv22reP6Ytgg0UwC+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSk6O-0000Gf-K0; Fri, 30 Nov 2018 14:49:08 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSk5T-0007o8-93
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 14:48:14 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 23D4A20D27; Fri, 30 Nov 2018 15:47:55 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id B8812207B0;
 Fri, 30 Nov 2018 15:47:44 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 0/8] Add Armada 3700 COMPHY support
Date: Fri, 30 Nov 2018 15:47:35 +0100
Message-Id: <20181130144743.675-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_064811_452561_6765B5FB 
X-CRM114-Status: GOOD (  17.03  )
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
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpUaGlzIHNlcmllcyBhZGRzIGEgbmV3IGRyaXZlciB0byBzdXBwb3J0IEFybWFkYSAz
NzAwIENPTVBIWSBJUC4KVGhlIHNlcmllcyBoYXMgYmVlbiB0ZXN0ZWQgb24gYW4gRVNQUkVTU09i
aW4gd2l0aCBTQVRBLCBQQ0llCmFuZCBVU0IzIGhvc3QuIEZvciB0aGlzIHB1cnBvc2UsIHBhdGNo
IDEgZW51bWVyYXRlcyB0aGUgU0FUQSBQSFkKbW9kZS4gVGhlIFNHTUlJIFBIWSBtb2RlIHRoYXQg
aXMgc3VwcG9ydGVkIGJ5IHRoZSBJUCBoYXMgYmVlbiB3cml0dGVuCih1c2VzIFNNQyBjYWxscyBh
bnl3YXkpIGJ1dCBjb3VsZCBub3QgYmUgdGVzdGVkIG9uIHRoaXMgcGxhdGZvcm0uCgpUaHJlZSBz
ZXJpZXMgd2lsbCBmb2xsb3cgdG8gYWRkIFBIWSBzdXBwb3J0IChvciBhdCBsZWFzdCBhIFBIWSBu
b2RlcwppbiB0aGUgQTM3MDAvRVNQUkVTU09iaW4gZGV2aWNlIHRyZWVzKSB0byB0aGUgTVZFQlUg
QUhDSSBkcml2ZXIsIHRoZQpBYXJkdmFyayBQQ0kgY29udHJvbGxlciBkcml2ZXIgYW5kIHRoZSBN
VkVCVSB4SENJIGRyaXZlci4gQWxsIHRoaXMgaXMKbmVlZGVkIGluIG9yZGVyIHRvIGFjaGlldmUg
c3VzcGVuZCB0byBSQU0gb24gdGhpcyBwbGF0Zm9ybS4KClRoYW5rcywKTWlxdcOobAoKCkNoYW5n
ZXMgc2luY2UgdjE6Cj09PT09PT09PT09PT09PT09CiogRml4IHdyb25nIGNoZWNrIGluIC0+eGxh
dGUoKS4KKiBBcHBseSB0aGUgc2FtZSBmaXggdG8gdGhlIGNwMTEwIGNvbXBoeSBkcml2ZXIgZnJv
bSB3aGljaCB0aGUgYTM3MDAKICBkcml2ZXIgaXMgYmFzZWQuCiogQWRkZWQgY3JlZGl0IHRvIEdy
ZWdvcnogSmFzemN6eWsgZm9yIGhpcyB3b3JrLgoqIEFkZGVkIFN1Z2dlc3RlZC1ieSB0YWcgdG8g
dGhlIHBhdGNoIGFkZGluZyB0aGUgQ09NUEhZIERUIG5vZGUuCgoKR3J6ZWdvcnogSmFzemN6eWsg
KDEpOgogIHBoeTogZW51bWVyYXRlIFNBVEEgUEhZIG1vZGUKCk1pcXVlbCBSYXluYWwgKDcpOgog
IHBoeTogbXZlYnUtY3AxMTAtY29tcGh5OiBmaXggc3BlbGxpbmcgaW4gc3RydWN0dXJlIG5hbWUK
ICBwaHk6IG12ZWJ1LWNwMTEwLWNvbXBoeTogZml4IHBvcnQgY2hlY2sgaW4gLT54bGF0ZSgpCiAg
cGh5OiBhZGQgQTM3MDAgQ09NUEhZIHN1cHBvcnQKICBkdC1iaW5kaW5nczogcGh5OiBtdmVidS1j
b21waHk6IGV4dGVuZCB0aGUgZmlsZSB0byBkZXNjcmliZSBhMzcwMAogICAgYmluZGluZ3MKICBN
QUlOVEFJTkVSUzogcGh5OiBhZGQgZW50cnkgZm9yIEFybWFkYSAzNzAwIENPTVBIWSBkcml2ZXIK
ICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1hZGEtMzd4eDogZml4IFNBVEEgbm9kZSBzY29wZQog
IEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zN3h4OiBkZWNsYXJlIHRoZSBDT01QSFkgbm9k
ZQoKIC4uLi9iaW5kaW5ncy9waHkvcGh5LW12ZWJ1LWNvbXBoeS50eHQgICAgICAgICB8ICA2NSAr
KysrLQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2
ICsKIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzd4eC5kdHNpICB8ICAzMSAr
LQogZHJpdmVycy9waHkvbWFydmVsbC9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgIDEwICsK
IGRyaXZlcnMvcGh5L21hcnZlbGwvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgMSArCiBk
cml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1hMzcwMC1jb21waHkuYyAgfCAyNzYgKysrKysr
KysrKysrKysrKysrCiBkcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1jcDExMC1jb21waHku
YyAgfCAgIDggKy0KIGluY2x1ZGUvbGludXgvcGh5L3BoeS5oICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMSArCiA4IGZpbGVzIGNoYW5nZWQsIDM4MSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlv
bnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1h
MzcwMC1jb21waHkuYwoKLS0gCjIuMTkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
