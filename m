Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2579DC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:14:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2E120844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TU9IXs7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2E120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q6bYzjeemgvDgRwOdn7sYYT+ovIUHhawnghftrfQB88=; b=TU9IXs7WBSRoms
	peqWGfqVGqDOjt2KdG+T9yFvINM8hMMfXYYO1L5GUOcHaqMvKoA3+IQQnC13CVBM6CulhWkvmPh0x
	r8NEWXRsTeWBsLmLFfAhgKbGIVM43v/d4OWiWhPnd2C7tEVkWA7E++UED15x0fOmczPpmpNNJZSzJ
	sTCteJwfDV/x5uK9U2eYCq4umeflr3jJtD4oaL0EjzybGBH/SzWybyM7qM64gnwhL2W2m5w1eeymH
	UyzxRr244271ZjgkQKwe8j3xjDNNPtfUQBQgv81kf2HK4KzBp5Vkgl6PYNC1wzfUUD+YV7sT+kenx
	b7jAWKhnxpo3Dg+E/KDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2zi-0003Fd-Lc; Mon, 28 Jan 2019 09:14:18 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2zR-0002y6-Ew; Mon, 28 Jan 2019 09:14:03 +0000
X-Originating-IP: 90.88.29.206
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 754C740007;
 Mon, 28 Jan 2019 09:13:45 +0000 (UTC)
Date: Mon, 28 Jan 2019 10:13:44 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: rawnand: mark expected switch fall-throughs
Message-ID: <20190128101344.1cc03eed@xps13>
In-Reply-To: <20190126175429.65e6bfd8@bbrezillon>
References: <20190125210950.GA27855@embeddedor>
 <20190126105208.221a2051@bbrezillon>
 <853a267c-807b-c613-6662-93730a0b4c33@embeddedor.com>
 <20190126175429.65e6bfd8@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_011401_651519_27DEF024 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: Kees Cook <keescook@chromium.org>, Wan ZongShun <mcuos.com@gmail.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4gd3JvdGUg
b24gU2F0LCAyNiBKYW4gMjAxOQoxNzo1NDoyOSArMDEwMDoKCj4gT24gU2F0LCAyNiBKYW4gMjAx
OSAwNzo0ODo1MCAtMDYwMAo+ICJHdXN0YXZvIEEuIFIuIFNpbHZhIiA8Z3VzdGF2b0BlbWJlZGRl
ZG9yLmNvbT4gd3JvdGU6Cj4gCj4gPiBIZXkgQm9yaXMsCj4gPiAKPiA+IE9uIDEvMjYvMTkgMzo1
MiBBTSwgQm9yaXMgQnJlemlsbG9uIHdyb3RlOiAgCj4gPiA+IE9uIEZyaSwgMjUgSmFuIDIwMTkg
MTU6MDk6NTAgLTA2MDAKPiA+ID4gIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVk
ZGVkb3IuY29tPiB3cm90ZToKPiA+ID4gICAgIAo+ID4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL25hbmQvcmF3L25hbmRzaW0uYyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRzaW0uYwo+
ID4gPj4gaW5kZXggOTMzZDFhNjI5YzUxLi5kMzNlMTVkYzRjZGMgMTAwNjQ0Cj4gPiA+PiAtLS0g
YS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kc2ltLmMKPiA+ID4+ICsrKyBiL2RyaXZlcnMvbXRk
L25hbmQvcmF3L25hbmRzaW0uYwo+ID4gPj4gQEAgLTIyNTEsOSArMjI1MSwxMCBAQCBzdGF0aWMg
aW50IF9faW5pdCBuc19pbml0X21vZHVsZSh2b2lkKQo+ID4gPj4gIAo+ID4gPj4gIAlzd2l0Y2gg
KGJidCkgewo+ID4gPj4gIAljYXNlIDI6Cj4gPiA+PiAtCQkgY2hpcC0+YmJ0X29wdGlvbnMgfD0g
TkFORF9CQlRfTk9fT09COwo+ID4gPj4gKwkJY2hpcC0+YmJ0X29wdGlvbnMgfD0gTkFORF9CQlRf
Tk9fT09COwo+ID4gPj4gKwkJLyogZmFsbCB0aHJvdWdoICovCj4gPiA+PiAgCWNhc2UgMToKPiA+
ID4+IC0JCSBjaGlwLT5iYnRfb3B0aW9ucyB8PSBOQU5EX0JCVF9VU0VfRkxBU0g7Cj4gPiA+PiAr
CQljaGlwLT5iYnRfb3B0aW9ucyB8PSBOQU5EX0JCVF9VU0VfRkxBU0g7ICAgIAo+ID4gPiAKPiA+
ID4gWW91IG1pc3MgYSAnLyogZmFsbCB0aHJvdWdoICovJyBoZXJlLgo+ID4gPiAgICAgCj4gPiAK
PiA+IE5vdCByZWFsbHkuICBOb3RpY2UgdGhhdCBpbiB0aGlzIGNhc2UgdGhlIGNvZGUgZmFsbHMg
dGhyb3VnaAo+ID4gdG8gYSBicmVhayBzdGF0ZW1lbnQuICAKPiAKPiBTdGlsbCBmaW5kIGl0IHdl
aXJkIHRvIG1hbmRhdGUgZmFsbCB0aHJvdWdoIGNvbW1lbnRzIGluIGFsbCBjYXNlcyBidXQKPiB0
aGlzIG9uZS4uLgoKWWVzIHBsZWFzZSwgZXZlbiBpZiB0aGVyZSBpcyBubyBHQ0Mgd2FybmluZyBJ
IHRoaW5rIHlvdSBjYW4gYWRkIG9uZQpoZXJlLgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
