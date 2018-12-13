Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A295EC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:46:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7195620849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mtxt63Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7195620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dva9MQm6fdXF0BrHUHuPjL4uqoQ87EAkej6nczDnUMI=; b=mtxt63MtwXOvE1ID6cNMZ5Q+kK
	eaExT62LIlT9pAgniq/cj0hjRXbxrvS26vggAF32DoMt+193plMYhVqEmqMBf124lWaEqQKg7aCUK
	ngs8TdMpkWxJ6YBxIVdNXXG+q+pCvYhHpY1QZwX9c1vyfj5qQOWNtTk3w1K7IOaAT7IrUsTu/WyJE
	VQphITavtIdNRPIKtxbrtoLksZsKZbEgEwo0OpJcPa5Yy3BUl30uWSMlzMdriV4Eh1e0aOiU1p9CZ
	20ykWybo2UUbceJjGQMRbN91exrDZgz7EduxD74p37DsCbNiFahq9iPmrj5zDEmFGgB77GlKlNKGR
	ZiwVeuKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXMde-0000BD-PH; Thu, 13 Dec 2018 08:46:34 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXMdZ-0000AU-Ui
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 08:46:32 +0000
Received: from tarshish (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id C4DD044083B;
 Thu, 13 Dec 2018 10:46:17 +0200 (IST)
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
 <87zht96e15.fsf@tkos.co.il>
 <AM0PR0402MB357061ADF5FAFD253C1A5B8A8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
User-agent: mu4e 1.0; emacs 25.2.2
From: Baruch Siach <baruch@tkos.co.il>
To: Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
In-reply-to: <AM0PR0402MB357061ADF5FAFD253C1A5B8A8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
Date: Thu, 13 Dec 2018 10:46:17 +0200
Message-ID: <87y38t6ch2.fsf@tkos.co.il>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_004630_444159_602E939F 
X-CRM114-Status: GOOD (  17.52  )
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
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUmljaGFyZCwKClJpY2hhcmQgWmh1IHdyaXRlczoKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0KPj4gRnJvbTogQmFydWNoIFNpYWNoIFttYWlsdG86YmFydWNoQHRrb3MuY28uaWxdCj4+
IFNlbnQ6IDIwMTjlubQxMuaciDEz5pelIDE2OjEzCj4+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hp
bmcuemh1QG54cC5jb20+Cj4+IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tOwo+PiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBhbmRyZXcuc21pcm5vdkBn
bWFpbC5jb207Cj4+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7Cj4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+PiBT
dWJqZWN0OiBSZTogW3YyXSBQQ0k6IGlteDogbWFrZSBtc2kgd29yayB3aXRob3V0IHBjaWVwb3J0
YnVzCj4+Cj4+IFJpY2hhcmQgWmh1IHdyaXRlczoKPj4gPiBNU0lfRU4gb2YgaU1YIFBDSWUgUkMg
d291bGQgYmUgYXNzZXJ0ZWQgd2hlbiBQQ0lFUE9SVEJVUyBkcml2ZXIgaXMKPj4gPiBzZWxlY3Rl
ZC4KPj4gPiBUaHVzLCB0aGUgTVNJIHdvcmtzIGZpbmUgb24gaU1YIFBDSWUgYmVmb3JlLgo+PiA+
IEFzc2VydCBpdCB1bmNvbmRpdGlvbmFsbHkgd2hlbiBNU0kgaXMgc3VwcG9ydGVkLgo+PiA+IE90
aGVyd2lzZSwgdGhlIE1TSSB3b3VsZG4ndCBiZSB0cmlnZ2VyZWQgYWx0aG91Z2ggdGhlIEVQIGlz
IHByZXNlbnQKPj4gPiBhbmQgdGhlIE1TSXMgYXJlIGFzc2lnbmVkLgo+PiA+Cj4+ID4gU2lnbmVk
LW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPgo+PiA+IC0tLQo+PiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgNyArKysrKysrCj4+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPj4gPgo+PiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jCj4+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jCj4+ID4gaW5kZXggMjYwODdiMy4uZDNlNDI5NiAxMDA2
NDQKPj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jCj4+ID4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYwo+PiA+IEBAIC03NCw2
ICs3NCw3IEBAIHN0cnVjdCBpbXg2X3BjaWUgewo+PiA+ICAjZGVmaW5lIFBIWV9QTExfTE9DS19X
QUlUX1VTTEVFUF9NQVgJMjAwCj4+ID4KPj4gPiAgLyogUENJZSBSb290IENvbXBsZXggcmVnaXN0
ZXJzIChtZW1vcnktbWFwcGVkKSAqLwo+PiA+ICsjZGVmaW5lIFBDSV9NU0lfQ0FQCQkJCTB4NTAK
Pj4gPiAgI2RlZmluZSBQQ0lFX1JDX0xDUgkJCQkweDdjCj4+ID4gICNkZWZpbmUgUENJRV9SQ19M
Q1JfTUFYX0xJTktfU1BFRURTX0dFTjEJMHgxCj4+ID4gICNkZWZpbmUgUENJRV9SQ19MQ1JfTUFY
X0xJTktfU1BFRURTX0dFTjIJMHgyCj4+ID4gQEAgLTkyNiw2ICs5MjcsNyBAQCBzdGF0aWMgaW50
IGlteDZfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlCj4+ICpwZGV2KQo+PiA+ICAJ
c3RydWN0IHJlc291cmNlICpkYmlfYmFzZTsKPj4gPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9k
ZSA9IGRldi0+b2Zfbm9kZTsKPj4gPiAgCWludCByZXQ7Cj4+ID4gKwl1MTYgdmFsOwo+PiA+Cj4+
ID4gIAlpbXg2X3BjaWUgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmlteDZfcGNpZSksIEdG
UF9LRVJORUwpOwo+PiA+ICAJaWYgKCFpbXg2X3BjaWUpCj4+ID4gQEAgLTEwNzAsNiArMTA3Miwx
MSBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShzdHJ1Y3QKPj4gcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQo+PiA+ICAJcmV0ID0gaW14Nl9hZGRfcGNpZV9wb3J0KGlteDZfcGNpZSwgcGRldik7
Cj4+ID4gIAlpZiAocmV0IDwgMCkKPj4gPiAgCQlyZXR1cm4gcmV0Owo+PiA+ICsJaWYgKElTX0VO
QUJMRUQoQ09ORklHX1BDSV9NU0kpKSB7Cj4+Cj4+IENPTkZJR19QQ0lfSU1YNiBkZXBlbmRzIG9u
IENPTkZJR19QQ0lfTVNJX0lSUV9ET01BSU4gdGhhdCBpbiB0dXJuCj4+IGRlcGVuZHMgb24gQ09O
RklHX1BDSV9NU0kuIFNvIHRoaXMgY29uZGl0aW9uIHNob3VsZCBhbHdheXMgYmUgdHJ1ZS4gSWYg
c28sCj4+IHlvdSBjYW4gZHJvcCB0aGlzIG9uZSBhcyB3ZWxsLgo+IFtSaWNoYXJkIFpodV0gVGhh
bmtzLgo+IENhbiB3ZSBoYXZlIHRoZSBkb3VibGUgY2hlY2sgaGVyZT8KPiBUaHVzLCBpdCdzIGFs
aWduZWQgdG8gdGhlIE1TSSBlbmFibGUgY29kZXMgaW4gdGhlIG90aGVyIHBsYWNlIG9mIHRoZSBk
cml2ZXIuCj4gRm9yIGV4YW1wbGU6Cj4gLi4uCj4gCSAgICAgICAgaWYgKElTX0VOQUJMRUQoQ09O
RklHX1BDSV9NU0kpKQo+ICAgICAgICAgICAgICAgICBkd19wY2llX21zaV9pbml0KHBwKTsKPiAu
Li4KPiBTZWNvbmRseSwgdGhlIGRyaXZlciBoYXMgYSBiZXR0ZXIgcG9ydGFiaWxpdHkgd2l0aCB0
aGUgZG91YmxlIGNoZWNrIGhlcmUuCj4gSG93IGRvIHlvdSB0aGluayBhYm91dCBpdD8KCktlcm5l
bCBkcml2ZXIgYXJlIG5vdCBtZWFudCB0byBiZSAicG9ydGFibGUiIGFzIGZhciBhcyBJIHVuZGVy
c3RhbmQuIEJ1dApJJ2xsIGxldCB0aGUgUENJIG1haW50YWluZXJzIGNvbW1lbnQgb24gdGhhdC4g
Rm9yIHJlZmVyZW5jZSwgbWFpbmxpbmUKa2VybmVsIG1ha2VzIENPTkZJR19QQ0lfTVNJIGEgaGFy
ZCBkZXBlbmRlbmN5IG9mIHBjaS1pbXg2IHNpbmNlIGNvbW1pdAozZWU4MDM2NDFlNzYgKCJQQ0kv
TVNJOiBpcnFjaGlwOiBGaXggUENJX01TSSBkZXBlbmRlbmNpZXMiKSBpbiB2NC44LgoKSW4gbXkg
b3BpbmlvbiwgaWYgdGhlIGRyaXZlciBhY3R1YWxseSBjb21waWxlcyBhbmQgaXMgdXNhYmxlIHdp
dGhvdXQKQ09ORklHX1BDSV9NU0kgdGhlbiBLY29uZmlnIGRlcGVuZGVuY2llcyBzaG91bGQgcmVm
bGVjdCB0aGF0LgoKPj4gPiArCQl2YWwgPSBkd19wY2llX3JlYWR3X2RiaShwY2ksIFBDSV9NU0lf
Q0FQICsgUENJX01TSV9GTEFHUyk7Cj4+ID4gKwkJdmFsIHw9IFBDSV9NU0lfRkxBR1NfRU5BQkxF
Owo+PiA+ICsJCWR3X3BjaWVfd3JpdGV3X2RiaShwY2ksIFBDSV9NU0lfQ0FQICsgUENJX01TSV9G
TEFHUywgdmFsKTsKPj4gPiArCX0KPj4gPgo+PiA+ICAJcmV0dXJuIDA7Cj4+ID4gIH0KCmJhcnVj
aAoKLS0KICAgICBodHRwOi8vYmFydWNoLnNpYWNoLm5hbWUvYmxvZy8gICAgICAgICAgICAgICAg
ICB+LiAufiAgIFRrIE9wZW4gU3lzdGVtcwo9fS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLW9vTy0tVS0tT29vLS0tLS0tLS0tLS0tez0KICAgLSBiYXJ1Y2hA
dGtvcy5jby5pbCAtIHRlbDogKzk3Mi41Mi4zNjguNDY1NiwgaHR0cDovL3d3dy50a29zLmNvLmls
IC0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
