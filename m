Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E67C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 16:12:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F132087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 16:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LGxh0lJN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJBB+hz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F132087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0xVLYjikJJkfts3dGIgbMFnuTqCTxQ2RMBaSkW5XL04=; b=LGxh0lJNZiYQMMEMaB+P+8Yta
	hET/x9/8a1X3j4V7H+Dt1IMUmPtdjyjEwdsy7pPyD7Ylq+r6ahnn0pTDxc0Ha9OJOA8VhcMtb9ZnN
	emZ888m8FzD4KO7zXyMTD3lF6cCIBH2yHL8kEPI/imKPkMW1E+wur3vCABnFrAFunFHqM2OsdiwxY
	Zdv24LQXq9hClLJxkJdeTfg5PRsMpVvDpqbkE8qf7zXgHBZQcDjdcj91oB94cPXKanV9uU4CfGAGR
	txbj3XQIvEDTm1UOhn9WbiLWQsvyC/v3gikgSguQohnstzxgzV/aHUvGoBGjKrx+WVH/QB6FDsAba
	Wi4JUqqmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdHDW-0007d3-CM; Sat, 29 Dec 2018 16:12:02 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdHDS-0007cB-4u
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 16:11:59 +0000
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so20892280lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 29 Dec 2018 08:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JJk/MpfvM0ioAb5108EsfYUUovY6oCjKZh6SKbXoUBo=;
 b=TJBB+hz/MKp6vNA+CH5wLArLONVMNNcG9Lef3DRwj1vu4sxMIzxrtKGssVNKuQW+Vn
 F6i8CEpUO/B5VyBwylcygErvaLCXR+gN85jWqt9aXDhQjeFnPlcR8yjhQnWu7ow400PZ
 lDdRN/AYUK9msrIukILI3gWEn1wASxTjbmOZIJIeUluB3NT5Vm9ojhLfhkAHyRVss3Uq
 exfkEDtYAJEkW8lEb8e2VY/xMgqxEwSmUGnYmxzYHuOfRRsYChFpIVqqwbZmdFdWtpvq
 /XEQqnrsVLLBFrM+ObDpzjkMyHEDypcqX5hjgcZ8wlSO+BpeQzxkXtFoOkWC8AmwBMRp
 jTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JJk/MpfvM0ioAb5108EsfYUUovY6oCjKZh6SKbXoUBo=;
 b=qbGF8Y0OjSuNYU6ZQrx0p92MN6pq7Js0o5lyteyeRDPqK0RhgbIIs6sQvXFXOWqKHh
 0xCQkXSuL3DPa1Q6voXLgPheo8tn2HbxYZyOrONNn6DFs93JCdTG63ECUSl77Y4uYPmA
 aFqyRtB3DQcdb4XCrnoOuYfApVCGbHz5/IvyQ9NM+0xtQ2ovNL8V0Fe0wTmJxg7WqTcT
 /RsxzM0zgjoSFYPYVPIzwk5q99ZjFgGzRMwh0+wP4TdR+Chxk0tW3TABlpwVjRBGjkRO
 pkdVyeAcof7zbMu0WgAUVn1403SejuzqY6ZLQacbvSvkMmxZgLvf2hh9YwPlV6sNdvLQ
 K1Gw==
X-Gm-Message-State: AJcUukfu3plkOVMr0ISrbnrIPgQF4zdDX+cXMzd4kH5GG/97wqBGUFIX
 eRQ9r/O+B6F6WdnQt++8xNx1Wy7x
X-Google-Smtp-Source: AFSGD/XvediXFLshpEjhGxuSYn3NiQssph9j4UWJiI9+1+UxLkNYipnq8D6ANukYsdRHVfvaMhOHrQ==
X-Received: by 2002:a2e:3603:: with SMTP id
 d3-v6mr18164949lja.46.1546099905800; 
 Sat, 29 Dec 2018 08:11:45 -0800 (PST)
Received: from [192.168.1.18] (dkj55.neoplus.adsl.tpnet.pl. [83.24.13.55])
 by smtp.gmail.com with ESMTPSA id j18-v6sm9096828ljc.52.2018.12.29.08.11.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 08:11:45 -0800 (PST)
Subject: Re: [PATCH] media: s5p-jpeg: Check for fmt_ver_flag when doing fmt
 enumeration
To: =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
 andrzej.p@samsung.com
References: <20181229154602.25693-1-pawel.mikolaj.chmiel@gmail.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <e6a63771-8238-1822-d7bb-960649e8e359@gmail.com>
Date: Sat, 29 Dec 2018 17:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181229154602.25693-1-pawel.mikolaj.chmiel@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_081158_194786_EB595484 
X-CRM114-Status: GOOD (  22.92  )
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
Cc: linux-samsung-soc@vger.kernel.org, mchehab@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUGF3ZcWCLAoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guCgpPbiAxMi8yOS8xOCA0OjQ2IFBN
LCBQYXdlxYIgQ2htaWVsIHdyb3RlOgo+IFByZXZpb3VzbHkgd2hlbiBkb2luZyBmb3JtYXQgZW51
bWVyYXRpb24sIGl0IHdhcyByZXR1cm5pbmcgYWxsCj4gICBmb3JtYXRzIHN1cHBvcnRlZCBieSBk
cml2ZXIsIGV2ZW4gaWYgdGhleSdyZSBub3Qgc3VwcG9ydGVkIGJ5IGh3Lgo+IEFkZCBtaXNzaW5n
IGNoZWNrIGZvciBmbXRfdmVyX2ZsYWcsIHNvIGl0J2xsIGJlIGZpeGVkIGFuZCBvbmx5IHRob3Nl
Cj4gICBzdXBwb3J0ZWQgYnkgaHcgd2lsbCBiZSByZXR1cm5lZC4gU2ltaWxhciB0aGluZyBpcyBh
bHJlYWR5IGRvbmUKPiAgIGluIHM1cF9qcGVnX2ZpbmRfZm9ybWF0Lgo+IAo+IEl0IHdhcyBmb3Vu
ZCBieSB1c2luZyB2NGwyLWNvbXBsaWFuY2UgdG9vbCBhbmQgY2hlY2tpbmcgcmVzdWx0Cj4gICBv
ZiBWSURJT0NfRU5VTV9GTVQvRlJBTUVTSVpFUy9GUkFNRUlOVEVSVkFMUyB0ZXN0Cj4gYW5kIHVz
aW5nIHY0bDItY3RsIHRvIGdldCBsaXN0IG9mIGFsbCBzdXBwb3J0ZWQgZm9ybWF0cy4KPiAKPiBU
ZXN0ZWQgb24gczVwdjIxMC1nYWxheHlzIChTYW1zdW5nIGk5MDAwIHBob25lKS4KPiAKPiBGaXhl
czogYmI2NzdmM2FjNDM0ICgiW21lZGlhXSBFeHlub3M0IEpQRUcgY29kZWMgdjRsMiBkcml2ZXIi
KQo+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdt
YWlsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vczVwLWpwZWcvanBlZy1j
b3JlLmMgfCAxNSArKysrKysrKystLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vczVwLWpwZWcvanBlZy1jb3JlLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3M1cC1q
cGVnL2pwZWctY29yZS5jCj4gaW5kZXggM2Y5MDAwYjcwMzg1Li4yMzJiNzVjZjIwOWYgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zNXAtanBlZy9qcGVnLWNvcmUuYwo+ICsr
KyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vczVwLWpwZWcvanBlZy1jb3JlLmMKPiBAQCAtMTI5
MywxMyArMTI5MywxNiBAQCBzdGF0aWMgaW50IHM1cF9qcGVnX3F1ZXJ5Y2FwKHN0cnVjdCBmaWxl
ICpmaWxlLCB2b2lkICpwcml2LAo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBp
bnQgZW51bV9mbXQoc3RydWN0IHM1cF9qcGVnX2ZtdCAqc2pwZWdfZm9ybWF0cywgaW50IG4sCj4g
K3N0YXRpYyBpbnQgZW51bV9mbXQoc3RydWN0IHM1cF9qcGVnX2N0eCAqY3R4LAo+ICsJCSAgICBz
dHJ1Y3QgczVwX2pwZWdfZm10ICpzanBlZ19mb3JtYXRzLCBpbnQgbiwKPiAgIAkJICAgIHN0cnVj
dCB2NGwyX2ZtdGRlc2MgKmYsIHUzMiB0eXBlKQo+ICAgewo+ICAgCWludCBpLCBudW0gPSAwOwo+
ICsJdW5zaWduZWQgaW50IGZtdF92ZXJfZmxhZyA9IGN0eC0+anBlZy0+dmFyaWFudC0+Zm10X3Zl
cl9mbGFnOwo+ICAgCj4gICAJZm9yIChpID0gMDsgaSA8IG47ICsraSkgewo+IC0JCWlmIChzanBl
Z19mb3JtYXRzW2ldLmZsYWdzICYgdHlwZSkgewo+ICsJCWlmIChzanBlZ19mb3JtYXRzW2ldLmZs
YWdzICYgdHlwZSAmJgo+ICsJCQlzanBlZ19mb3JtYXRzW2ldLmZsYWdzICYgZm10X3Zlcl9mbGFn
KSB7Cj4gICAJCQkvKiBpbmRleC10aCBmb3JtYXQgb2YgdHlwZSB0eXBlIGZvdW5kID8gKi8KPiAg
IAkJCWlmIChudW0gPT0gZi0+aW5kZXgpCj4gICAJCQkJYnJlYWs7Cj4gQEAgLTEzMjYsMTAgKzEz
MjksMTAgQEAgc3RhdGljIGludCBzNXBfanBlZ19lbnVtX2ZtdF92aWRfY2FwKHN0cnVjdCBmaWxl
ICpmaWxlLCB2b2lkICpwcml2LAo+ICAgCXN0cnVjdCBzNXBfanBlZ19jdHggKmN0eCA9IGZoX3Rv
X2N0eChwcml2KTsKPiAgIAo+ICAgCWlmIChjdHgtPm1vZGUgPT0gUzVQX0pQRUdfRU5DT0RFKQo+
IC0JCXJldHVybiBlbnVtX2ZtdChzanBlZ19mb3JtYXRzLCBTSlBFR19OVU1fRk9STUFUUywgZiwK
PiArCQlyZXR1cm4gZW51bV9mbXQoY3R4LCBzanBlZ19mb3JtYXRzLCBTSlBFR19OVU1fRk9STUFU
UywgZiwKPiAgIAkJCQlTSlBFR19GTVRfRkxBR19FTkNfQ0FQVFVSRSk7Cj4gICAKPiAtCXJldHVy
biBlbnVtX2ZtdChzanBlZ19mb3JtYXRzLCBTSlBFR19OVU1fRk9STUFUUywgZiwKPiArCXJldHVy
biBlbnVtX2ZtdChjdHgsIHNqcGVnX2Zvcm1hdHMsIFNKUEVHX05VTV9GT1JNQVRTLCBmLAo+ICAg
CQkJCQlTSlBFR19GTVRfRkxBR19ERUNfQ0FQVFVSRSk7Cj4gICB9Cj4gICAKPiBAQCAtMTMzOSwx
MCArMTM0MiwxMCBAQCBzdGF0aWMgaW50IHM1cF9qcGVnX2VudW1fZm10X3ZpZF9vdXQoc3RydWN0
IGZpbGUgKmZpbGUsIHZvaWQgKnByaXYsCj4gICAJc3RydWN0IHM1cF9qcGVnX2N0eCAqY3R4ID0g
ZmhfdG9fY3R4KHByaXYpOwo+ICAgCj4gICAJaWYgKGN0eC0+bW9kZSA9PSBTNVBfSlBFR19FTkNP
REUpCj4gLQkJcmV0dXJuIGVudW1fZm10KHNqcGVnX2Zvcm1hdHMsIFNKUEVHX05VTV9GT1JNQVRT
LCBmLAo+ICsJCXJldHVybiBlbnVtX2ZtdChjdHgsIHNqcGVnX2Zvcm1hdHMsIFNKUEVHX05VTV9G
T1JNQVRTLCBmLAo+ICAgCQkJCVNKUEVHX0ZNVF9GTEFHX0VOQ19PVVRQVVQpOwo+ICAgCj4gLQly
ZXR1cm4gZW51bV9mbXQoc2pwZWdfZm9ybWF0cywgU0pQRUdfTlVNX0ZPUk1BVFMsIGYsCj4gKwly
ZXR1cm4gZW51bV9mbXQoY3R4LCBzanBlZ19mb3JtYXRzLCBTSlBFR19OVU1fRk9STUFUUywgZiwK
PiAgIAkJCQkJU0pQRUdfRk1UX0ZMQUdfREVDX09VVFBVVCk7Cj4gICB9Cj4gICAKPiAKClJldmll
d2VkLWJ5OiBKYWNlayBBbmFzemV3c2tpIDxqYWNlay5hbmFzemV3c2tpQGdtYWlsLmNvbT4KCi0t
IApCZXN0IHJlZ2FyZHMsCkphY2VrIEFuYXN6ZXdza2kKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
