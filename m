Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7D3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:06:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9DD21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iq0RnpHP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8Qa3Vlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9DD21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lxSoQUGMf6vZJXqcB9CezpiTKTHcBd1wz5FG+ULeFLA=; b=Iq0RnpHPVoCOCt
	PFdU88ub6ELHDJvTl9ducuibhsaxtOpG8FJx7eLSbxX3UPhMlCWvIObw3UCzGKm+0i5vowL/OHv0P
	h6+1B/n8AtcnRE0XWmtgN4+1vIePryCpaN/SCP3Hng/BvLkzw27P7T5gdq5aBZEs47GJ8zP2wP6Wu
	sDXZ415fSsc6eP2HX83uwfX8X3mIn7iw2ZeO2wdv1oxe+F3PmTdQrC/GINSrWJrWlhBh4A0Fyl4j4
	nNfnrvJ9nyh4/9T0G9t5QtUlokvIlgW47VjeUdJnhiPpYig/1hq+liH4ShxF/7Dov1+rPdwgzaTqQ
	xVN57WE3c7qBhkARY/tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZg7-0008Uz-QJ; Wed, 19 Dec 2018 11:06:15 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZg3-0008Tl-Ux
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 11:06:13 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so5935943wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 03:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IDEq0xEKE5sZIIIOJo6rYMCXG3pYYRQ6TJUoMidPF1U=;
 b=c8Qa3VlbAb0xyFOn7n+U272BTOTP1pPO/ipP6So6iUWUFM9mGrKq/ig3yQkOWFYrnc
 yqStMvDqb+tsyVFsGWLuqB4XHSMJDTPseTmkg+5pT6ietTSrCBJu1d8MxuiOEgS2wCTi
 FBJk+LPxOeLChIoJYezwk4mt2GFpTHtSru6bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IDEq0xEKE5sZIIIOJo6rYMCXG3pYYRQ6TJUoMidPF1U=;
 b=DgPoAqMPdLD97V8EOqlKjn5mkupRuszKN1y/NtMGDCfx0+SerhHY1BDFVf29Z30DzC
 cZWMmvBfY6gv/YVV4nLl+otgTzxWVR2NRSp63LpXTn9zQTdX81W1ct6bJ9u/Oi3iEJEV
 KKKeTnj5Qs4P/VUTvbYyz4eMNhRwKCWRpUYgTmn4D78lsshpy5Omp4nNq8VYtKmlAHGy
 LzbGTX84AtcwoX35iM/4oIdWobXah978fFdTviPyOQOLC7sNW8G5FmiZR40LFj9Ap/Dd
 ctO27E/1OWj/aS5H8a4GteMIN3ZSqI3NXFgnyc8qrnt0EU1ds3tYmmdIvuk8k8+f0W4i
 Xhlg==
X-Gm-Message-State: AA+aEWb/4JV91d1pvnxaExss8SEgQIn5PFMqR1zDC/prv8OeFT/O9Cb2
 lXf5lH4OecL8TDuF4gDW/Q/zAFMw3Gc=
X-Google-Smtp-Source: AFSGD/WKRl4Dre+tuzBpXSTaAcZm1YHV1gsPAYPum/p7Mh/psATqg9L5xNmroWSb5VYWi5yVi49jKQ==
X-Received: by 2002:a1c:81ca:: with SMTP id c193mr7159274wmd.66.1545217559629; 
 Wed, 19 Dec 2018 03:05:59 -0800 (PST)
Received: from [192.168.0.40] (197.26.136.77.rev.sfr.net. [77.136.26.197])
 by smtp.googlemail.com with ESMTPSA id l37sm9343331wre.69.2018.12.19.03.05.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 03:05:58 -0800 (PST)
Subject: Re: [PATCH v10 06/27] of: base: Add of_get_cpu_state_node() to get
 idle states for a CPU node
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla
 <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-7-ulf.hansson@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <65605bbd-ceda-2266-615e-20b9d3491bed@linaro.org>
Date: Wed, 19 Dec 2018 12:05:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-7-ulf.hansson@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_030611_994735_D0BCE99A 
X-CRM114-Status: GOOD (  29.46  )
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
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjkvMTEvMjAxOCAxODo0NiwgVWxmIEhhbnNzb24gd3JvdGU6Cj4gVGhlIENQVSdzIGlkbGUg
c3RhdGUgbm9kZXMgYXJlIGN1cnJlbnRseSBwYXJzZWQgYXQgdGhlIGNvbW1vbiBjcHVpZGxlIERU
Cj4gbGlicmFyeSwgYnV0IGFsc28gd2hlbiBpbml0aWFsaXppbmcgYmFjay1lbmQgZGF0YSBmb3Ig
dGhlIGFyY2ggc3BlY2lmaWMgQ1BVCj4gb3BlcmF0aW9ucywgYXMgaW4gdGhlIFBTQ0kgZHJpdmVy
IGNhc2UuCj4gCj4gVG8gYXZvaWQgb3Blbi1jb2RpbmcsIGxldCdzIGludHJvZHVjZSBvZl9nZXRf
Y3B1X3N0YXRlX25vZGUoKSwgd2hpY2ggdGFrZXMKPiB0aGUgZGV2aWNlIG5vZGUgZm9yIHRoZSBD
UFUgYW5kIHRoZSBpbmRleCB0byB0aGUgcmVxdWVzdGVkIGlkbGUgc3RhdGUgbm9kZSwKPiBhcyBp
bi1wYXJhbWV0ZXJzLiBJbiBjYXNlIGEgY29ycmVzcG9uZGluZyBpZGxlIHN0YXRlIG5vZGUgaXMg
Zm91bmQsIGl0Cj4gcmV0dXJucyB0aGUgbm9kZSB3aXRoIHRoZSByZWZjb3VudCBpbmNyZW1lbnRl
ZCBmb3IgaXQsIGVsc2UgaXQgcmV0dXJucwo+IE5VTEwuCj4gCj4gTW9yZW92ZXIsIGZvciBBUk0s
IHRoZXJlIGFyZSB0d28gZ2VuZXJpYyBtZXRob2RzLCB0byBkZXNjcmliZSB0aGUgQ1BVJ3MKPiBp
ZGxlIHN0YXRlcywgZWl0aGVyIHZpYSB0aGUgZmxhdHRlbmVkIGRlc2NyaXB0aW9uIHRocm91Z2gg
dGhlCj4gImNwdS1pZGxlLXN0YXRlcyIgYmluZGluZyBbMV0gb3IgdmlhIHRoZSBoaWVyYXJjaGlj
YWwgbGF5b3V0LCB1c2luZyB0aGUKPiAicG93ZXItZG9tYWlucyIgYW5kIHRoZSAiZG9tYWluLWlk
bGUtc3RhdGVzIiBiaW5kaW5ncyBbMl0uIEhlbmNlLCBsZXQncwo+IHRha2UgYm90aCBvcHRpb25z
IGludG8gYWNjb3VudC4KPiAKPiBbMV0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2lkbGUtc3RhdGVzLnR4dAo+IFsyXQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vcHNjaS50eHQKPiAKPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVs
Lm9yZz4KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogTGluYSBJeWVyIDxp
bGluYUBjb2RlYXVyb3JhLm9yZz4KPiBTdWdnZXN0ZWQtYnk6IFN1ZGVlcCBIb2xsYSA8c3VkZWVw
LmhvbGxhQGFybS5jb20+Cj4gQ28tZGV2ZWxvcGVkLWJ5OiBMaW5hIEl5ZXIgPGxpbmEuaXllckBs
aW5hcm8ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5h
cm8ub3JnPgo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgoKTml0
cGlja2luZyBzb21lIGtlcm5lbGRvYyBmb3JtYXR0aW5nIGJlbG93LgoKT3RoZXIgdGhhbiB0aGF0
OgoKUmV2aWV3ZWQtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3Jn
PgoKPiAtLS0KPiAKPiBDaGFuZ2VzIGluIHYxMDoKPiAJLSBOb25lLgo+IAo+IC0tLQo+ICBkcml2
ZXJzL29mL2Jhc2UuYyAgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ICBpbmNsdWRlL2xpbnV4L29mLmggfCAgOCArKysrKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDQz
IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9vZi9iYXNlLmMgYi9kcml2
ZXJzL29mL2Jhc2UuYwo+IGluZGV4IDA5NjkyYzliMzJhNy4uOGY2OTc0YTIyMDA2IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvb2YvYmFzZS5jCj4gKysrIGIvZHJpdmVycy9vZi9iYXNlLmMKPiBAQCAt
NDI5LDYgKzQyOSw0MSBAQCBpbnQgb2ZfY3B1X25vZGVfdG9faWQoc3RydWN0IGRldmljZV9ub2Rl
ICpjcHVfbm9kZSkKPiAgfQo+ICBFWFBPUlRfU1lNQk9MKG9mX2NwdV9ub2RlX3RvX2lkKTsKPiAg
Cj4gKy8qKgo+ICsgKiBvZl9nZXRfY3B1X3N0YXRlX25vZGUgLSBHZXQgQ1BVJ3MgaWRsZSBzdGF0
ZSBub2RlIGF0IHRoZSBnaXZlbiBpbmRleAo+ICsgKgo+ICsgKiBAY3B1X25vZGU6IFRoZSBkZXZp
Y2Ugbm9kZSBmb3IgdGhlIENQVQo+ICsgKiBAaW5kZXg6IFRoZSBpbmRleCBpbiB0aGUgbGlzdCBv
ZiB0aGUgaWRsZSBzdGF0ZXMKPiArICoKPiArICogVHdvIGdlbmVyaWMgbWV0aG9kcyBjYW4gYmUg
dXNlZCB0byBkZXNjcmliZSBhIENQVSdzIGlkbGUgc3RhdGVzLCBlaXRoZXIgdmlhCj4gKyAqIGEg
ZmxhdHRlbmVkIGRlc2NyaXB0aW9uIHRocm91Z2ggdGhlICJjcHUtaWRsZS1zdGF0ZXMiIGJpbmRp
bmcgb3IgdmlhIHRoZQo+ICsgKiBoaWVyYXJjaGljYWwgbGF5b3V0LCB1c2luZyB0aGUgInBvd2Vy
LWRvbWFpbnMiIGFuZCB0aGUgImRvbWFpbi1pZGxlLXN0YXRlcyIKPiArICogYmluZGluZ3MuIFRo
aXMgZnVuY3Rpb24gY2hlY2sgZm9yIGJvdGggYW5kIHJldHVybnMgdGhlIGlkbGUgc3RhdGUgbm9k
ZSBmb3IKPiArICogdGhlIHJlcXVlc3RlZCBpbmRleC4KPiArICoKPiArICogSW4gY2FzZSBhbmQg
aWRsZSBzdGF0ZSBub2RlIGlzIGZvdW5kIGF0IGluZGV4LCB0aGUgcmVmY291bnQgaW5jcmVtZW50
ZWQgZm9yCgpzL2FuZC9hbi8KCnMvaW5kZXgvQGluZGV4LwoKCj4gKyAqIGl0LCBzbyBjYWxsIG9m
X25vZGVfcHV0KCkgb24gaXQgd2hlbiBkb25lLiBSZXR1cm5zIE5VTEwgaWYgbm90IGZvdW5kLgoK
VGhlIFJldHVybiBkZXNjcmlwdGlvbiBtdXN0IGJlIGluIGEgc2VwYXJhdGUgc2VjdGlvbi4KCj4g
KyAqLwo+ICtzdHJ1Y3QgZGV2aWNlX25vZGUgKm9mX2dldF9jcHVfc3RhdGVfbm9kZShzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKmNwdV9ub2RlLAo+ICsJCQkJCSAgaW50IGluZGV4KQo+ICt7Cj4gKwlzdHJ1
Y3Qgb2ZfcGhhbmRsZV9hcmdzIGFyZ3M7Cj4gKwlpbnQgZXJyOwo+ICsKPiArCWVyciA9IG9mX3Bh
cnNlX3BoYW5kbGVfd2l0aF9hcmdzKGNwdV9ub2RlLCAicG93ZXItZG9tYWlucyIsCj4gKwkJCQkJ
IiNwb3dlci1kb21haW4tY2VsbHMiLCAwLCAmYXJncyk7Cj4gKwlpZiAoIWVycikgewo+ICsJCXN0
cnVjdCBkZXZpY2Vfbm9kZSAqc3RhdGVfbm9kZSA9Cj4gKwkJCW9mX3BhcnNlX3BoYW5kbGUoYXJn
cy5ucCwgImRvbWFpbi1pZGxlLXN0YXRlcyIsIGluZGV4KTsKPiArCj4gKwkJb2Zfbm9kZV9wdXQo
YXJncy5ucCk7Cj4gKwkJcmV0dXJuIHN0YXRlX25vZGU7Cj4gKwl9Cj4gKwo+ICsJcmV0dXJuIG9m
X3BhcnNlX3BoYW5kbGUoY3B1X25vZGUsICJjcHUtaWRsZS1zdGF0ZXMiLCBpbmRleCk7Cj4gK30K
PiArRVhQT1JUX1NZTUJPTChvZl9nZXRfY3B1X3N0YXRlX25vZGUpOwo+ICsKPiAgLyoqCj4gICAq
IF9fb2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoKSAtIENoZWNrIGlmIHRoZSBub2RlIG1hdGNoZXMg
Z2l2ZW4gY29uc3RyYWludHMKPiAgICogQGRldmljZTogcG9pbnRlciB0byBub2RlCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvb2YuaCBiL2luY2x1ZGUvbGludXgvb2YuaAo+IGluZGV4IGE1
YWVlM2M0MzhhZC4uZjlmMGM2NWMwOTVjIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvb2Yu
aAo+ICsrKyBiL2luY2x1ZGUvbGludXgvb2YuaAo+IEBAIC0zNDgsNiArMzQ4LDggQEAgZXh0ZXJu
IGNvbnN0IHZvaWQgKm9mX2dldF9wcm9wZXJ0eShjb25zdCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5v
ZGUsCj4gIAkJCQlpbnQgKmxlbnApOwo+ICBleHRlcm4gc3RydWN0IGRldmljZV9ub2RlICpvZl9n
ZXRfY3B1X25vZGUoaW50IGNwdSwgdW5zaWduZWQgaW50ICp0aHJlYWQpOwo+ICBleHRlcm4gc3Ry
dWN0IGRldmljZV9ub2RlICpvZl9nZXRfbmV4dF9jcHVfbm9kZShzdHJ1Y3QgZGV2aWNlX25vZGUg
KnByZXYpOwo+ICtleHRlcm4gc3RydWN0IGRldmljZV9ub2RlICpvZl9nZXRfY3B1X3N0YXRlX25v
ZGUoc3RydWN0IGRldmljZV9ub2RlICpjcHVfbm9kZSwKPiArCQkJCQkJIGludCBpbmRleCk7Cj4g
IAo+ICAjZGVmaW5lIGZvcl9lYWNoX3Byb3BlcnR5X29mX25vZGUoZG4sIHBwKSBcCj4gIAlmb3Ig
KHBwID0gZG4tPnByb3BlcnRpZXM7IHBwICE9IE5VTEw7IHBwID0gcHAtPm5leHQpCj4gQEAgLTc2
Miw2ICs3NjQsMTIgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgZGV2aWNlX25vZGUgKm9mX2dldF9u
ZXh0X2NwdV9ub2RlKHN0cnVjdCBkZXZpY2Vfbm9kZSAqcHJldikKPiAgCXJldHVybiBOVUxMOwo+
ICB9Cj4gIAo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBkZXZpY2Vfbm9kZSAqb2ZfZ2V0X2NwdV9z
dGF0ZV9ub2RlKHN0cnVjdCBkZXZpY2Vfbm9kZSAqY3B1X25vZGUsCj4gKwkJCQkJaW50IGluZGV4
KQo+ICt7Cj4gKwlyZXR1cm4gTlVMTDsKPiArfQo+ICsKPiAgc3RhdGljIGlubGluZSBpbnQgb2Zf
bl9hZGRyX2NlbGxzKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApCj4gIHsKPiAgCXJldHVybiAwOwo+
IAoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291
cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZh
Y2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8j
IS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9n
Lz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
