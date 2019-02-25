Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A44C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:49:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FAF20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H1NUK1Hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FAF20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JWjMS2/ilIzmrt5tvK5e9rw1ggs9QjZadFsRH1+tVnw=; b=H1NUK1HyQ9lqVQ
	nh9R2HAwEqfE+QvJRcwFr7MeYb0hduNtKrr2/sU0LQ3OZfq0MDxvj+f5kKEkqCnfszdvRrZUvgq8e
	Q5mhn3ogYFhMRXOzGh4Mrhya2L0W89qCy+OKOLwUmj7Lv0X1dt64lzY58Y2u7VahDpos3t500VSVX
	XNNpoLAmit36xaoBfZ/EBsk71BSa2BoNm3uLSKe34093lSclnx7q0lCFX+3PgZpPPid+CShUe2Mhs
	m06oC1v01l5P+LiSMjO4VBsVihKs2t9PUw7arSGoiJ2Q1Hkvi5ky3vcla6FfU8gojAzs1J8JZPDNm
	FAyB2Exns46IavhYgHqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyIVs-0001GQ-Ea; Mon, 25 Feb 2019 15:49:52 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIVo-0001Fa-Hc; Mon, 25 Feb 2019 15:49:50 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 65E0320011;
 Mon, 25 Feb 2019 15:49:34 +0000 (UTC)
Date: Mon, 25 Feb 2019 16:49:33 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 20/27] mtd: nand: Let software ECC engines be
 retrieved from the NAND core
Message-ID: <20190225164933.4b0e1489@xps13>
In-Reply-To: <20190222152957.737a8c5c@kernel.org>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-8-miquel.raynal@bootlin.com>
 <20190222152957.737a8c5c@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_074948_879404_AFBC5563 
X-CRM114-Status: GOOD (  21.79  )
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
b24gRnJpLCAyMiBGZWIgMjAxOQoxNToyOTo1NyArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMzo1Nzo1OSArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+ID4gQmVmb3JlIG1ha2luZyB1c2Ugb2YgdGhlIEVDQyBlbmdpbmVzLCB3
ZSBtdXN0IHJldHJpZXZlIHRoZW0uIEFkZCB0aGUKPiA+IGJvaWxlcnBsYXRlIGZvciB0aGUgb25l
cyBhbHJlYWR5IGF2YWlsYWJsZTogc29mdHdhcmUgZW5naW5lcyAoSGFtbWluZwo+ID4gYW5kIEJD
SCkuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxA
Ym9vdGxpbi5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL210ZC9uYW5kL2VjYy9lbmdpbmUuYyAg
ICAgICAgICAgICAgfCAxNCArKysrKysrKysrKysrKwo+ID4gIGluY2x1ZGUvbGludXgvbXRkL25h
bmQtc3ctYmNoLWVuZ2luZS5oICAgICB8ICAzICsrKwo+ID4gIGluY2x1ZGUvbGludXgvbXRkL25h
bmQtc3ctaGFtbWluZy1lbmdpbmUuaCB8ICAzICsrKwo+ID4gIGluY2x1ZGUvbGludXgvbXRkL25h
bmQuaCAgICAgICAgICAgICAgICAgICB8ICAzICsrKwo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjMg
aW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9lY2Mv
ZW5naW5lLmMgYi9kcml2ZXJzL210ZC9uYW5kL2VjYy9lbmdpbmUuYwo+ID4gaW5kZXggN2RkM2Y5
NzcyNjk4Li4zMThkYmIyZDU2YTIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL2Vj
Yy9lbmdpbmUuYwo+ID4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9lY2MvZW5naW5lLmMKPiA+IEBA
IC0yODYsNiArMjg2LDIwIEBAIGJvb2wgbmFuZF9lY2NfY29ycmVjdGlvbl9pc19lbm91Z2goc3Ry
dWN0IG5hbmRfZGV2aWNlICpuYW5kKQo+ID4gIAlyZXR1cm4gY29yciA+PSBkc19jb3JyICYmIGNv
bmYtPnN0cmVuZ3RoID49IHJlcXMtPnN0cmVuZ3RoOwo+ID4gIH0KPiA+ICAKPiA+ICtzdHJ1Y3Qg
bmFuZF9lY2NfZW5naW5lICpuYW5kX2VjY19zd19nZXRfZW5naW5lKHN0cnVjdCBuYW5kX2Rldmlj
ZSAqbmFuZCkgIAo+IAo+IFdoYXQgaWYgeW91IHdhbnQgdG8gaW5zdGFudGlhdGUgU1cgRUNDIHdp
dGggYSBjdXN0b20gbGF5b3V0PyBDYW4ndCB3ZQo+IGluc3RlYWQgaGF2ZSBhIGZ1bmN0aW9uIHRo
YXQgY3JlYXRlIGEgbmV3IGVuZ2luZSBkeW5hbWljYWxseT8KPiAKPiBzdHJ1Y3QgbmFuZF9lY2Nf
ZW5naW5lICoKPiBuYW5kX2VjY19jcmVhdGVfc3dfZW5naW5lKHN0cnVjdCBuYW5kX2RldmljZSog
bmFuZCwKPiAJCQkgIGVudW0gbmFuZF9lY2NfYWxnbyBhbGdvLAo+IAkJCSAgc3RydWN0IG10ZF9v
b2JsYXlvdXQgKmxheW91dCk7Cj4gCj4gCgpSaWdodCBub3csIGZvciBib3RoIHN3IGVuZ2luZXMs
IGEgZGVmYXVsdCBsYXlvdXQgaXMgYXBwbGllZCBpZiB0aGVyZSBpcwpub25lIGF0IGVuZ2luZSBp
bml0aWFsaXphdGlvbiB0aW1lLgoKQWxzbywgZG8gd2UgcmVhbGx5IG5lZWQgYSAiY3JlYXRlIiBo
ZWxwZXI/IEkgZG9uJ3Qgc2VlIHdoYXQncyBjcmVhdGVkCnRoZXJlLiBNYXliZSB5b3UgaGFkIHNv
bWV0aGluZyBlbHNlIGluIG1pbmQsIGFuZCB0aGUKZWNjX3N3X3h4eF9nZXRfZW5naW5lKCkgYXBw
cm9hY2ggZG8gbm90IG1hdGNoIHdoYXQgeW91IGV4cGVjdGVkLCBzbwpwbGVhc2UgdGVsbCBtZSBt
b3JlIGFib3V0IHlvdXIgaWRlYSwgb3RoZXJ3aXNlIEkgZG9uJ3Qgc2VlIHdoYXQgYQpuYW5kX2Vj
Y19jcmVhdGVfc3dfZW5naW5lKCkgd291bGQgYnJpbmcuCgo+IAo+ID4gK3sKPiA+ICsJc3dpdGNo
IChuYW5kLT5lY2MudXNlcl9jb25mLmFsZ28pIHsgIAo+IAo+IE5vdGUgdGhhdCB0aGUgY29uZiBp
cyBzdXBwb3NlZCB0byBiZSBwYXNzZWQgYWZ0ZXJ3YXJkcywgd2hlbiB0aGUgY3R4IGlzCj4gY3Jl
YXRlZCwgc28geW91IHNob3VsZCBjaGVjayBuYW5kLT5lY2MudXNlcl9jb25mIGRpcmVjdGx5IGhl
cmUuCgpJIHRoaW5rIHRoaXMgaXMgd2hhdCBJIGRvIHNvIEkgc3VzcGVjdCB0aGUgYWJvdmUgc2Vu
dGVuY2UgaXMgbm90IHdoYXQKeW91IGFjdHVhbGx5IG1lYW50PwoKPiAKPiA+ICsJY2FzZSBOQU5E
X0VDQ19IQU1NSU5HOgo+ID4gKwkJcmV0dXJuIGVjY19zd19oYW1taW5nX2dldF9lbmdpbmUoKTsK
PiA+ICsJY2FzZSBOQU5EX0VDQ19CQ0g6Cj4gPiArCQlyZXR1cm4gZWNjX3N3X2JjaF9nZXRfZW5n
aW5lKCk7Cj4gPiArCWRlZmF1bHQ6Cj4gPiArCQlicmVhazsKPiA+ICsJfQo+ID4gKwo+ID4gKwly
ZXR1cm4gTlVMTDsKPiA+ICt9Cj4gPiArCj4gPiAgTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwo+
ID4gIE1PRFVMRV9BVVRIT1IoIk1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+Iik7Cj4gPiAgTU9EVUxFX0RFU0NSSVBUSU9OKCJHZW5lcmljIEVDQyBlbmdpbmUiKTsKPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L210ZC9uYW5kLXN3LWJjaC1lbmdpbmUuaCBiL2lu
Y2x1ZGUvbGludXgvbXRkL25hbmQtc3ctYmNoLWVuZ2luZS5oCj4gPiBpbmRleCBlNDA2YWE1M2Vj
NGUuLjM4Y2RhZDExN2ZlYSAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL25hbmQt
c3ctYmNoLWVuZ2luZS5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L210ZC9uYW5kLXN3LWJjaC1l
bmdpbmUuaAo+ID4gQEAgLTExLDYgKzExLDkgQEAKPiA+ICAjaW5jbHVkZSA8bGludXgvbXRkL25h
bmQuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvYmNoLmg+Cj4gPiAgCj4gPiArLyogTmVlZGVkIGZv
ciBjcm9zcyBpbmNsdXNpb24gd2l0aCBuYW5kLmggKi8KPiA+ICtzdHJ1Y3QgbmFuZF9kZXZpY2U7
Cj4gPiArCj4gPiAgLyoqCj4gPiAgICogc3RydWN0IGVjY19zd19iY2hfY29uZiAtIHByaXZhdGUg
c29mdHdhcmUgQkNIIEVDQyBlbmdpbmUgc3RydWN0dXJlCj4gPiAgICogQHJlcW9vYmxlbjogU2F2
ZSB0aGUgYWN0dWFsIHVzZXIgT09CIGxlbmd0aCByZXF1ZXN0ZWQgYmVmb3JlIG92ZXJ3cml0aW5n
IGl0Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tdGQvbmFuZC1zdy1oYW1taW5nLWVu
Z2luZS5oIGIvaW5jbHVkZS9saW51eC9tdGQvbmFuZC1zdy1oYW1taW5nLWVuZ2luZS5oCj4gPiBp
bmRleCA4ZGYzNmQxODk0ODIuLjUxYzVhMmFjZWU0MiAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUv
bGludXgvbXRkL25hbmQtc3ctaGFtbWluZy1lbmdpbmUuaAo+ID4gKysrIGIvaW5jbHVkZS9saW51
eC9tdGQvbmFuZC1zdy1oYW1taW5nLWVuZ2luZS5oCj4gPiBAQCAtMTIsNiArMTIsOSBAQAo+ID4g
IAo+ID4gICNpbmNsdWRlIDxsaW51eC9tdGQvbmFuZC5oPgo+ID4gIAo+ID4gKy8qIE5lZWRlZCBm
b3IgY3Jvc3MgaW5jbHVzaW9uIHdpdGggbmFuZC5oICovCj4gPiArc3RydWN0IG5hbmRfZGV2aWNl
Owo+ID4gKwo+ID4gIC8qKgo+ID4gICAqIHN0cnVjdCBlY2Nfc3dfaGFtbWluZ19jb25mIC0gcHJp
dmF0ZSBzb2Z0d2FyZSBIYW1taW5nIEVDQyBlbmdpbmUgc3RydWN0dXJlCj4gPiAgICogQHJlcW9v
YmxlbjogU2F2ZSB0aGUgYWN0dWFsIHVzZXIgT09CIGxlbmd0aCByZXF1ZXN0ZWQgYmVmb3JlIG92
ZXJ3cml0aW5nIGl0Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tdGQvbmFuZC5oIGIv
aW5jbHVkZS9saW51eC9tdGQvbmFuZC5oCj4gPiBpbmRleCA0NDgyZWIyYmJmZDQuLjNhYmUxMTNl
NGYwNiAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL25hbmQuaAo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC9tdGQvbmFuZC5oCj4gPiBAQCAtMTEsNiArMTEsOCBAQAo+ID4gICNkZWZp
bmUgX19MSU5VWF9NVERfTkFORF9ICj4gPiAgCj4gPiAgI2luY2x1ZGUgPGxpbnV4L210ZC9tdGQu
aD4KPiA+ICsjaW5jbHVkZSA8bGludXgvbXRkL25hbmQtc3ctaGFtbWluZy1lbmdpbmUuaD4KPiA+
ICsjaW5jbHVkZSA8bGludXgvbXRkL25hbmQtc3ctYmNoLWVuZ2luZS5oPgo+ID4gIAo+ID4gIHN0
cnVjdCBuYW5kX2RldmljZTsKPiA+ICAKPiA+IEBAIC0yNTMsNiArMjU1LDcgQEAgc3RydWN0IG5h
bmRfZWNjX2VuZ2luZSB7Cj4gPiAgfTsKPiA+ICAKPiA+ICB2b2lkIG5hbmRfZWNjX3JlYWRfdXNl
cl9jb25mKHN0cnVjdCBuYW5kX2RldmljZSAqbmFuZCk7Cj4gPiArc3RydWN0IG5hbmRfZWNjX2Vu
Z2luZSAqbmFuZF9lY2Nfc3dfZ2V0X2VuZ2luZShzdHJ1Y3QgbmFuZF9kZXZpY2UgKm5hbmQpOwo+
ID4gIGludCBuYW5kX2VjY19pbml0X2N0eChzdHJ1Y3QgbmFuZF9kZXZpY2UgKm5hbmQpOwo+ID4g
IHZvaWQgbmFuZF9lY2NfY2xlYW51cF9jdHgoc3RydWN0IG5hbmRfZGV2aWNlICpuYW5kKTsKPiA+
ICBpbnQgbmFuZF9lY2NfcHJlcGFyZV9pb19yZXEoc3RydWN0IG5hbmRfZGV2aWNlICpuYW5kLCAg
Cj4gCgoKCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
