Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD0C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:42:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825DA2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pVOS7KMu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+iDvewp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825DA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AWMNcGfy8X60Z+WV8u8XLpV+CMEby96Ug9/ytAZ0Wrg=; b=pVOS7KMuA/ZCOK
	R8MTvkHI6/x4diJeLxOSVRaeAgHIxdJg7erHkCU2IeYAA2CPtyc1lFuPoCTUgnL22YwPGctoTtnpD
	DYV6xImj6LloW1TTlQHgbD7cwPynmaLAp+TB3LOVXyyUm2NVzVKveDXUHQNwrYPcvXdlEH/GnMP/H
	AMsdqza8uQQLlnXzp5HBr9HNUoVkkgCxvCkgGMTyTdrFpjWHhodra8/8qTU8XS3u727Xzfz9szDRq
	MzUoVa4pQmGI9YuR4luaqyJjbgf7+C/hvRrBT99CTqp2CARAH41/qRlNHafMJU3vOzOryLmxS02AP
	s6zk4PfYQuarewcsbDuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkpwl-0001uY-PI; Sat, 19 Jan 2019 12:41:59 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkpwi-0001u8-29
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 12:41:57 +0000
Received: by mail-qk1-x744.google.com with SMTP id c21so9592439qkl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc:content-transfer-encoding;
 bh=/uirWgwK8ZsYuq5sa25pACmo5AdHQzx9AC4knaBHxjA=;
 b=Q+iDvewpONpG4yAscot8519+fdhk/9LeVCfmANBKayAyD5N+dAJbbTkomUSKJ5C8iE
 dElmJCHP4FglP9LagzLUYGrzZEE9EjmpbuCKl69qAdzDWdAf/B6nev/XLWnixjUwnR+F
 n3FNgs18adeof9r4TXkbUMWiiXe2heaaPs9KMJGzoQ7wCQo/ilbHbxgXzEd1T+EGCvVI
 JO3tv5hbArLlXS2LMsn6oXgpW8yPR7ZKxpqXKvivm19lbB/LONx+/TMeGiTm030GQzSj
 XqojXGkLydv8pCwlHflcNNUehJ1sYvwTNCb3kgDemh6njLcawNVJk6XozQ7pKFFyBvTF
 xeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc:content-transfer-encoding;
 bh=/uirWgwK8ZsYuq5sa25pACmo5AdHQzx9AC4knaBHxjA=;
 b=M3cb4sABdFRG78I+Ji4Z9Un9PWJLZyaDblE5baN5ar8T9/cd4rxoWsJ2Zw2Ha4dVOF
 x5cUGcl9x0+vdABDJp6uMZ1bSkSWaSNNos0+vxdvYo7QTUOZvqn4zAKh0xmzmjdeSHt7
 RmLZbHZ5arwOGjl3Zvl9lBBSz1fcrrCsU+95wAcGPByDh+0j5bAgac9OzcOUg1Tk6sZd
 Fho0vg72I6Y6iR9H4jmrofjI6b2MZNWS3nhEBs7CnPJ9E5DKNltEKK1qAfL0hpw4GCfi
 UqZKBngyhg9BRqmHUqO14LdEG78PkTllOlbQZLIAmc73Ifx3vXe+OnINUI6AWqjaGt5N
 ljxQ==
X-Gm-Message-State: AJcUukcSX3+QyeOdCyWI3y37YwyrtMmT0wGFOF8mHr0lh3+Y/L+uIg0i
 DTZx7mnveMYhwQAsf2xX40lofdTmIC21gEoHbBg=
X-Google-Smtp-Source: ALg8bN6VHvrZJqzGPCIOG1jDRcV4aZdX0RcWo2FzftcmY27K1xXEgKmWUTP2xrTNwoxrV+sXn/OgaVoTO0dgFGC0X+Q=
X-Received: by 2002:ae9:c106:: with SMTP id z6mr18453415qki.197.1547901713589; 
 Sat, 19 Jan 2019 04:41:53 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c@eucas1p1.samsung.com>
 <20190118131639.17578-1-k.konieczny@partner.samsung.com>
 <20190118131639.17578-6-k.konieczny@partner.samsung.com>
In-Reply-To: <20190118131639.17578-6-k.konieczny@partner.samsung.com>
From: Chanwoo Choi <cwchoi00@gmail.com>
Date: Sat, 19 Jan 2019 21:41:17 +0900
Message-ID: <CAGTfZH2sKvJ+Tq=YD2Xb1ZDV9QD0C3gEVRvxzMvRj54pU+2vHA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] clk: samsung: exynos5433: add imem clocks
To: Kamil Konieczny <k.konieczny@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_044156_108485_D5DC5E1B 
X-CRM114-Status: GOOD (  14.24  )
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
Reply-To: cwchoi00@gmail.com
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgS2FtaWwsCgoyMDE564WEIDHsm5QgMTjsnbwgKOq4iCkg7Jik7ZuEIDEwOjE4LCBLYW1pbCBL
b25pZWN6bnkKPGsua29uaWVjem55QHBhcnRuZXIuc2Ftc3VuZy5jb20+64uY7J20IOyekeyEsToK
Pgo+IEFkZCBpbWVtIGNsb2NrcyBmb3IgZXh5bm9zNTQzMy4gVGhpcyB3aWxsIGVuYWJsZSB0byB1
c2UgY3J5cHRvIFNsaW0KPiBTZWN1cml0eSBTdWJTeXN0ZW0gKGluIHNob3J0IFNsaW1TU1MpIElQ
IGJsb2NrLgo+Cj4gU2lnbmVkLW9mZi1ieTogS2FtaWwgS29uaWVjem55IDxrLmtvbmllY3pueUBw
YXJ0bmVyLnNhbXN1bmcuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1leHlu
b3M1NDMzLmMgfCAzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFu
Z2VkLCAzMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvc2Ftc3Vu
Zy9jbGstZXh5bm9zNTQzMy5jIGIvZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGstZXh5bm9zNTQzMy5j
Cj4gaW5kZXggMjRjMzM2MGRiNjViLi5kYWUxYzk2ZGU5MzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9jbGsvc2Ftc3VuZy9jbGstZXh5bm9zNTQzMy5jCj4gKysrIGIvZHJpdmVycy9jbGsvc2Ftc3Vu
Zy9jbGstZXh5bm9zNTQzMy5jCj4gQEAgLTU0NjcsNiArNTQ2NywzNSBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHNhbXN1bmdfY211X2luZm8gY2FtMV9jbXVfaW5mbyBfX2luaXRjb25zdCA9IHsKPiAg
ICAgICAgIC5jbGtfbmFtZSAgICAgICAgICAgICAgID0gImFjbGtfY2FtMV80MDAiLAo+ICB9Owo+
Cj4gKy8qCj4gKyAqIFJlZ2lzdGVyIG9mZnNldCBkZWZpbml0aW9ucyBmb3IgQ01VX0lNRU0KPiAr
ICovCj4gKyNkZWZpbmUgRU5BQkxFX0FDTEtfSU1FTV9TTElNU1NTICAgICAgICAgICAgICAgMHgw
ODBjCj4gKyNkZWZpbmUgRU5BQkxFX1BDTEtfSU1FTV9TTElNU1NTICAgICAgICAgICAgICAgMHgw
OTA4Cj4gKwo+ICtzdGF0aWMgY29uc3QgdW5zaWduZWQgbG9uZyBpbWVtX2Nsa19yZWdzW10gX19p
bml0Y29uc3QgPSB7Cj4gKyAgICAgICBFTkFCTEVfQUNMS19JTUVNX1NMSU1TU1MsCj4gKyAgICAg
ICBFTkFCTEVfUENMS19JTUVNX1NMSU1TU1MsCj4gK307Cj4gKwo+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IHNhbXN1bmdfZ2F0ZV9jbG9jayBpbWVtX2dhdGVfY2xrc1tdIF9faW5pdGNvbnN0ID0gewo+
ICsgICAgICAgLyogRU5BQkxFX0FDTEtfSU1FTV9TTElNU1NTICovCj4gKyAgICAgICBHQVRFKENM
S19BQ0xLX1NMSU1TU1MsICJhY2xrX3NsaW1zc3MiLCAiYWNsa19pbWVtX3Nzc3hfMjY2IiwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICBFTkFCTEVfQUNMS19JTUVNX1NMSU1TU1MsIDAsIENMS19J
R05PUkVfVU5VU0VELCAwKSwKPiArCj4gKyAgICAgICAvKiBFTkFCTEVfUENMS19JTUVNX1NMSU1T
U1MgKi8KPiArICAgICAgIEdBVEUoQ0xLX1BDTEtfU0xJTVNTUywgInBjbGtfc2xpbXNzcyIsICJh
Y2xrX2ltZW1fMjAwIiwKPiArICAgICAgICAgICAgICAgICAgICAgICBFTkFCTEVfUENMS19JTUVN
X1NMSU1TU1MsIDAsIENMS19JR05PUkVfVU5VU0VELCAwKSwKPiArfTsKPiArCj4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3Qgc2Ftc3VuZ19jbXVfaW5mbyBpbWVtX2NtdV9pbmZvIF9faW5pdGNvbnN0ID0g
ewo+ICsgICAgICAgLmdhdGVfY2xrcyAgICAgICAgICAgICAgPSBpbWVtX2dhdGVfY2xrcywKPiAr
ICAgICAgIC5ucl9nYXRlX2Nsa3MgICAgICAgICAgID0gQVJSQVlfU0laRShpbWVtX2dhdGVfY2xr
cyksCj4gKyAgICAgICAubnJfY2xrX2lkcyAgICAgICAgICAgICA9IElNRU1fTlJfQ0xLLAo+ICsg
ICAgICAgLmNsa19yZWdzICAgICAgICAgICAgICAgPSBpbWVtX2Nsa19yZWdzLAo+ICsgICAgICAg
Lm5yX2Nsa19yZWdzICAgICAgICAgICAgPSBBUlJBWV9TSVpFKGltZW1fY2xrX3JlZ3MpLAo+ICsg
ICAgICAgLmNsa19uYW1lICAgICAgICAgICAgICAgPSAiYWNsa19pbWVtXzIwMCIsCj4gK307Cj4K
PiAgc3RydWN0IGV4eW5vczU0MzNfY211X2RhdGEgewo+ICAgICAgICAgc3RydWN0IHNhbXN1bmdf
Y2xrX3JlZ19kdW1wICpjbGtfc2F2ZTsKPiBAQCAtNTY1NCw2ICs1NjgzLDkgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgZXh5bm9zNTQzM19jbXVfb2ZfbWF0Y2hbXSA9IHsKPiAg
ICAgICAgIH0sIHsKPiAgICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAic2Ftc3VuZyxleHlu
b3M1NDMzLWNtdS1tc2NsIiwKPiAgICAgICAgICAgICAgICAgLmRhdGEgPSAmbXNjbF9jbXVfaW5m
bywKPiArICAgICAgIH0sIHsKPiArICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAic2Ftc3Vu
ZyxleHlub3M1NDMzLWNtdS1pbWVtIiwKPiArICAgICAgICAgICAgICAgLmRhdGEgPSAmaW1lbV9j
bXVfaW5mbywKPiAgICAgICAgIH0sIHsKPiAgICAgICAgIH0sCj4gIH07Cj4gLS0KPiAyLjIwLjAK
PgoKTG9va3MgZ29vZCB0byBtZS4KQWNrZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNh
bXN1bmcuY29tPgoKLS0gCkJlc3QgUmVnYXJkcywKQ2hhbndvbyBDaG9pClNhbXN1bmcgRWxlY3Ry
b25pY3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
