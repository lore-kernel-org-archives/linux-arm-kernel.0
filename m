Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06630C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:20:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0AC92184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sy3VSjoq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRaKmh7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AC92184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=22TpdeQs6XmCJbTgW5OkwrmyeREDRpyGusI7dBU0tus=; b=Sy3VSjoqCRmHRg
	D/EU64xhT1pra5mPTIMCY3j8jmz92w09tCy3rKYARksIKFzlcMt6EQZn2V2hWCAkn1OTjJ2neBUFS
	GHjy/CH23zAZ9IYwyJe42z7rXc+nmTRWgekJcJP6vhviMEbDiHl9XhwWkwy02JO6d9FD5cOj1Tqna
	CoXjKKP8aOZO3DYmaXfLErSVksDBXoGYDkErhJOa0KZWHFcFwDZW5DYEdggEiK9UqRLZ1ZgTHqGhx
	kWZLvWOLIDI3qFWnQuQcszcV2snjFzmaKl/33oWFxGwiv7LMdxzD9eAIJkdgVVztXcEEbwBkl1imO
	iDm59n40Ka+JdoLlKAGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZtj-0005rN-8j; Wed, 19 Dec 2018 11:20:19 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZtf-0004mX-Fw
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 11:20:17 +0000
Received: by mail-wm1-x344.google.com with SMTP id n190so5706951wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 03:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WBYtpgi3L43g/g3bal8OsjXx3jBVIwyK4ycCMrvCSkk=;
 b=FRaKmh7mMZT2QEE9wDGOGpeyti9mUyh0siUC7a5gkVptOsCADAnD/tAPHmdEe/Ng6R
 TFsiTzmtmF9FnbNe8dlmwvehBS802WJkRIBpTjzffWvREWhBsuCVI7l/8eg+7KmTF+ck
 tPfYXMl6Vk9cGxtjmFhugK/jYWczynFPx96D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WBYtpgi3L43g/g3bal8OsjXx3jBVIwyK4ycCMrvCSkk=;
 b=G8BmbjWqVgJAH4hZ6PUPQoHAM5GP5KOSFk+TWclk5+BBOHAyXEEP55hbCSptPFd2wp
 hbTHxrzAlvITzy6jOZw8aSo+Pb1iKtIgdQPZrUlWt4CwgqAkuUs9Dtth1KqdIOEUXI3J
 Wmhws8m5iIp05A8s9PmD8xRaVAD0pKSi9DE4oCB+r2z1SOeq0gYGchWP9FihsLTFaH4T
 +bQAZE03Tcb1ckLLJyyKHlJoAC7rfCJ75HmaQSGeDMwceoCMsDMKBQ4MOHWEi2jjyQ32
 skf1pSszBMPxuYNPYk95Z2jZ9XDG2NQIog+W16D8Q9ZONXzzOev4tBm+ECUaB6aWZNab
 yVgg==
X-Gm-Message-State: AA+aEWbm/GYdcaB0HIug73VWuWqu2fUDRSMLhOFlNQHr6JWpPY1gVODm
 SVAeKeCHvKYy6eSRBgYSQzg8xA==
X-Google-Smtp-Source: AFSGD/XnZmZt9xFIeOB20qjLjHxFqeLwsBc9nMG284v7jY0YuqvRKn/244M5kqZKPMdnUzyHHjZ0RQ==
X-Received: by 2002:a1c:a9d4:: with SMTP id s203mr5930739wme.132.1545218403694; 
 Wed, 19 Dec 2018 03:20:03 -0800 (PST)
Received: from [192.168.0.40] (197.26.136.77.rev.sfr.net. [77.136.26.197])
 by smtp.googlemail.com with ESMTPSA id l14sm13600521wrp.55.2018.12.19.03.20.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 03:20:02 -0800 (PST)
Subject: Re: [PATCH v10 07/27] cpuidle: dt: Support hierarchical CPU idle
 states
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla
 <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-8-ulf.hansson@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8b8eaac3-9b17-a853-b02e-a5ec4a0c911d@linaro.org>
Date: Wed, 19 Dec 2018 12:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-8-ulf.hansson@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_032015_535316_7A0F3698 
X-CRM114-Status: GOOD (  19.84  )
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Lina Iyer <lina.iyer@linaro.org>, linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjkvMTEvMjAxOCAxODo0NiwgVWxmIEhhbnNzb24gd3JvdGU6Cj4gRnJvbTogTGluYSBJeWVy
IDxsaW5hLml5ZXJAbGluYXJvLm9yZz4KPiAKPiBDdXJyZW50bHkgQ1BVJ3MgaWRsZSBzdGF0ZXMg
YXJlIHJlcHJlc2VudGVkIGluIGEgZmxhdHRlbmVkIG1vZGVsLCB2aWEgdGhlCj4gImNwdS1pZGxl
LXN0YXRlcyIgYmluZGluZyBmcm9tIHdpdGhpbiB0aGUgQ1BVJ3MgZGV2aWNlIG5vZGVzLgo+IAo+
IFN1cHBvcnQgdGhlIGhpZXJhcmNoaWNhbCBsYXlvdXQgZHVyaW5nIHBhcnNpbmcgYW5kIHZhbGlk
YXRpbmcgb2YgdGhlIENQVSdzCj4gaWRsZSBzdGF0ZXMuIFRoaXMgaXMgc2ltcGx5IGRvbmUgYnkg
Y2FsbGluZyB0aGUgbmV3IE9GIGhlbHBlciwKPiBvZl9nZXRfY3B1X3N0YXRlX25vZGUoKS4KPiAK
PiBDYzogTGluYSBJeWVyIDxpbGluYUBjb2RlYXVyb3JhLm9yZz4KPiBTdWdnZXN0ZWQtYnk6IFN1
ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTGluYSBJ
eWVyIDxsaW5hLml5ZXJAbGluYXJvLm9yZz4KPiBDby1kZXZlbG9wZWQtYnk6IFVsZiBIYW5zc29u
IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IFVsZiBIYW5zc29uIDx1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnPgoKUmV2aWV3ZWQtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5p
ZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgoKPiAtLS0KPiAKPiBDaGFuZ2VzIGluIHYxMDoKPiAJLSBO
b25lLgo+IAo+IC0tLQo+ICBkcml2ZXJzL2NwdWlkbGUvZHRfaWRsZV9zdGF0ZXMuYyB8IDUgKyst
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVpZGxlL2R0X2lkbGVfc3RhdGVzLmMgYi9kcml2ZXJz
L2NwdWlkbGUvZHRfaWRsZV9zdGF0ZXMuYwo+IGluZGV4IDUzMzQyYjdmMTAxMC4uMTNmOWI3Y2Qz
MmQxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvY3B1aWRsZS9kdF9pZGxlX3N0YXRlcy5jCj4gKysr
IGIvZHJpdmVycy9jcHVpZGxlL2R0X2lkbGVfc3RhdGVzLmMKPiBAQCAtMTE4LDggKzExOCw3IEBA
IHN0YXRpYyBib29sIGlkbGVfc3RhdGVfdmFsaWQoc3RydWN0IGRldmljZV9ub2RlICpzdGF0ZV9u
b2RlLCB1bnNpZ25lZCBpbnQgaWR4LAo+ICAJZm9yIChjcHUgPSBjcHVtYXNrX25leHQoY3B1bWFz
a19maXJzdChjcHVtYXNrKSwgY3B1bWFzayk7Cj4gIAkgICAgIGNwdSA8IG5yX2NwdV9pZHM7IGNw
dSA9IGNwdW1hc2tfbmV4dChjcHUsIGNwdW1hc2spKSB7Cj4gIAkJY3B1X25vZGUgPSBvZl9jcHVf
ZGV2aWNlX25vZGVfZ2V0KGNwdSk7Cj4gLQkJY3Vycl9zdGF0ZV9ub2RlID0gb2ZfcGFyc2VfcGhh
bmRsZShjcHVfbm9kZSwgImNwdS1pZGxlLXN0YXRlcyIsCj4gLQkJCQkJCSAgIGlkeCk7Cj4gKwkJ
Y3Vycl9zdGF0ZV9ub2RlID0gb2ZfZ2V0X2NwdV9zdGF0ZV9ub2RlKGNwdV9ub2RlLCBpZHgpOwo+
ICAJCWlmIChzdGF0ZV9ub2RlICE9IGN1cnJfc3RhdGVfbm9kZSkKPiAgCQkJdmFsaWQgPSBmYWxz
ZTsKPiAgCj4gQEAgLTE3Niw3ICsxNzUsNyBAQCBpbnQgZHRfaW5pdF9pZGxlX2RyaXZlcihzdHJ1
Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwKPiAgCWNwdV9ub2RlID0gb2ZfY3B1X2RldmljZV9ub2Rl
X2dldChjcHVtYXNrX2ZpcnN0KGNwdW1hc2spKTsKPiAgCj4gIAlmb3IgKGkgPSAwOyA7IGkrKykg
ewo+IC0JCXN0YXRlX25vZGUgPSBvZl9wYXJzZV9waGFuZGxlKGNwdV9ub2RlLCAiY3B1LWlkbGUt
c3RhdGVzIiwgaSk7Cj4gKwkJc3RhdGVfbm9kZSA9IG9mX2dldF9jcHVfc3RhdGVfbm9kZShjcHVf
bm9kZSwgaSk7Cj4gIAkJaWYgKCFzdGF0ZV9ub2RlKQo+ICAJCQlicmVhazsKPiAgCj4gCgoKLS0g
CiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29m
dHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2su
Y29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFy
b29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9n
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
