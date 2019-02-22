Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FC5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:44:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2059207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YVvSgBIW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhihQOMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2059207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nt2dmE0vN64PRHSHvmUmKU0uIRGy8lBGbQ41kzZV6Vw=; b=YVvSgBIWqzLYHY
	U6Oxlo+I/Rwi+rpKsYxv646CudZOVDGA8rPd4mIs8YYcqg6/fQTf+UytLwBpcRsdicKXtcRhuN42b
	w4gla+kWOBzlf8jiWKj/lbEmWCq5DCDJ4swHnCwFB8AZOBFbxS05LNtIrz7GcgrNgIQSj7TPQfFQT
	cXLMeT88EZ3cMZOAFGHy5r4SK+pxObdpQspgkyuFa4cYnEQfK4iClEaspiA6nF5PWNzgmMLBBJnmD
	6/Kb48v+epWVA2iQWD0bdMStyFU4W2qq2EMTEH05bM2y21vQ9jwFx4ZLQcvYa06IyUZig6vurBNfx
	q5LJitQuARvS1RQ8yzFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx6RQ-0004Rf-9U; Fri, 22 Feb 2019 08:44:20 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx6RL-0004Kt-Qe
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:44:18 +0000
Received: by mail-wm1-x341.google.com with SMTP id a62so1164904wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 00:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+k7WjqXlSXeeYi/cEPMO8UdkiVfIG6geAS+jn405B+s=;
 b=EhihQOMVeYH+pw+Rfiehn00JZmCVGtzlQ+IL0xX4JEC/daOeV4uttMMN2Zdpp8WAqv
 BUxoGp+q6ORyeG1WEp0KRBBSeKELSxZEBOw+le4aRs53m9AZgGJwc38IUzK0MsxX6rfD
 zkyGqzSLIaemDdanJvL2gdyinr68vel4bvECUFbSvaQauXXeaOcnpDU1jNF2ka6vcGaO
 beXtypw6oNTabwKnVjctjC53Xh/wPuRPbUps3l/cnmx73qilwGyb1Cg69bIgTkUmxDPy
 EZPryEQKkO9sHqcFfF7Ic9PxEYHsLuI01HbXSJf5q95qlwbeuOUQXu9kiTWi9ZGQ3bgm
 kI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+k7WjqXlSXeeYi/cEPMO8UdkiVfIG6geAS+jn405B+s=;
 b=fdM3StFP1ip8QXuyE7Td/I4ctpkgagPPsLkUeO1YTvxHncWfCpiCMhrB283PNuftIr
 DzS3Yg5M8DG2KtReCdu+2NgdLwee7sHLzKSgJ3JznT+2/azTDx99CapNvefIqyLDpO2s
 xDBkcepsCBLK+ZEP9vIJQoOl+HFGvAqkE/RFpXIPa2k2WOjWlYdqTXuLpG5/+9XqX25u
 GTvrHuEvXHlEUVfo1dabBK9yuckUjgR3q1eCSnUyIDqS0v+Zu/kPHrbnmsC9Y5keB/A0
 8NcgH9q8DFwkFiQ5OAVfsGfkK/WRUy4yzDaIoKm6J7pw39KbHuur4SXp1vcUdzQlLHc/
 gyJQ==
X-Gm-Message-State: AHQUAuYq0EivIEtPrD2ZtXMrDkdfOHQLUEUkYR0DetKpKNKWe4WyaE62
 GwhEv2x3b6CPNFSjNLQikR70anPpIrg=
X-Google-Smtp-Source: AHgI3IY5076+LiSqdD7eEEwny5t0Q8YkPPmff7CrAFAgvOVjPgPOBy0cuRHyX/8aVUZqRW9sUVfffQ==
X-Received: by 2002:a7b:c7c1:: with SMTP id z1mr1621666wmk.77.1550825053505;
 Fri, 22 Feb 2019 00:44:13 -0800 (PST)
Received: from [192.168.0.41] (222.51.92.92.rev.sfr.net. [92.92.51.222])
 by smtp.googlemail.com with ESMTPSA id t18sm1109923wmt.8.2019.02.22.00.44.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 00:44:12 -0800 (PST)
Subject: Re: [PATCH V7 5/8] arm64: tegra: add CPU idle states properties for
 Tegra210
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20190221072150.4395-1-josephl@nvidia.com>
 <20190221072150.4395-6-josephl@nvidia.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e19a6620-4f85-6594-d545-3456d7bb3c91@linaro.org>
Date: Fri, 22 Feb 2019 09:44:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221072150.4395-6-josephl@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_004416_309956_86DCAF49 
X-CRM114-Status: GOOD (  17.84  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjEvMDIvMjAxOSAwODoyMSwgSm9zZXBoIExvIHdyb3RlOgo+IEFkZCBpZGxlIHN0YXRlcyBw
cm9wZXJ0aWVzIGZvciBnZW5lcmljIEFSTSBDUFUgaWRsZSBkcml2ZXIuIFRoaXMKPiBpbmNsdWRl
cyBhIGNwdS1zbGVlcCBzdGF0ZSB3aGljaCBpcyB0aGUgcG93ZXIgZG93biBzdGF0ZSBvZiBDUFUg
Y29yZXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogSm9zZXBoIExvIDxqb3NlcGhsQG52aWRpYS5jb20+
Cj4gQWNrZWQtYnk6IEpvbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPgoKQWNrZWQtYnk6
IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgoKCj4gLS0tCj4gdjc6
Cj4gICogcy9DNy9DUFVfU0xFRVAvICYgcy9jNy9jcHUtc2xlZXAvCj4gICogdXBkYXRlIHRoZSB0
aW1pbmcgb2YgJ2VudHJ5L2V4aXQtbGF0ZW5jeS11cycKPiB2NjoKPiAgKiBhZGQgYWNrIHRhZyBm
cm9tIEpvbi4KPiB2NToKPiAgKiBubyBjaGFuZ2UKPiB2NDoKPiAgKiBubyBjaGFuZ2UKPiB2MzoK
PiAgKiBubyBjaGFuZ2UKPiB2MjoKPiAgKiBhZGQgZW50cnktbGF0ZW5jeS11cyBhbmQgZXhpdC1s
YXRlbmN5LXVzIHByb3BlcnRpZXMKPiAtLS0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9udmlkaWEv
dGVncmEyMTAuZHRzaSB8IDE5ICsrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQs
IDE5IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9u
dmlkaWEvdGVncmEyMTAuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMjEw
LmR0c2kKPiBpbmRleCBhYmJiNjg2YmQ4YmEuLjc5Y2VkZDM2ZmZhZCAxMDA2NDQKPiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdyYTIxMC5kdHNpCj4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9udmlkaWEvdGVncmEyMTAuZHRzaQo+IEBAIC0xMzcxLDI0ICsxMzcxLDQzIEBA
Cj4gIAkJCQkgPCZkZmxsPjsKPiAgCQkJY2xvY2stbmFtZXMgPSAiY3B1X2ciLCAicGxsX3giLCAi
cGxsX3AiLCAiZGZsbCI7Cj4gIAkJCWNsb2NrLWxhdGVuY3kgPSA8MzAwMDAwPjsKPiArCQkJY3B1
LWlkbGUtc3RhdGVzID0gPCZDUFVfU0xFRVA+Owo+ICAJCX07Cj4gIAo+ICAJCWNwdUAxIHsKPiAg
CQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsKPiAgCQkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1
NyI7Cj4gIAkJCXJlZyA9IDwxPjsKPiArCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDUFVfU0xFRVA+
Owo+ICAJCX07Cj4gIAo+ICAJCWNwdUAyIHsKPiAgCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsKPiAg
CQkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1NyI7Cj4gIAkJCXJlZyA9IDwyPjsKPiArCQkJ
Y3B1LWlkbGUtc3RhdGVzID0gPCZDUFVfU0xFRVA+Owo+ICAJCX07Cj4gIAo+ICAJCWNwdUAzIHsK
PiAgCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsKPiAgCQkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4
LWE1NyI7Cj4gIAkJCXJlZyA9IDwzPjsKPiArCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDUFVfU0xF
RVA+Owo+ICsJCX07Cj4gKwo+ICsJCWlkbGUtc3RhdGVzIHsKPiArCQkJZW50cnktbWV0aG9kID0g
InBzY2kiOwo+ICsKPiArCQkJQ1BVX1NMRUVQOiBjcHUtc2xlZXAgewo+ICsJCQkJY29tcGF0aWJs
ZSA9ICJhcm0saWRsZS1zdGF0ZSI7Cj4gKwkJCQlhcm0scHNjaS1zdXNwZW5kLXBhcmFtID0gPDB4
NDAwMDAwMDc+Owo+ICsJCQkJZW50cnktbGF0ZW5jeS11cyA9IDwxMDA+Owo+ICsJCQkJZXhpdC1s
YXRlbmN5LXVzID0gPDMwPjsKPiArCQkJCW1pbi1yZXNpZGVuY3ktdXMgPSA8MTAwMD47Cj4gKwkJ
CQl3YWtldXAtbGF0ZW5jeS11cyA9IDwxMzA+Owo+ICsJCQkJaWRsZS1zdGF0ZS1uYW1lID0gImNw
dS1zbGVlcCI7Cj4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ICsJCQl9Owo+ICAJCX07Cj4g
IAl9Owo+ICAKPiAKCgotLSAKIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKU
giBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0
cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8vdHdp
dHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9yZy9s
aW5hcm8tYmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
