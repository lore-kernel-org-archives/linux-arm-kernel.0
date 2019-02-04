Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E512C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:42:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF232081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fCsQvNpQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEHHeNI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF232081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fEQmTbVRPnFqPt0LOKiP0d0b47VArX8HDEXT83Oqt8A=; b=fCsQvNpQHPBh7z
	91n16AS5//3X4Flu/0YJn/+iHHi9aDN4aJnOOW4trsNV3dZrFwo7HVgmbYz2iePUtybIpE7TkToep
	3PiWdMLDUV/ArL3IlFkV/JQHJVRYYC1mQ6jvcjr01+uJTGAZLEPvN7Ikp4ezDZuH//PLetW9rhZzf
	iEgqwIQe1zSs7qq30vYgvO21O/a9dAHGuzAHpXtX+OzE6GYNjAkW5yvdKOhldLXDn2feNSLnSQ4vi
	lfVVoVXA07pOWdJ/6Utr2aPjp78pZjfIYTa3WSFiw+EunezIwwMOdIv4QencRJVdQXQHp+0z5Vf6a
	7ZAdSVdKhUspNvD81hHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqeWM-0008VM-FM; Mon, 04 Feb 2019 13:42:46 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqeWI-0008Uw-8K
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 13:42:43 +0000
Received: by mail-it1-x142.google.com with SMTP id z20so21010098itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 05:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TmOQSXGEBk97U5RJF28ewCmxSmS4ibeUojwFavrfioo=;
 b=cEHHeNI20ix2Q/lRNrQal4jipkEGvSenUuXx4El3wFStI6japF4+ZgimtRVkbCuSre
 vgMfeKFGRbAPSKOM7RLFeLjrP5u72IzHCZmrT7hQvafBt+CmTa8rat5bbzJaQZJHDTIJ
 EelEzOGpXYLNN7BZqa+U9CmCPNJyrJFbIvGFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TmOQSXGEBk97U5RJF28ewCmxSmS4ibeUojwFavrfioo=;
 b=BqCUh2+ruxVIPxR0RioE1iLUmbL6Rv/QQ2kCP01IS1LBtLwkBcvkiLmnXiisC3XOp7
 b/wxlZmbCYSODhrj5CcShg2fxZY1tbzRtyA7rjlOlY0JexY1t9/P55sUmMKeZAykqi+U
 i2OoCoNBWXjFEm4Le23Qiy9LHRQdDFXJZ4La3M5DQ6QbKo0puF7aSJBWezUj1zB2vjbP
 mJXhMdN/cABq+et7c1RfeiqyMMuO/XFnKYZvQw3WwqsMHJChV8vgExHZwBcH7AigdVGd
 3Y+JxUr0KwTSpHR63295P5XUC9SgIKMRKvXi6DX3/lDApPhHadrXWWY9oVpB9Senk7I8
 YyKw==
X-Gm-Message-State: AHQUAuZBXyjFJW54RzIF1xCke4MnLYEBqmB+hBtNihFzC4PonzlD2ePf
 I5TRtVSK++lvTB1xXaewYiY/ZvrebGqZzFwjRNAkvg==
X-Google-Smtp-Source: AHgI3IYpA/IbB3j5wOFFEOK5t9QyWQTGaNTKJ7JYmDgpAQwJoZ2TC2XVCeAOmLd7kXJ/V+Dea3Ue00AF/XUO6f5Mty0=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr13994122ion.173.1549287760907; 
 Mon, 04 Feb 2019 05:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20190204132904.9288-1-anders.roxell@linaro.org>
In-Reply-To: <20190204132904.9288-1-anders.roxell@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 4 Feb 2019 14:42:30 +0100
Message-ID: <CAKv+Gu80Pct6z9K2HSHHxNGQR=LM37e82h9Wgi5pyHFsGXZyyA@mail.gmail.com>
Subject: Re: [PATCH] firmware: efi: arm-runtime: fix build error void value
 not ignored
To: Anders Roxell <anders.roxell@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will.deacon@arm.com>, 
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_054242_293622_C5A917CC 
X-CRM114-Status: GOOD (  20.54  )
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCA0IEZlYiAyMDE5IGF0IDE0OjI5LCBBbmRlcnMgUm94ZWxsIDxhbmRlcnMucm94ZWxs
QGxpbmFyby5vcmc+IHdyb3RlOgo+Cj4gQ29tbWl0IGUyYTJlNTZlNDA4MiAoImFybTY0OiBkdW1w
OiBubyBuZWVkIHRvIGNoZWNrIHJldHVybiB2YWx1ZSBvZiBkZWJ1Z2ZzX2NyZWF0ZSBmdW5jdGlv
bnMiKQo+IGNoYW5nZWQgdGhlIHJldHVybiB2YWx1ZSBmcm9tICdpbnQnIHRvICd2b2lkJy4KPgo+
IC4uL2RyaXZlcnMvZmlybXdhcmUvZWZpL2FybS1ydW50aW1lLmM6IEluIGZ1bmN0aW9uIOKAmHB0
ZHVtcF9pbml04oCZOgo+IC4uL2RyaXZlcnMvZmlybXdhcmUvZWZpL2FybS1ydW50aW1lLmM6NTI6
OTogZXJyb3I6IHZvaWQgdmFsdWUgbm90IGlnbm9yZWQgYXMgaXQgb3VnaHQgdG8gYmUKPiAgIHJl
dHVybiBwdGR1bXBfZGVidWdmc19yZWdpc3RlcigmZWZpX3B0ZHVtcF9pbmZvLCAiZWZpX3BhZ2Vf
dGFibGVzIik7Cj4gICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gLi4vZHJpdmVycy9maXJtd2FyZS9lZmkvYXJtLXJ1
bnRpbWUuYzo1MzoxOiB3YXJuaW5nOiBjb250cm9sIHJlYWNoZXMgZW5kIG9mIG5vbi12b2lkIGZ1
bmN0aW9uIFstV3JldHVybi10eXBlXQo+ICB9Cj4gIF4KPgo+IFJld29yayBzbyB0aGF0IGZ1bmN0
aW9uICdwdGR1bXBfaW5pdCcgZG9lc24ndCAncmV0dXJuCj4gcHRkdW1wX2RlYnVnX2ZzX3JlZ2lz
dGVyKC4uLicgc2luY2UgdGhlIGZ1bmN0aW9uIGNhbiB3b3JrIG9yIG5vdCwgYnV0Cj4gdGhlIGNv
ZGUgbG9naWMgc2hvdWxkIG5ldmVyIGRvIHNvbWV0aGluZyBkaWZmZXJlbnQgYmFzZWQgb24gdGhp
cy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFuZGVycyBSb3hlbGwgPGFuZGVycy5yb3hlbGxAbGluYXJv
Lm9yZz4KCkhpIEFuZGVycywKClRoYW5rcyBmb3IgdGhlIGZpeC4KClNvbWVvbmUgZWxzZSBzcG90
dGVkIHRoZSBzYW1lIGJ1ZywgYW5kIHNlbnQgYSBzaW1pbGFyIGZpeCwgYW5kIEkgYXNrZWQKV2ls
bCBvciBDYXRhbGluIHRvIHRha2UgaXQgdGhyb3VnaCB0aGUgYXJtNjQgZm9yLW5leHQgdHJlZSBz
aW5jZSB0aGlzCmlzIHdoZXJlIHRoZSBvZmZlbmRpbmcgcGF0Y2ggbGl2ZXMuCgpTbyBmb3IgZWl0
aGVyIHRoaXMgcGF0Y2ggb3IgZm9yIHRoZSBvdGhlciBvbmUKCkFja2VkLWJ5OiBBcmQgQmllc2hl
dXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4KCgoKPiAtLS0KPiAgZHJpdmVycy9maXJt
d2FyZS9lZmkvYXJtLXJ1bnRpbWUuYyB8IDMgKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJl
L2VmaS9hcm0tcnVudGltZS5jIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvYXJtLXJ1bnRpbWUuYwo+
IGluZGV4IDM1MmJkMjQ3MzE2Mi4uYjlhZTc5ODE5MmQ2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
ZmlybXdhcmUvZWZpL2FybS1ydW50aW1lLmMKPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9h
cm0tcnVudGltZS5jCj4gQEAgLTQ5LDcgKzQ5LDggQEAgc3RhdGljIGludCBfX2luaXQgcHRkdW1w
X2luaXQodm9pZCkKPiAgICAgICAgIGlmICghZWZpX2VuYWJsZWQoRUZJX1JVTlRJTUVfU0VSVklD
RVMpKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsKPgo+IC0gICAgICAgcmV0dXJuIHB0ZHVt
cF9kZWJ1Z2ZzX3JlZ2lzdGVyKCZlZmlfcHRkdW1wX2luZm8sICJlZmlfcGFnZV90YWJsZXMiKTsK
PiArICAgICAgIHB0ZHVtcF9kZWJ1Z2ZzX3JlZ2lzdGVyKCZlZmlfcHRkdW1wX2luZm8sICJlZmlf
cGFnZV90YWJsZXMiKTsKPiArICAgICAgIHJldHVybiAwOwo+ICB9Cj4gIGRldmljZV9pbml0Y2Fs
bChwdGR1bXBfaW5pdCk7Cj4KPiAtLQo+IDIuMjAuMQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
