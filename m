Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:56:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB68214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z0X817h7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3/+3nCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB68214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P7P5uQB4ISBb4L2Onp4FnJN3MFhtlrq4RRPNxoRFnZE=; b=Z0X817h7524jYI
	GI7AInqYNX8ref4A5VbLdRHA2qFbSmbEXjQ4AwFSjHNV8siJamObeEH/a9O7tC3u/ZFF0EiPWiwDa
	qVBV3OX4Tk40haR3Uh/KC4rPYtMjTUGVRkXywUJlqpyO+VT3nfrPO628NIfIma+rveIeokjid6d+1
	VwI6wrWpvE6Z1487OwEUVNf00+ySBwNXQ814UEKVb7KnQYveauvLgAjtV1WqDXzvj8btjdJOHbbd/
	ACwsP76bFHKiDa49BoIdsEeWe0Ya7IVGDu8Lc6y10I0OYRM4MKJ51XCkJuxnVoFtHPtPHIkciIqSH
	fWg7h2fwzlUSWrWh3DJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gveiV-00038W-Vl; Mon, 18 Feb 2019 08:55:59 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gveiS-000385-54
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:55:57 +0000
Received: by mail-wm1-x344.google.com with SMTP id m1so16505979wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 00:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O6PlKTx/1aDhRx9KVxgEVfEdFJErSRKRtG1fNEWVcck=;
 b=o3/+3nCyaL3hTBLVYCQjpw0/uWdoo9zuBazcIWWTT1GssfZuBFojiZhmEqYbR4IMRM
 F/4mnVURL1Kf3OBzDcVXZIKkEnrtbu7WzPyuM1d7RGpLhYgO3gBK2dsXqshxMrl54Vhn
 gCk+nONer4lElPtiJCzE4k1fNsi+inAEdqh9636Rx1CWfyk6K0fe7my61R50Y9l7y8Z2
 OxMFJ0Uh2klUrYLf7bLjc5CtsyPxr9eCuO7+uXTSDsClFzeygHFfblHdCRH360Bqaa8y
 m6G+DzB2Rhza8WWF9IFOI262rj0br5MDKu1ln0Hpp3fjXJVMOBAbsHgnIDloKH6w98Th
 P8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O6PlKTx/1aDhRx9KVxgEVfEdFJErSRKRtG1fNEWVcck=;
 b=AVU5Z2DQEE3neLOgTXwCx1ORpEJv5k6vaG3IcmtxSVc0pXX6J929MNyg1hgUPFoaec
 eyxE4iHkkACwFcSSC26wUK8y9GnEBtxJaUqXjuZzECuv88y+0mUNgBtW0GqU6Gm7pYo1
 swuntBB4PjgYk/RNc9XyFvWjc/GK8gShSaH3wl03ZyStGTzhTsgxFvV7C1oN3b7AupCl
 kotdnzOiOkhqpxShPGa9DSIjNHR/TCX9sIbtnvST+9DBIYl61vPixht1VszK+xDQSRKi
 0NBJqIC4N/5G7K6H/Ja8I5236jFgRQ20M0JAaSDs3zNKkY+/nCUUTBNnqVbVNjDHYGgK
 UdAg==
X-Gm-Message-State: AHQUAuYjw51tTHNQJAMKn1dH+PmLU0VJVAvr824qCt9Piys68GaG6nHi
 Zn33R/sUgKaI9QyrUzSb9TyntQ==
X-Google-Smtp-Source: AHgI3IYBQWxV1JJwfmEduh213xeOLxxc0pCSxPRKrKfhh1u38oa17TsQURrwiqjq483L5WWoQRSewQ==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr15248371wmb.10.1550480154111; 
 Mon, 18 Feb 2019 00:55:54 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id w10sm4598627wru.5.2019.02.18.00.55.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 00:55:53 -0800 (PST)
Subject: Re: [PATCH 3/5] clocksource: exynos_mct: Increase priority over ARM
 arch timer
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2@eucas1p2.samsung.com>
 <20190215125229.30180-4-m.szyprowski@samsung.com>
 <01569ba7-2e3e-5811-81e1-ca51cacbcb95@linaro.org>
 <CAJKOXPfs6i08OqXPZeJ19-tyoj7zY60tjq=fEScjm5wdRR6fXw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a1d2701b-90d5-b921-7c54-15742f25b7ad@linaro.org>
Date: Mon, 18 Feb 2019 09:55:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfs6i08OqXPZeJ19-tyoj7zY60tjq=fEScjm5wdRR6fXw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_005556_203218_9A5C8519 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTgvMDIvMjAxOSAwOTo1MywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToKPiBPbiBGcmks
IDE1IEZlYiAyMDE5IGF0IDE3OjM1LCBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZz4gd3JvdGU6Cj4+Cj4+IE9uIDE1LzAyLzIwMTkgMTM6NTIsIE1hcmVrIFN6eXByb3dz
a2kgd3JvdGU6Cj4+PiBFeHlub3MgTXVsdGktQ29yZSBUaW1lciBkcml2ZXIgKGV4eW5vc19tY3Qp
IG11c3QgYmUgc3RhcnRlZCBiZWZvcmUgQVJNCj4+PiBBcmNoaXRlY3RlZCBUaW1lcnMgKGFyY2hf
dGltZXIpLCBiZWNhdXNlIHRoZXkgYm90aCBzaGFyZSBzb21lIGNvbW1vbgo+Pj4gaGFyZHdhcmUg
YmxvY2tzIChnbG9iYWwgc3lzdGVtIGNvdW50ZXIpIGFuZCB0dXJuaW5nIG9uIE1DVCBpcyBuZWVk
ZWQKPj4+IHRvIGdldCBBUk0gQXJjaGl0ZWN0ZWQgVGltZXIgd29ya2luZyBwcm9wZXJseS4gSW5j
cmVhc2UgTUNUIHRpbWVyIHJhdGluZwo+Pj4gYW5kIGhvdHBsdWcgcHJpb3JpdHkgb3ZlciBBUk0g
QXJjaGljdGVjdGVkIHRpbWVyIGRyaXZlciB0byBhY2hpZXZlIHRoYXQuCj4+Cj4+IFRoaXMgaXMg
YSBoYWNrLgo+Pgo+PiBUaGVyZSBhcmUgbWVjaGFuaXNtcyB0byBoYW5kbGUgdGhpcyBraW5kIG9m
IGRlcGVuZGVuY3kuCj4+Cj4+IGVnLiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y0
LjE1L2RyaXZlci1hcGkvZGV2aWNlX2xpbmsuaHRtbAo+IAo+IEhpIERhbmllbCwKPiAKPiBBcmUg
eW91IHN1cmUgeW91IGhhdmUgcHJvcGVyIGRldmljZXMgYXQgdGhpcyBwb2ludCBzbyB5b3UgY2Fu
IG9yZGVyCj4gZGVwZW5kZW5jaWVzIHdpdGggZGV2aWNlIGxpbmtzPwoKTm8sIGl0IHdhcyBhbiBl
eGFtcGxlIHRvIHNob3cgdGhlcmUgYXJlIG1lY2hhbmlzbSB0byBoYW5kbGUgdGhlCmRlcGVuZGVu
Y2llcy4gQWdyZWUgaXQgaXMgYSBjb25mdXNpbmcgZXhhbXBsZS4KCgoKCi0tIAogPGh0dHA6Ly93
d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBB
Uk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9M
aW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0
ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
