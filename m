Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD23AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:02:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F15320842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M0YgSJbV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GvpRASWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F15320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tUEArrxlP8ndwNwgwsnqje6zLZTJOo9HentR3bVWuR8=; b=M0YgSJbVPO5DXA
	FTpozKyoJCt1Ce+GVCTJ3PSgbvCZu2/NCDtzSKipiUl8QBJinXz0/dsF8KstDY7X2ymNJETsY77K2
	oLyaoR8jQQDFia0asGmPY1jyx4p5XHaDTDJJA8beRa3KNzHFNsvPjssR+V9qy9jJYo5MZ5XQeRiMD
	XAuHMO0C7u2FI6yyRBOewfosOxo57T1lHz+2sm62f6l9zehN4IPaWyJBHlCVyzBhlv/jqyhQyz4qp
	azWSJB27s+qWn7+FE7bYI0nnrkTPgwEJIWRiNX/dVEO0hMSGWWV1OTrjtt9RIhZLDO96vmnmBOer7
	ho6nVGbhAhsK68zRu8kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyIhi-0007LH-Ij; Mon, 25 Feb 2019 16:02:06 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIhg-0007L6-Nu; Mon, 25 Feb 2019 16:02:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DRD3NF2pSvtG+eLVDVvohGS8v1LOd0bj6VrX6J7a/tE=; b=GvpRASWEbOA1zjahYwwYY+lxkc
 cx3GBrtKwIou/lhC4Q5P3Hrtxj3ye6FxlRxKG8lw8DfNaCHTMuOm+HHSk7PjXUGbd/Y0yJbaNivY8
 /xULlsx2B6v6keihSczaqx2+V/0M8ZVmJOadIMHARziEk3MyQEonFsIfTqmK+9qONbzNiHm3zr4UE
 RlQI3CA1OniztoHbczgRjEvPpuYJng35q4hycqyqz7vd4/131iKUa7cMklrkjGhP43l574NVqhdTj
 VU7xlmqwup/0f2liBoGidCVuG45CSM/DJhizXzVxyG1NkuPB/xH2KTrNxEwgiX1UzslUfYev0uKy4
 uHZBop7A==;
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIhd-0007Le-9x; Mon, 25 Feb 2019 16:02:02 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 756F04000D;
 Mon, 25 Feb 2019 16:01:19 +0000 (UTC)
Date: Mon, 25 Feb 2019 17:01:18 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 25/27] mtd: nand: Add helpers to manage ECC engines
 and configurations
Message-ID: <20190225170118.62739fc4@xps13>
In-Reply-To: <20190222154431.66c6911f@kernel.org>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-13-miquel.raynal@bootlin.com>
 <20190222154431.66c6911f@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_110201_577983_6B812B14 
X-CRM114-Status: GOOD (  29.21  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4gd3JvdGUg
b24gRnJpLCAyMiBGZWIgMjAxOQoxNTo0NDozMSArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMzo1ODowNCArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+ID4gQWRkIHRoZSBsb2dpYyBpbiB0aGUgTkFORCBjb3JlIHRvIGZpbmQg
dGhlIHJpZ2h0IEVDQyBlbmdpbmUgZGVwZW5kaW5nCj4gPiBvbiB0aGUgTkFORCBjaGlwIHJlcXVp
cmVtZW50cyBhbmQgdGhlIHVzZXIgZGVzaXJlcy4gUmlnaHQgbm93LCB0aGUKPiA+IGNob2ljZSBt
YXkgYmUgbWFkZSBiZXR3ZWVuIChtb3JlIHdpbGwgY29tZSk6Cj4gPiAqIHNvZnR3YXJlIEhhbW1p
bmcKPiA+ICogc29mdHdhcmUgQkNICj4gPiAqIG9uLWRpZSAoU1BJLU5BTkQgZGV2aWNlcyBvbmx5
KQo+ID4gCj4gPiBPbmNlIHRoZSBFQ0MgZW5naW5lIGhhcyBiZWVuIGZvdW5kLCB0aGUgRUNDIGVu
Z2luZSBtdXN0IGJlCj4gPiBjb25maWd1cmVkLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaXF1
ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVy
cy9tdGQvbmFuZC9jb3JlLmMgIHwgMTA3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwo+ID4gIGluY2x1ZGUvbGludXgvbXRkL25hbmQuaCB8ICAgNCArKwo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbXRkL25hbmQvY29yZS5jIGIvZHJpdmVycy9tdGQvbmFuZC9jb3JlLmMKPiA+IGluZGV4IDg3
MmQ0NmI1ZmMwZi4uOWZlYjExOGM5ZjY4IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9tdGQvbmFu
ZC9jb3JlLmMKPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvY29yZS5jCj4gPiBAQCAtMjA3LDYg
KzIwNywxMTMgQEAgaW50IG5hbmRkZXZfbXRkX21heF9iYWRfYmxvY2tzKHN0cnVjdCBtdGRfaW5m
byAqbXRkLCBsb2ZmX3Qgb2Zmcywgc2l6ZV90IGxlbikKPiA+ICB9Cj4gPiAgRVhQT1JUX1NZTUJP
TF9HUEwobmFuZGRldl9tdGRfbWF4X2JhZF9ibG9ja3MpOwo+ID4gIAo+ID4gKy8qKgo+ID4gKyAq
IG5hbmRkZXZfZmluZF9lY2NfZW5naW5lKCkgLSBGaW5kIGEgc3VpdGFibGUgRUNDIGVuZ2luZQo+
ID4gKyAqIEBuYW5kOiBOQU5EIGRldmljZQo+ID4gKyAqLwo+ID4gK3N0YXRpYyBpbnQgbmFuZGRl
dl9maW5kX2VjY19lbmdpbmUoc3RydWN0IG5hbmRfZGV2aWNlICpuYW5kKSAgCj4gCj4gQ2FuIHdl
IHBhc3MgdGhlIGNvbmYgaW4gYXJndW1lbnQgaW5zdGVhZCBvZiByZWFkaW5nIGl0IGZyb20KPiBu
YW5kLT5lY2MudXNlcl9jb25mPwo+IAo+ID4gK3sKPiA+ICsJYm9vbCBpc19zcGluYW5kID0gbXRk
X3R5cGVfaXNfc3BpbmFuZCgmbmFuZC0+bXRkKTsgIAo+IAo+IEFuZCBoZXJlIGlzIHRoZSByZWFz
b24gZm9yIHRoZSBTUElOQU5EIHR5cGUuCj4gCj4gPiArCj4gPiArCS8qIFJlYWQgdGhlIHVzZXIg
ZGVzaXJlcyBpbiB0ZXJtcyBvZiBFQ0MgZW5naW5lL2NvbmZpZ3VyYXRpb24gKi8KPiA+ICsJbmFu
ZF9lY2NfcmVhZF91c2VyX2NvbmYobmFuZCk7Cj4gPiArCj4gPiArCS8qIE5vIEVDQyBlbmdpbmUg
cmVxdWVzdGVkbiwgbGV0J3MgcmV0dXJuIHdpdGhvdXQgZXJyb3IgKi8KPiA+ICsJaWYgKG5hbmQt
PmVjYy51c2VyX2NvbmYubW9kZSA9PSBOQU5EX0VDQ19OT05FKQo+ID4gKwkJcmV0dXJuIDA7Cj4g
PiArCj4gPiArCS8qIFJhdyBOQU5EIGRlZmF1bHQgbW9kZSBpcyBoYXJkd2FyZSAqLwo+ID4gKwlp
ZiAoIWlzX3NwaW5hbmQgJiYgbmFuZC0+ZWNjLnVzZXJfY29uZi5tb2RlIDwgMCkKPiA+ICsJCW5h
bmQtPmVjYy51c2VyX2NvbmYubW9kZSA9IE5BTkRfRUNDX0hXOyAgCj4gCj4gV2Ugc2hvdWxkIGxl
dCB0aGUgcmF3IE5BTkQgbGF5ZXIgdGFrZSB0aGlzIGRlY2lzaW9uIChhY3R1YWxseSwgaXQncwo+
IGV2ZW4gYSByYXcgTkFORCBjb250cm9sbGVyIGRyaXZlciBkZWNpc2lvbikuIFBsZWFzZSBjb21w
bGFpbiBpZgo+IHVzZXJfY29uZi5tb2RlIGlzIGludmFsaWQuCj4gVGhpcyB3YXkgeW91IHdvbid0
IG5lZWQgdGhlIFNQSU5BTkQgdHlwZSB5b3UgYWRkZWQgaW4gb25lIG9mIHlvdXIKPiBwcmV2aW91
cyBwYXRjaC4KPiAKPiA+ICsKPiA+ICsJLyogU1BJLU5BTkQgZGVmYXVsdCBtb2RlIGlzIG9uLWRp
ZSAqLwo+ID4gKwlpZiAoaXNfc3BpbmFuZCAmJiBuYW5kLT5lY2MudXNlcl9jb25mLm1vZGUgPCAw
KQo+ID4gKwkJbmFuZC0+ZWNjLnVzZXJfY29uZi5tb2RlID0gTkFORF9FQ0NfT05fRElFOwo+ID4g
Kwo+ID4gKwlzd2l0Y2ggKG5hbmQtPmVjYy51c2VyX2NvbmYubW9kZSkgewo+ID4gKwljYXNlIE5B
TkRfRUNDX1NPRlQ6Cj4gPiArCQluYW5kLT5lY2MuZW5naW5lID0gbmFuZF9lY2Nfc3dfZ2V0X2Vu
Z2luZShuYW5kKTsKPiA+ICsJCWJyZWFrOwo+ID4gKwljYXNlIE5BTkRfRUNDX09OX0RJRToKPiA+
ICsJCWlmIChpc19zcGluYW5kKQo+ID4gKwkJCW5hbmQtPmVjYy5lbmdpbmUgPSBzcGluYW5kX29u
ZGllX2VjY19nZXRfZW5naW5lKCk7ICAKPiAKPiBTbywgbWF5YmUgaXQncyB3b3J0aCBoYXZpbmcg
dGhlIG9uZGllIEVDQyBlbmdpbmUgaW5zdGFuY2UgZGlyZWN0bHkKPiBlbWJlZGRlZCBpbiBuYW5k
X2RldmljZSBpbnN0ZWFkIG9mIHNwaW5hbmQsIG9yIG1heWJlIGp1c3QgYSBwb2ludGVyLCBzbwo+
IHRoYXQgeW91IGRvbid0IHJlc2VydmUgZXh0cmEgc3BhY2Ugd2hlbiB0aGUgTkFORCBkZXZpY2Ug
ZG9lcyBub3QgaGF2ZQo+IG9uLWRpZSBFQ0MuCj4gCj4gPiArCQllbHNlCj4gPiArCQkJcHJfZXJy
KCJPbi1kaWUgRUNDIGVuZ2luZXMgZm9yIG5vbiBTUEkgZGV2aWNlcyBub3Qgc3VwcG9ydGVkIHll
dFxuIik7Cj4gPiArCQlicmVhazsKPiA+ICsJY2FzZSBOQU5EX0VDQ19IVzoKPiA+ICsJCXByX2Vy
cigiSGFyZHdhcmUgRUNDIGVuZ2luZXMgbm90IHN1cHBvcnRlZCB5ZXRcbiIpOwo+ID4gKwkJYnJl
YWs7Cj4gPiArCWRlZmF1bHQ6Cj4gPiArCQlwcl9lcnIoIk1pc3NpbmcgRUNDIGVuZ2luZSBwcm9w
ZXJ0eVxuIik7Cj4gPiArCX0KPiA+ICsKPiA+ICsJaWYgKCFuYW5kLT5lY2MuZW5naW5lKQo+ID4g
KwkJcmV0dXJuICAtRUlOVkFMOwo+ID4gKwo+ID4gKwlyZXR1cm4gMDsKPiA+ICt9ICAKPiAKCkkg
dGhpbmsgdGhpcyBpcyB0aGUgcm9vdCBwYXRjaCB3ZXJlIG91ciBpZGVhcyBkaXZlcmdlLiBGb3Ig
bWUsIGVhY2gKJ0VDQyBlbmdpbmUnIGhhcyBhIF9nZXQoKSBoZWxwZXIgYW5kIHRoZSBOQU5EIGNv
cmUgZGVjaWRlcyB3aGljaCBvbmUgdG8KY2FsbCB0byByZXRyaWV2ZSB0aGUgcmlnaHQgZW5naW5l
LiBDYW4geW91IHBsZWFzZSBleHBsYWluIHdoYXQgd2FzIHlvdXIKaWRlYSBpZiB0aGlzIG9uZSBk
b2VzIG5vdCBmaXQ/CgpBbHNvLCB0aGUgcGFyc2luZyBvZiB0aGUgRFQgKGluIG5hbmRfZWNjX3Jl
YWRfdXNlcl9jb25mKCkpIGdpdmVzIG1lIHRoZQp1c2VyIEVDQyBtb2RlIGFuZCBhbGdvLCBzbyBJ
IGNhbm5vdCBsZXQgdGhlIHJhdyBOQU5EIGNvcmUgKG9yIGEgcmF3Ck5BTkQgY29udHJvbGxlciBk
cml2ZXIpIG9yIHRoZSBTUEkgTkFORCBjb3JlIGRlY2lkZSB3aGljaCBtb2RlIGlzIHRoZQpkZWZh
dWx0IGlmIG5vdCBwcm92aWRlZCBieSB0aGUgdXNlci4KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
