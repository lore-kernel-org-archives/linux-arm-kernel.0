Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7BAC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:37:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B99520881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BwfCmB2C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="To047cwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B99520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QUK3s03LaELLhPi6D5k2VtvYUfmImPawSBb4t9xq1SY=; b=BwfCmB2CFQx1gH
	nohE1a3zATIXoKPZFBE2hMd8rAnTLHT1odgXQovcbdmGPY5fLP9zq52uiBRjvOtu/pp6dwlguFVD6
	0hRtewqaZiwPCvwpChUJVuUPhf4zW0MYJU4g03+ZNwynjh5r4pDVxg1ISriAGBxWxB2bD+UTcJeG2
	ZkoO7E6RPG6zNC82E53oaBJYLWoPsiKW93s/5QDTQAj8z4SCux6CvzTkKDjMTqiwSQKcTc+pAF5JD
	rA3Y9OT7qNCEnpNukS2FM/qulaVUtcMAv+QnYtAaVQEutRc0y/a2m5QizhJ1x9/aF/rVbF8ZxIBZI
	2OZsQ3Acw/2WJHjX3jPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2Pk-0004RZ-At; Mon, 28 Jan 2019 08:37:08 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2Pg-0004Qv-OD
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:37:06 +0000
Received: by mail-wm1-x343.google.com with SMTP id y139so12861251wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=k1lcqYBnFAgxOzBCUuFKwVUkEDF/OrdjAUhRMXm0UH0=;
 b=To047cwBW40bx/zOhcj3gnlH+6vyHNeuNlIRzIvwR1Z/OVgTLgPinSwLdd/UdMLhUK
 WJ3D6O+1+R6WczuPc6afEhOYe+R4q9cXq5OpfIcVUOazqh3Eh5OG1p9vR+AAAnKkKQEH
 7/5qJSakePYQqLubgQjdP1ZxBOVLru8d/BRPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k1lcqYBnFAgxOzBCUuFKwVUkEDF/OrdjAUhRMXm0UH0=;
 b=C2fTCtFSGM9UeifwaYAUkcQIkadcNyEjvznXehyiSwz8kG+4CEDnv81U433OPaBwRy
 4vC3UTvt+jFbCIlyxJazieqB3lFaU3t61Rxjrk32Btx+CTDqbWYlkQWQjVd3dNNflmr0
 SRPkTDZPhZ6l76CLH2mNk1VTumSZUs/4oRH3j5hg95xL7lxHuSY3yYVi6sko6nJKNgQ9
 e9Yz++XHd7Xsr18pqOFCSkih8ZmCuVe/1ChFdkyr6+dvADd3fLWQT2yKOtzwwsGXI70W
 xz6eNmx2192sMyrW/dNeABFnyiq1jyOwBSpRb37GNLlTOK6LynkTHqXZOmLLk9GYPM3H
 qFvQ==
X-Gm-Message-State: AJcUukcdyVZfwuwS14ZjyFdfz5lqP6aUP+97YImECRlnixd8iIbFbI42
 pWz0BHnxLFFkx9KCjfanv1WDeg==
X-Google-Smtp-Source: ALg8bN4Vbk7pPwU1IMMktW5ZQjFTG00iGYek+PrEtyQwsgHmQSFc9nO5Q4b6NQmlpguGAmHoHTVM5w==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr16554013wma.85.1548664620978; 
 Mon, 28 Jan 2019 00:37:00 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
 by smtp.googlemail.com with ESMTPSA id
 a12sm125686093wro.18.2019.01.28.00.36.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 00:37:00 -0800 (PST)
Subject: Re: [PATCH v4 6/9] cpufreq: mediatek: Use auto-registration of
 thermal cooling device
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <f4d658bcbc428f6fb9bd70bcd9c7a0b00a20cd08.1548654899.git.amit.kucheria@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <11c4bde4-a113-6588-be6a-0904be1974d5@linaro.org>
Date: Mon, 28 Jan 2019 09:36:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f4d658bcbc428f6fb9bd70bcd9c7a0b00a20cd08.1548654899.git.amit.kucheria@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_003704_791865_667A1982 
X-CRM114-Status: GOOD (  18.97  )
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
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Sean Wang <sean.wang@mediatek.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 dianders@chromium.org, swboyd@chromium.org, edubezval@gmail.com,
 mka@chromium.org, linux-mediatek@lists.infradead.org, viresh.kumar@linaro.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjgvMDEvMjAxOSAwNzo0MSwgQW1pdCBLdWNoZXJpYSB3cm90ZToKPiBVc2UgdGhlIENQVUZS
RVFfQVVUT19SRUdJU1RFUl9DT09MSU5HX0RFViBmbGFnIHRvIGFsbG93IGNwdWZyZXEgY29yZSB0
bwo+IGF1dG9tYXRpY2FsbHkgcmVnaXN0ZXIgYXMgYSB0aGVybWFsIGNvb2xpbmcgZGV2aWNlLgo+
IAo+IFRoaXMgYWxsb3dzIHJlbW92YWwgb2YgYm9pbGVyIHBsYXRlIGNvZGUgZnJvbSB0aGUgZHJp
dmVyLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFtaXQgS3VjaGVyaWEgPGFtaXQua3VjaGVyaWFAbGlu
YXJvLm9yZz4KClJldmlld2VkLWJ5OiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZz4KCgo+IC0tLQo+ICBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS5jIHwg
MTQgKystLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTIg
ZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1j
cHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS5jCj4gaW5kZXggZWI4
OTIwZDM5ODE4Li45YTkzN2Y0YzYzZTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL21l
ZGlhdGVrLWNwdWZyZXEuYwo+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVx
LmMKPiBAQCAtMTQsNyArMTQsNiBAQAo+ICAKPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgo+ICAj
aW5jbHVkZSA8bGludXgvY3B1Lmg+Cj4gLSNpbmNsdWRlIDxsaW51eC9jcHVfY29vbGluZy5oPgo+
ICAjaW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPgo+ICAjaW5jbHVkZSA8bGludXgvY3B1bWFzay5o
Pgo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4gQEAgLTQ4LDcgKzQ3LDYgQEAgc3RydWN0
IG10a19jcHVfZHZmc19pbmZvIHsKPiAgCXN0cnVjdCByZWd1bGF0b3IgKnNyYW1fcmVnOwo+ICAJ
c3RydWN0IGNsayAqY3B1X2NsazsKPiAgCXN0cnVjdCBjbGsgKmludGVyX2NsazsKPiAtCXN0cnVj
dCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2Owo+ICAJc3RydWN0IGxpc3RfaGVhZCBsaXN0
X2hlYWQ7Cj4gIAlpbnQgaW50ZXJtZWRpYXRlX3ZvbHRhZ2U7Cj4gIAlib29sIG5lZWRfdm9sdGFn
ZV90cmFja2luZzsKPiBAQCAtMzA3LDEzICszMDUsNiBAQCBzdGF0aWMgaW50IG10a19jcHVmcmVx
X3NldF90YXJnZXQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksCj4gIAo+ICAjZGVmaW5l
IERZTkFNSUNfUE9XRVIgImR5bmFtaWMtcG93ZXItY29lZmZpY2llbnQiCj4gIAo+IC1zdGF0aWMg
dm9pZCBtdGtfY3B1ZnJlcV9yZWFkeShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkKPiAt
ewo+IC0Jc3RydWN0IG10a19jcHVfZHZmc19pbmZvICppbmZvID0gcG9saWN5LT5kcml2ZXJfZGF0
YTsKPiAtCj4gLQlpbmZvLT5jZGV2ID0gb2ZfY3B1ZnJlcV9jb29saW5nX3JlZ2lzdGVyKHBvbGlj
eSk7Cj4gLX0KPiAtCj4gIHN0YXRpYyBpbnQgbXRrX2NwdV9kdmZzX2luZm9faW5pdChzdHJ1Y3Qg
bXRrX2NwdV9kdmZzX2luZm8gKmluZm8sIGludCBjcHUpCj4gIHsKPiAgCXN0cnVjdCBkZXZpY2Ug
KmNwdV9kZXY7Cj4gQEAgLTQ3Miw3ICs0NjMsNiBAQCBzdGF0aWMgaW50IG10a19jcHVmcmVxX2V4
aXQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpCj4gIHsKPiAgCXN0cnVjdCBtdGtfY3B1
X2R2ZnNfaW5mbyAqaW5mbyA9IHBvbGljeS0+ZHJpdmVyX2RhdGE7Cj4gIAo+IC0JY3B1ZnJlcV9j
b29saW5nX3VucmVnaXN0ZXIoaW5mby0+Y2Rldik7Cj4gIAlkZXZfcG1fb3BwX2ZyZWVfY3B1ZnJl
cV90YWJsZShpbmZvLT5jcHVfZGV2LCAmcG9saWN5LT5mcmVxX3RhYmxlKTsKPiAgCj4gIAlyZXR1
cm4gMDsKPiBAQCAtNDgwLDEzICs0NzAsMTMgQEAgc3RhdGljIGludCBtdGtfY3B1ZnJlcV9leGl0
KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQo+ICAKPiAgc3RhdGljIHN0cnVjdCBjcHVm
cmVxX2RyaXZlciBtdGtfY3B1ZnJlcV9kcml2ZXIgPSB7Cj4gIAkuZmxhZ3MgPSBDUFVGUkVRX1NU
SUNLWSB8IENQVUZSRVFfTkVFRF9JTklUSUFMX0ZSRVFfQ0hFQ0sgfAo+IC0JCSBDUFVGUkVRX0hB
VkVfR09WRVJOT1JfUEVSX1BPTElDWSwKPiArCQkgQ1BVRlJFUV9IQVZFX0dPVkVSTk9SX1BFUl9Q
T0xJQ1kgfAo+ICsJCSBDUFVGUkVRX0FVVE9fUkVHSVNURVJfQ09PTElOR19ERVYsCj4gIAkudmVy
aWZ5ID0gY3B1ZnJlcV9nZW5lcmljX2ZyZXF1ZW5jeV90YWJsZV92ZXJpZnksCj4gIAkudGFyZ2V0
X2luZGV4ID0gbXRrX2NwdWZyZXFfc2V0X3RhcmdldCwKPiAgCS5nZXQgPSBjcHVmcmVxX2dlbmVy
aWNfZ2V0LAo+ICAJLmluaXQgPSBtdGtfY3B1ZnJlcV9pbml0LAo+ICAJLmV4aXQgPSBtdGtfY3B1
ZnJlcV9leGl0LAo+IC0JLnJlYWR5ID0gbXRrX2NwdWZyZXFfcmVhZHksCj4gIAkubmFtZSA9ICJt
dGstY3B1ZnJlcSIsCj4gIAkuYXR0ciA9IGNwdWZyZXFfZ2VuZXJpY19hdHRyLAo+ICB9Owo+IAoK
Ci0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNl
IHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vi
b29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9s
aW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4g
QmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
