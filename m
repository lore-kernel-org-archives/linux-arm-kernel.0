Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EC1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:09:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCA820651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RK7vgNqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCA820651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Z7L8pqqKdoZkbLi0OsUaJbM5nRpnzRR3XjsoSGeu3U=; b=RK7vgNqEf2uGuY
	DJNgQiTMqNpEKtiBzdn3wLwtG/Rv0PjzhC3QEV+8nZi8pz0uUnoY9z4/Fi8qccA1+6VUIlEJdeD8Y
	Nyyzu0jwpnFG22Fz1g/UvnYx8Ml3remWquuhU7dhxXPcksY2/BFwwGnWFQGrBs6IsnlR3Tws3CWCq
	QYIJWGtpr/GOurTKsa5NWAqgpu+yiFRjNmTCrNOEaGIy1mQN/wUMor3lRFKrr/Xs3zcHSKlnJE3Gj
	oQVwp7Ry7Nv9gJoDDQtOgNQPftoDcQ+gVfKAbf+L8JHdxG0tb3Xk2gZm3UU0B97+kls8gIxo+hbwG
	JNoWDtD7NG+StRrAhNaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycUH-0000vO-Fm; Tue, 26 Feb 2019 13:09:33 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycU9-0000ur-40; Tue, 26 Feb 2019 13:09:31 +0000
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 907D51BF210;
 Tue, 26 Feb 2019 13:09:04 +0000 (UTC)
Date: Tue, 26 Feb 2019 14:09:03 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 07/15] mtd: rawnand: Fill memorg during detection
Message-ID: <20190226140903.7d0f3916@xps13>
In-Reply-To: <2442d400-d50d-bbe9-4275-cce2241f6609@kontron.de>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
 <20190221091527.20497-8-miquel.raynal@bootlin.com>
 <2442d400-d50d-bbe9-4275-cce2241f6609@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_050925_462300_0F20F8B2 
X-CRM114-Status: GOOD (  18.17  )
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
 Richard Weinberger <richard@nod.at>, Boris Brezillon <bbrezillon@kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgRnJpZWRlciwKClNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5k
ZT4gd3JvdGUgb24gU2F0LCAyMyBGZWIKMjAxOSAxMzowMDoxNCArMDAwMDoKCj4gT24gMjEuMDIu
MTkgMTA6MTUsIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gPiBGcm9tOiBCb3JpcyBCcmV6aWxsb24g
PGJicmV6aWxsb25Aa2VybmVsLm9yZz4KPiA+IAo+ID4gSWYgd2Ugd2FudCB0byB1c2UgdGhlIGdl
bmVyaWMgTkFORCBsYXllciwgd2UgbmVlZCB0byBoYXZlIHRoZSBtZW1vcmcKPiA+IHN0cnVjdCBh
cHByb3ByaWF0ZWx5IGZpbGxlZC4gUGF0Y2ggdGhlIGRldGVjdGlvbiBjb2RlIHRvIGZpbGwgdGhp
cwo+ID4gc3RydWN0Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJi
cmV6aWxsb25Aa2VybmVsLm9yZz4KPiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1p
cXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9tdGQvbmFuZC9y
YXcvZGVuYWxpLmMgICAgICAgfCAgNSArKysKPiA+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvZGlz
a29uY2hpcC5jICAgfCAgNCArKwo+ID4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9qejQ3NDBfbmFu
ZC5jICB8ICA0ICsrCj4gPiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYW1kLmMgICAgIHwg
MTEgKysrKy0tCj4gPiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYmFzZS5jICAgIHwgNjAg
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0KPiA+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcv
bmFuZF9oeW5peC5jICAgfCA0OCArKysrKysrKysrKysrKystLS0tLS0tLQo+ID4gICBkcml2ZXJz
L210ZC9uYW5kL3Jhdy9uYW5kX2plZGVjLmMgICB8IDIyICsrKysrKysrLS0tCj4gPiAgIGRyaXZl
cnMvbXRkL25hbmQvcmF3L25hbmRfb25maS5jICAgIHwgMjMgKysrKysrKystLS0KPiA+ICAgZHJp
dmVycy9tdGQvbmFuZC9yYXcvbmFuZF9zYW1zdW5nLmMgfCAyNCArKysrKysrKy0tLS0KPiA+ICAg
ZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF90b3NoaWJhLmMgfCAgOSArKysrLQo+ID4gICBkcml2
ZXJzL210ZC9uYW5kL3Jhdy9uYW5kc2ltLmMgICAgICB8ICA2ICsrKwo+ID4gICAxMSBmaWxlcyBj
aGFuZ2VkLCAxNzIgaW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pCj4gPiAgIAo+IFsuLi5d
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMgYi9kcml2
ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2Jhc2UuYwo+ID4gaW5kZXggZDMwOTJjOWEzZTIxLi5jYjAz
ODc3Yzc3NWMgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2Jhc2Uu
Ywo+ID4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMKPiA+IEBAIC00NTMw
LDIxICs0NTMwLDMwIEBAIHN0YXRpYyBpbnQgbmFuZF9nZXRfYml0c19wZXJfY2VsbCh1OCBjZWxs
aW5mbykKPiA+ICAgICovCj4gPiAgIHZvaWQgbmFuZF9kZWNvZGVfZXh0X2lkKHN0cnVjdCBuYW5k
X2NoaXAgKmNoaXApCj4gPiAgIHsKPiA+ICsJc3RydWN0IG5hbmRfbWVtb3J5X29yZ2FuaXphdGlv
biAqbWVtb3JnOwo+ID4gICAJc3RydWN0IG10ZF9pbmZvICptdGQgPSBuYW5kX3RvX210ZChjaGlw
KTsKPiA+ICAgCWludCBleHRpZDsKPiA+ICAgCXU4ICppZF9kYXRhID0gY2hpcC0+aWQuZGF0YTsK
PiA+ICsKPiA+ICsJbWVtb3JnID0gbmFuZGRldl9nZXRfbWVtb3JnKCZjaGlwLT5iYXNlKTsKPiA+
ICsKPiA+ICAgCS8qIFRoZSAzcmQgaWQgYnl0ZSBob2xkcyBNTEMgLyBtdWx0aWNoaXAgZGF0YSAq
Lwo+ID4gKwltZW1vcmctPmJpdHNfcGVyX2NlbGwgPSBuYW5kX2dldF9iaXRzX3Blcl9jZWxsKGlk
X2RhdGFbMl0pOwo+ID4gICAJY2hpcC0+Yml0c19wZXJfY2VsbCA9IG5hbmRfZ2V0X2JpdHNfcGVy
X2NlbGwoaWRfZGF0YVsyXSk7Cj4gPiAgIAkvKiBUaGUgNHRoIGlkIGJ5dGUgaXMgdGhlIGltcG9y
dGFudCBvbmUgKi8KPiA+ICAgCWV4dGlkID0gaWRfZGF0YVszXTsKPiA+ICAgCj4gPiAgIAkvKiBD
YWxjIHBhZ2VzaXplICovCj4gPiAtCW10ZC0+d3JpdGVzaXplID0gMTAyNCA8PCAoZXh0aWQgJiAw
eDAzKTsKPiA+ICsJbWVtb3JnLT5wYWdlc2l6ZSA9IDEwMjQgPDwgKGV4dGlkICYgMHgwMyk7Cj4g
PiArCW10ZC0+d3JpdGVzaXplID0gbWVtb3JnLT5wYWdlc2l6ZTsKPiA+ICAgCWV4dGlkID4+PSAy
Owo+ID4gICAJLyogQ2FsYyBvb2JzaXplICovCj4gPiAtCW10ZC0+b29ic2l6ZSA9ICg4IDw8IChl
eHRpZCAmIDB4MDEpKSAqIChtdGQtPndyaXRlc2l6ZSA+PiA5KTsKPiA+ICsJbWVtb3JnLT5vb2Jz
aXplID0gKDggPDwgKGV4dGlkICYgMHgwMSkpICogKG10ZC0+d3JpdGVzaXplID4+IDkpOwo+ID4g
KwltdGQtPm9vYnNpemUgPSBtZW1vcmctPm9vYnNpemU7Cj4gPiAgIAlleHRpZCA+Pj0gMjsKPiA+
ICAgCS8qIENhbGMgYmxvY2tzaXplLiBCbG9ja3NpemUgaXMgbXVsdGlwbGVzIG9mIDY0S2lCICov
Cj4gPiArCW1lbW9yZy0+cGFnZXNfcGVyX2VyYXNlYmxvY2sgPSAoKDY0ICogMTAyNCkgPDwgKGV4
dGlkICYgMHgwMykpIC8KPiA+ICsJCQkJICAgICAgIG1lbW9yZy0+cGFnZXNpemU7Cj4gPiAgIAlt
dGQtPmVyYXNlc2l6ZSA9ICg2NCAqIDEwMjQpIDw8IChleHRpZCAmIDB4MDMpOwo+ID4gICAJZXh0
aWQgPj49IDI7Cj4gPiAgIAkvKiBHZXQgYnVzd2lkdGggaW5mb3JtYXRpb24gKi8KPiA+IEBAIC00
NTYxLDEyICs0NTcwLDE5IEBAIEVYUE9SVF9TWU1CT0xfR1BMKG5hbmRfZGVjb2RlX2V4dF9pZCk7
Cj4gPiAgIHN0YXRpYyB2b2lkIG5hbmRfZGVjb2RlX2lkKHN0cnVjdCBuYW5kX2NoaXAgKmNoaXAs
IHN0cnVjdCBuYW5kX2ZsYXNoX2RldiAqdHlwZSkKPiA+ICAgewo+ID4gICAJc3RydWN0IG10ZF9p
bmZvICptdGQgPSBuYW5kX3RvX210ZChjaGlwKTsKPiA+ICsJc3RydWN0IG5hbmRfbWVtb3J5X29y
Z2FuaXphdGlvbiAqbWVtb3JnOwo+ID4gICAKPiA+ICsJbWVtb3JnID0gbmFuZGRldl9nZXRfbWVt
b3JnKCZjaGlwLT5iYXNlKTsKPiA+ICsKPiA+ICsJbWVtb3JnLT5wYWdlc19wZXJfZXJhc2VibG9j
ayA9IHR5cGUtPmVyYXNlc2l6ZSAvIHR5cGUtPnBhZ2VzaXplOwo+ID4gICAJbXRkLT5lcmFzZXNp
emUgPSB0eXBlLT5lcmFzZXNpemU7Cj4gPiAtCW10ZC0+d3JpdGVzaXplID0gdHlwZS0+cGFnZXNp
emU7Cj4gPiAtCW10ZC0+b29ic2l6ZSA9IG10ZC0+d3JpdGVzaXplIC8gMzI7Cj4gPiArCW1lbW9y
Zy0+cGFnZXNpemUgPSB0eXBlLT5wYWdlc2l6ZTsKPiA+ICsJbXRkLT53cml0ZXNpemUgPSBtZW1v
cmctPnBhZ2VzaXplOwo+ID4gKwltZW1vcmctPm9vYnNpemUgPSBtZW1vcmctPnBhZ2VzaXplIC8g
MzI7Cj4gPiArCW10ZC0+b29ic2l6ZSA9IG1lbW9yZy0+b29ic2l6ZTsKPiA+ICAgCj4gPiAgIAkv
KiBBbGwgbGVnYWN5IElEIE5BTkQgYXJlIHNtYWxsLXBhZ2UsIFNMQyAqLwo+ID4gKwltZW1vcmct
PmJpdHNfcGVyX2NlbGwgPSAxOwo+ID4gICAJY2hpcC0+Yml0c19wZXJfY2VsbCA9IDE7Cj4gPiAg
IH0KPiA+ICAgCj4gPiBAQCAtNDU5NSwxMyArNDYxMSwyMSBAQCBzdGF0aWMgYm9vbCBmaW5kX2Z1
bGxfaWRfbmFuZChzdHJ1Y3QgbmFuZF9jaGlwICpjaGlwLAo+ID4gICAJCQkgICAgICBzdHJ1Y3Qg
bmFuZF9mbGFzaF9kZXYgKnR5cGUpCj4gPiAgIHsKPiA+ICAgCXN0cnVjdCBtdGRfaW5mbyAqbXRk
ID0gbmFuZF90b19tdGQoY2hpcCk7Cj4gPiArCXN0cnVjdCBuYW5kX21lbW9yeV9vcmdhbml6YXRp
b24gKm1lbW9yZzsKPiA+ICAgCXU4ICppZF9kYXRhID0gY2hpcC0+aWQuZGF0YTsKPiA+ICAgCj4g
PiArCW1lbW9yZyA9IG5hbmRkZXZfZ2V0X21lbW9yZygmY2hpcC0+YmFzZSk7Cj4gPiArCj4gPiAg
IAlpZiAoIXN0cm5jbXAodHlwZS0+aWQsIGlkX2RhdGEsIHR5cGUtPmlkX2xlbikpIHsKPiA+IC0J
CW10ZC0+d3JpdGVzaXplID0gdHlwZS0+cGFnZXNpemU7Cj4gPiArCQltZW1vcmctPnBhZ2VzaXpl
ID0gdHlwZS0+cGFnZXNpemU7Cj4gPiArCQltdGQtPndyaXRlc2l6ZSA9IG1lbW9yZy0+cGFnZXNp
emU7Cj4gPiArCQltZW1vcmctPnBhZ2VzX3Blcl9lcmFzZWJsb2NrID0gdHlwZS0+ZXJhc2VzaXpl
IC8KPiA+ICsJCQkJCSAgICAgICB0eXBlLT5lcmFzZXNpemU7ICAKPiAKPiBUaGlzIHNob3VsZCBi
ZToKPiAJCW1lbW9yZy0+cGFnZXNfcGVyX2VyYXNlYmxvY2sgPSB0eXBlLT5lcmFzZXNpemUgLwo+
IAkJCQkJICAgICAgIHR5cGUtPnBhZ2VzaXplOwoKR29vZCBjYXRjaCEKCkkgd2lsbCBjb3JyZWN0
IHRoYXQsIGFuZCBhbHNvIGNsZWFuIHRoZSBtaXhlZCBkZWNsYXJhdGlvbnMgYmV0d2VlbgpwYXRj
aCA3IGFuZCBwYXRjaCAxMyB5b3Ugc3BvdHRlZC4KClRoYW5rcywKTWlxdcOobAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
