Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92765C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:40:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619D520881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BRTHYLK3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDg/7oUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619D520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nbnz9EQr5RY7NTvw/7h89AuChqMD83kjcgqlfOzyHso=; b=BRTHYLK3M0ZylE
	hmAle0OP+PJlRRG2WBjK04NZh00y2UGqef7ABQOqb5KrGPshqOm7FUS4gGmXY4CXvmdntKbdHeOZt
	L4RQ+f9XFplO69Q/CMZkOcXkx0PraU0Al27hvuS/mwk4/tPFejz9C+4I1tqCpeeUxs8HaLPmgJYw8
	IYEDlLeSeBIQWK4RozCxIc8FQXmhryVP0NYYqLqylmDXe32uarO6MS6r1FHF8jYPfZHuKXUkCKqR5
	SOQoLO6fj6CK/sjR9euApWP801zDxJixXCuaAzOe3s2A1il7jkMlmfVuWJT4MpwCqQ1+JwIQ6DlYW
	2WNky84lpwBb8dKMe4sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2TF-0006Ss-MR; Mon, 28 Jan 2019 08:40:45 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2TC-0006SV-F6
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:40:44 +0000
Received: by mail-wm1-x343.google.com with SMTP id r24so9834244wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SdSKv6edgZBVQ7WdEt1pcKrXPGSSgiq6CrZoSJ1FdME=;
 b=BDg/7oUgcbal0s32SJD5LAtc7/I6ZSXId8xCadLINpGSKHphRvhBCj81kUYEqXqogN
 HZaHfvVHlOyl4LDT1eIAAdXAw9F0+sXHTCenFep07Jj+jqvgCWbPKSqlE/+Go9dw1h1Z
 BnLNToG9q10+9kMTKIR6t6hJNHF5AelgjL/ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SdSKv6edgZBVQ7WdEt1pcKrXPGSSgiq6CrZoSJ1FdME=;
 b=RGXA+gZOoAdxrkzcXdmWkKp+T2NBeMM1qUjAbbQyQg++31Z0fZPC4Ca6+jiMUe640V
 kRUPA8UKxM8YipL3BcDuOfziagtYRla6qQJHxkHrW9h7e7HM9uGk4qdnRLme8wYbwA6y
 eDy4bXQ/BtUVw4+k+tL8c5VTVjkbQeIbHeS5KKNZeVHR/Ng6OVWWElGt0YjlLOAruuXl
 fK5Gx0r95XZ9vjEqX74TKvO4jLzEkXTyniov7FItykYzEj+XYxQkh5s47pd0o0wcx8nn
 vdmIKx6sVhrCylNxZ9j/SX5F83+5fpNu72yjmM1Ir5zkWCqXHPIRG1ndab3PY4tcqpY6
 RQJQ==
X-Gm-Message-State: AJcUuketoIFZIO81G6GU/cm0S+draRFaPAYY3cxCdxyuCLEgui69Phal
 h3Fd0dYeFMNQF3lp9a5QcO7h/A==
X-Google-Smtp-Source: ALg8bN51Sx3K8B2gOLwM1NMf68ZErwghiuv5Q5YB0GbQL7uOvcNwGoQyssPDr9P/3HCv5ih5W36qig==
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr15517889wmf.125.1548664840835; 
 Mon, 28 Jan 2019 00:40:40 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
 by smtp.googlemail.com with ESMTPSA id
 k128sm102490157wmd.37.2019.01.28.00.40.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 00:40:40 -0800 (PST)
Subject: Re: [PATCH v4 9/9] cpufreq: scpi: Use auto-registration of thermal
 cooling device
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <d8626e4c69e7b33a49c1545a9b97eadc7c2b0c2e.1548654899.git.amit.kucheria@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5e1d4915-3c87-ea02-7acf-35b4f1ad3644@linaro.org>
Date: Mon, 28 Jan 2019 09:40:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d8626e4c69e7b33a49c1545a9b97eadc7c2b0c2e.1548654899.git.amit.kucheria@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_004042_535165_982F695C 
X-CRM114-Status: GOOD (  18.43  )
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
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 dianders@chromium.org, swboyd@chromium.org, edubezval@gmail.com,
 mka@chromium.org, viresh.kumar@linaro.org,
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
YXJvLm9yZz4KPiBBY2tlZC1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4K
ClJldmlld2VkLWJ5OiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4K
Cgo+IC0tLQo+ICBkcml2ZXJzL2NwdWZyZXEvc2NwaS1jcHVmcmVxLmMgfCAxNCArKy0tLS0tLS0t
LS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL3NjcGktY3B1ZnJlcS5jIGIvZHJpdmVy
cy9jcHVmcmVxL3NjcGktY3B1ZnJlcS5jCj4gaW5kZXggOTk0NDk3MzhmYWE0Li44MjQyMGU4ZTVm
MGQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL3NjcGktY3B1ZnJlcS5jCj4gKysrIGIv
ZHJpdmVycy9jcHVmcmVxL3NjcGktY3B1ZnJlcS5jCj4gQEAgLTIyLDcgKzIyLDYgQEAKPiAgI2lu
Y2x1ZGUgPGxpbnV4L2NwdS5oPgo+ICAjaW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPgo+ICAjaW5j
bHVkZSA8bGludXgvY3B1bWFzay5oPgo+IC0jaW5jbHVkZSA8bGludXgvY3B1X2Nvb2xpbmcuaD4K
PiAgI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPgo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
Cj4gICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPgo+IEBAIC0zNCw3ICszMyw2IEBACj4g
IHN0cnVjdCBzY3BpX2RhdGEgewo+ICAJc3RydWN0IGNsayAqY2xrOwo+ICAJc3RydWN0IGRldmlj
ZSAqY3B1X2RldjsKPiAtCXN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2Owo+ICB9
Owo+ICAKPiAgc3RhdGljIHN0cnVjdCBzY3BpX29wcyAqc2NwaV9vcHM7Cj4gQEAgLTE4Niw3ICsx
ODQsNiBAQCBzdGF0aWMgaW50IHNjcGlfY3B1ZnJlcV9leGl0KHN0cnVjdCBjcHVmcmVxX3BvbGlj
eSAqcG9saWN5KQo+ICB7Cj4gIAlzdHJ1Y3Qgc2NwaV9kYXRhICpwcml2ID0gcG9saWN5LT5kcml2
ZXJfZGF0YTsKPiAgCj4gLQljcHVmcmVxX2Nvb2xpbmdfdW5yZWdpc3Rlcihwcml2LT5jZGV2KTsK
PiAgCWNsa19wdXQocHJpdi0+Y2xrKTsKPiAgCWRldl9wbV9vcHBfZnJlZV9jcHVmcmVxX3RhYmxl
KHByaXYtPmNwdV9kZXYsICZwb2xpY3ktPmZyZXFfdGFibGUpOwo+ICAJa2ZyZWUocHJpdik7Cj4g
QEAgLTE5NSwyMyArMTkyLDE2IEBAIHN0YXRpYyBpbnQgc2NwaV9jcHVmcmVxX2V4aXQoc3RydWN0
IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpCj4gIAlyZXR1cm4gMDsKPiAgfQo+ICAKPiAtc3RhdGlj
IHZvaWQgc2NwaV9jcHVmcmVxX3JlYWR5KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQo+
IC17Cj4gLQlzdHJ1Y3Qgc2NwaV9kYXRhICpwcml2ID0gcG9saWN5LT5kcml2ZXJfZGF0YTsKPiAt
Cj4gLQlwcml2LT5jZGV2ID0gb2ZfY3B1ZnJlcV9jb29saW5nX3JlZ2lzdGVyKHBvbGljeSk7Cj4g
LX0KPiAtCj4gIHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgc2NwaV9jcHVmcmVxX2RyaXZl
ciA9IHsKPiAgCS5uYW1lCT0gInNjcGktY3B1ZnJlcSIsCj4gIAkuZmxhZ3MJPSBDUFVGUkVRX1NU
SUNLWSB8IENQVUZSRVFfSEFWRV9HT1ZFUk5PUl9QRVJfUE9MSUNZIHwKPiAtCQkgIENQVUZSRVFf
TkVFRF9JTklUSUFMX0ZSRVFfQ0hFQ0ssCj4gKwkJICBDUFVGUkVRX05FRURfSU5JVElBTF9GUkVR
X0NIRUNLIHwKPiArCQkgIENQVUZSRVFfQVVUT19SRUdJU1RFUl9DT09MSU5HX0RFViwKPiAgCS52
ZXJpZnkJPSBjcHVmcmVxX2dlbmVyaWNfZnJlcXVlbmN5X3RhYmxlX3ZlcmlmeSwKPiAgCS5hdHRy
CT0gY3B1ZnJlcV9nZW5lcmljX2F0dHIsCj4gIAkuZ2V0CT0gc2NwaV9jcHVmcmVxX2dldF9yYXRl
LAo+ICAJLmluaXQJPSBzY3BpX2NwdWZyZXFfaW5pdCwKPiAgCS5leGl0CT0gc2NwaV9jcHVmcmVx
X2V4aXQsCj4gLQkucmVhZHkJPSBzY3BpX2NwdWZyZXFfcmVhZHksCj4gIAkudGFyZ2V0X2luZGV4
CT0gc2NwaV9jcHVmcmVxX3NldF90YXJnZXQsCj4gIH07Cj4gIAo+IAoKCi0tIAogPGh0dHA6Ly93
d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBB
Uk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9M
aW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0
ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
