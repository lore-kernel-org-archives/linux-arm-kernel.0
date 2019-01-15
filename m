Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCA3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DAD20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BXPAB5o7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DAD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l1Qx4DtbNtd8f3xW4Eq5/7NdHjcqq95HhHaSFeem7/M=; b=BXPAB5o7xO462n
	V/w+MVOQppFr4aEFL85Sqms73reaxR0KvTCPblVztgkFvnC0ORGTu5WTgm1stN04gRBeuAh+yWm3E
	XlXRn8noAvp3E+g1VRcl0nmAhyuJ9ZCAvoDGV+WimL6MYB1gLq9T9+tPpWiWN2ZP6A5brNdHBJawj
	DzwDTYn7AvyinbCo08sUCPXIhHACNKfEsl+WnsV2R2sixtNEjBmFpfTVCBEpjs5HMbQCCy9MuK/zJ
	e9A9gLWRtWIeutQ9Fo4I7hTegjdfCuOfpuX/7oZtY4IiY9VGW5v0iudk4yRjb4Rd6Y9UaTXO95mK4
	8507xCECLYaHN3deLNVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjRxK-0003rV-Jt; Tue, 15 Jan 2019 16:52:50 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRxG-0003qh-RC; Tue, 15 Jan 2019 16:52:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 856E920A9B; Tue, 15 Jan 2019 17:52:45 +0100 (CET)
Received: from xps13 (173.203.136.77.rev.sfr.net [77.136.203.173])
 by mail.bootlin.com (Postfix) with ESMTPSA id 0F2BA207A3;
 Tue, 15 Jan 2019 17:52:34 +0100 (CET)
Date: Tue, 15 Jan 2019 17:52:32 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH v9 0/2]  mtd: rawnand: meson: add Amlogic NAND driver
 support
Message-ID: <20190115175232.3d82d4a9@xps13>
In-Reply-To: <1547566684-57472-1-git-send-email-jianxin.pan@amlogic.com>
References: <1547566684-57472-1-git-send-email-jianxin.pan@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_085247_015552_97A708F1 
X-CRM114-Status: GOOD (  11.51  )
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
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Hanjie Lin <hanjie.lin@amlogic.com>, Victor Wan <victor.wan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Jian Hu <jian.hu@amlogic.com>, Liang Yang <liang.yang@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSmlhbnhpbiwKCkppYW54aW4gUGFuIDxqaWFueGluLnBhbkBhbWxvZ2ljLmNvbT4gd3JvdGUg
b24gVHVlLCAxNSBKYW4gMjAxOQoyMzozODowMiArMDgwMDoKCj4gVGhlc2UgdHdvIHBhdGNoZXMg
dHJ5IHRvIGFkZCBpbml0aWFsIE5BTkQgZHJpdmVyIHN1cHBvcnQgZm9yIEFtbG9naWMgTWVzb24K
PiBTb0NzLCBjdXJyZW50IGl0IGhhcyBiZWVuIHRlc3RlZCBvbiBHWEwocDIxMikgYW5kIEFYRyhz
NDAwKSBwbGF0Zm9ybS4KPiAKPiBDaGFuZ2VzIHNpbmNlIFY4IGF0IFs5XQo+ICAtIGZpeCBidWls
ZCBmYWlscmUgYXQgb2JqZWN0X2lzX29uX3N0YWNrCj4gIC0gdXBkYXRlIEtjb25maWcgYXMgTWFy
dGluJ3Mgc3VnZ2VzdGVkCgpUaGFua3MgZm9yIHRoaXMgbGFzdCB2ZXJzaW9uLCBsb29rcyBnb29k
IHRvIG1lLiBDb3VsZCB5b3UgcGxlYXNlIHNlbmQgYQpwYXRjaCB0byBhZGQgYSBNQUlOVEFJTkVS
UyBlbnRyeT8KCkFsc28sIGNhbiB3ZSBmYWNlIGFueSBkZWFkbHkgZmFpbHVyZSBpZiBzb21lb25l
IGNvbXBpbGVzIHRoaXMgZHJpdmVyCndpdGhvdXQgdGhlIE1NQyBjbG9jayBkcml2ZXIgdXBkYXRl
ZD8KClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
