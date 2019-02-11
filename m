Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3C3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:58:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E32621B69
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q5FAdgJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E32621B69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6qt8Ib9keLD40/e1PThtDLjN0EIgXDUm+i+RRpaBfZM=; b=q5FAdgJg3hJ6I6
	sut2jbSZrIDsPvTvzUDN4zIYLiZ5g9IieU1i0ZtG7joWADKdPestC9XBkMDvIb5QD+ZnkHByHkhBG
	Yq6pvW7CGJ9mMYDd3850AE6xM2lwM7xCB80EsxIrLNvtFNTspx/2eZ5VLFHuPQaRMFHp0NVQorahm
	GBTnRA3szUceVqAR8V5NGFk3YjvGA4aQP8Hb+vqAOGBasSj8hE5jA3lCqwaAI2Tz8P8pvP2oYGz6s
	wmRqNSVhF/h63iILpCU63jpsHAone8wQlZvSCcqn9xWHfceQW9dDISQ4a6G/4wTqEUD/Smmb2G2Fk
	sZb0fmcbvzY0e7MaPiXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtEuC-00012g-7z; Mon, 11 Feb 2019 16:58:04 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtEu9-00011w-AI
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 16:58:03 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gtEu1-0001Y3-N8; Mon, 11 Feb 2019 17:57:53 +0100
Message-ID: <1549904273.2546.16.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] pci: imx6: support kernels built in Thumb-2 mode
From: Lucas Stach <l.stach@pengutronix.de>
To: Stefan Agner <stefan@agner.ch>, hongxing.zhu@nxp.com
Date: Mon, 11 Feb 2019 17:57:53 +0100
In-Reply-To: <20181204132733.14422-2-stefan@agner.ch>
References: <20181204132733.14422-1-stefan@agner.ch>
 <20181204132733.14422-2-stefan@agner.ch>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_085801_537307_2B00FB2B 
X-CRM114-Status: GOOD (  18.48  )
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
Cc: lorenzo.pieralisi@arm.com, andrew.smirnov@gmail.com, robin.murphy@arm.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, leonard.crestez@nxp.com, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org, tpiepho@impinj.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRGllbnN0YWcsIGRlbiAwNC4xMi4yMDE4LCAxNDoyNyArMDEwMCBzY2hyaWViIFN0ZWZhbiBB
Z25lcjoKPiBBZGQgYSBmYXVsdCBoYW5kbGVyIHdoaWNoIGhhbmRsZXMgaW1tZWRpYXRlIHJlYWRz
IGluIFRodW1iLTIKPiBtb2RlLiBJbnN0YWxsIHRoZSBhcHByb3ByaWF0ZSBoYW5kbGVyIGRlcGVu
ZGluZyBvbiB3aGljaCBtb2RlCj4gdGhlIGtlcm5lbCBoYXMgYmVlbiBidWlsdC4gVGhpcyBhdm9p
ZHMgYW4gIlVuaGFuZGxlZCBmYXVsdDoKPiBleHRlcm5hbCBhYm9ydCBvbiBub24tbGluZWZldGNo
ICgweDEwMDgpIGF0IDB4ZjBhODAwMDAiCj4gZHVyaW5nIGJvb3Qgb24gYSBkZXZpY2Ugd2l0aCBh
IFBDSWUgc3dpdGNoIGNvbm5lY3RlZC4KPiAKPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1wY2kvMjAxODExMjYxNjE2NDUuODE3Ny0xLXN0ZWZhbkBhZ25lci5jaC8KPiBTaWdu
ZWQtb2ZmLWJ5OiBTdGVmYW4gQWduZXIgPHN0ZWZhbkBhZ25lci5jaD4KCkFja2VkLWJ5OiBMdWNh
cyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KCj4gLS0tCj4gQ2hhbmdlcyBzaW5jZSB2
MToKPiAtIEFkZGVkIFRodW1iLTIgMzItYml0IGluc3RydWN0aW9uIHN1cHBvcnQgKHRlc3RlZCBi
eSBpbnNlcnRpbmcgLncKPiDCoCBpbnN0cnVjdGlvbnMgaW4gYXJjaC9hcm0vaW5jbHVkZS9hc20v
aW8uaCkKPiAtIEF2b2lkIGRlcmVmZXJlbmNpbmcgaWYgZmF1bHQgaGFwcGVuZWQgaW4gdXNlciBt
b2RlCj4gCj4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgNTkgKysr
KysrKysrKysrKysrKysrKysrKysrKystCj4gwqAxIGZpbGUgY2hhbmdlZCwgNTggaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Ywo+IGluZGV4IDU0YTI5ZTQ0MTMwMy4uYTliYmJmMTc2YzRhIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMKPiArKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jCj4gQEAgLTI5LDYgKzI5LDcgQEAKPiDCoCNpbmNsdWRlIDxs
aW51eC9yZXNldC5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L3BtX2RvbWFpbi5oPgo+IMKgI2luY2x1
ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4KPiArI2luY2x1ZGUgPGFzbS9vcGNvZGVzLmg+Cj4gwqAK
PiDCoCNpbmNsdWRlICJwY2llLWRlc2lnbndhcmUuaCIKPiDCoAo+IEBAIC0zMDUsNiArMzA2LDU5
IEBAIHN0YXRpYyBpbnQgaW14NnFfcGNpZV9hYm9ydF9oYW5kbGVyKHVuc2lnbmVkIGxvbmcgYWRk
ciwKPiDCoAlyZXR1cm4gMTsKPiDCoH0KPiDCoAo+ICtzdGF0aWMgaW50IGlteDZxX3BjaWVfYWJv
cnRfaGFuZGxlcl90aHVtYjIodW5zaWduZWQgbG9uZyBhZGRyLAo+ICsJCXVuc2lnbmVkIGludCBm
c3IsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQo+ICt7Cj4gKwl1bnNpZ25lZCBsb25nIHBjID0gaW5z
dHJ1Y3Rpb25fcG9pbnRlcihyZWdzKTsKPiArCXVuc2lnbmVkIGxvbmcgaW5zdHI7Cj4gKwo+ICsJ
aWYgKHVzZXJfbW9kZShyZWdzKSkKPiArCQlyZXR1cm4gMTsKPiArCj4gKwlpbnN0ciA9IF9fbWVt
X3RvX29wY29kZV90aHVtYjMyKCoodW5zaWduZWQgbG9uZyAqKXBjKTsKPiArCj4gKwlpZiAoX19v
cGNvZGVfaXNfdGh1bWIzMihpbnN0cikpIHsKPiArCQkvKiBMb2FkIHdvcmQvYnl0ZSBhbmQgaGFs
ZndvcmQgaW1tZWRpYXRlIG9mZnNldCAqLwo+ICsJCWlmICgoaW5zdHIgJiAweGZmMTAwMDAwVUwp
ID09IDB4ZjgxMDAwMDBVTCkgewo+ICsJCQlpbnQgcmVnID0gKGluc3RyID4+IDEyKSAmIDB4ZjsK
PiArCQkJdW5zaWduZWQgbG9uZyB2YWw7Cj4gKwo+ICsJCQlpZiAoKGluc3RyICYgMHgwMDcwMDAw
MFVMKSA9PSAweDAwMTAwMDAwVUwpCj4gKwkJCQl2YWwgPSAweGZmOwo+ICsJCQllbHNlIGlmICgo
aW5zdHIgJiAweDAwNzAwMDAwVUwpID09IDB4MDAzMDAwMDBVTCkKPiArCQkJCXZhbCA9IDB4ZmZm
ZjsKPiArCQkJZWxzZQo+ICsJCQkJdmFsID0gMHhmZmZmZmZmZlVMOwo+ICsKPiArCQkJcmVncy0+
dXJlZ3NbcmVnXSA9IHZhbDsKPiArCQkJcmVncy0+QVJNX3BjICs9IDQ7Cj4gKwkJCXJldHVybiAw
Owo+ICsJCX0KPiArCX0gZWxzZSB7Cj4gKwkJaW5zdHIgPSBfX21lbV90b19vcGNvZGVfdGh1bWIx
NigqKHVuc2lnbmVkIGxvbmcgKilwYyk7Cj4gKwo+ICsJCS8qIExvYWQgd29yZC9ieXRlIGFuZCBo
YWxmd29yZCBpbW1lZGlhdGUgb2Zmc2V0ICovCj4gKwkJaWYgKCgoaW5zdHIgJiAweGU4MDApID09
IDB4NjgwMCkgfHwKPiArCQnCoMKgwqDCoCgoaW5zdHIgJiAweGY4MDApID09IDB4ODgwMCkpIHsK
PiArCQkJaW50IHJlZyA9IGluc3RyICYgMHg3Owo+ICsJCQl1bnNpZ25lZCBsb25nIHZhbDsKPiAr
Cj4gKwkJCWlmIChpbnN0ciAmIDB4MTAwMCkKPiArCQkJCXZhbCA9IDB4ZmY7Cj4gKwkJCWVsc2Ug
aWYgKGluc3RyICYgMHg4MDAwKQo+ICsJCQkJdmFsID0gMHhmZmZmOwo+ICsJCQllbHNlCj4gKwkJ
CQl2YWwgPSAweGZmZmZmZmZmVUw7Cj4gKwo+ICsJCQlyZWdzLT51cmVnc1tyZWddID0gdmFsOwo+
ICsJCQlyZWdzLT5BUk1fcGMgKz0gMjsKPiArCQkJcmV0dXJuIDA7Cj4gKwkJfQo+ICsJfQo+ICsK
PiArCXJldHVybiAxOwo+ICt9Cj4gKwo+IMKgc3RhdGljIGludCBpbXg2X3BjaWVfYXR0YWNoX3Bk
KHN0cnVjdCBkZXZpY2UgKmRldikKPiDCoHsKPiDCoAlzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3Bj
aWUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKPiBAQCAtMTA3NSw2ICsxMTI5LDggQEAgc3RhdGlj
IHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaW14Nl9wY2llX2RyaXZlciA9IHsKPiDCoAo+IMKgc3Rh
dGljIGludCBfX2luaXQgaW14Nl9wY2llX2luaXQodm9pZCkKPiDCoHsKPiArCWJvb2wgdGh1bWIy
ID0gSVNfRU5BQkxFRChDT05GSUdfVEhVTUIyX0tFUk5FTCk7Cj4gKwo+IMKgCS8qCj4gwqAJwqAq
IFNpbmNlIHByb2JlKCkgY2FuIGJlIGRlZmVycmVkIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQK
PiDCoAnCoCogaG9va19mYXVsdF9jb2RlIGlzIG5vdCBjYWxsZWQgYWZ0ZXIgX19pbml0IG1lbW9y
eSBpcyBmcmVlZAo+IEBAIC0xMDgyLDcgKzExMzgsOCBAQCBzdGF0aWMgaW50IF9faW5pdCBpbXg2
X3BjaWVfaW5pdCh2b2lkKQo+IMKgCcKgKiB3ZSBjYW4gaW5zdGFsbCB0aGUgaGFuZGxlciBoZXJl
IHdpdGhvdXQgcmlza2luZyBpdAo+IMKgCcKgKiBhY2Nlc3Npbmcgc29tZSB1bmluaXRpYWxpemVk
IGRyaXZlciBzdGF0ZS4KPiDCoAnCoCovCj4gLQlob29rX2ZhdWx0X2NvZGUoOCwgaW14NnFfcGNp
ZV9hYm9ydF9oYW5kbGVyLCBTSUdCVVMsIDAsCj4gKwlob29rX2ZhdWx0X2NvZGUoOCwgdGh1bWIy
ID8gaW14NnFfcGNpZV9hYm9ydF9oYW5kbGVyX3RodW1iMiA6Cj4gKwkJCWlteDZxX3BjaWVfYWJv
cnRfaGFuZGxlciwgU0lHQlVTLCAwLAo+IMKgCQkJImV4dGVybmFsIGFib3J0IG9uIG5vbi1saW5l
ZmV0Y2giKTsKPiDCoAo+IMKgCXJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmlteDZf
cGNpZV9kcml2ZXIpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
