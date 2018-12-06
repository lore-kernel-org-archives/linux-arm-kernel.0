Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E696C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:30:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D9020661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JOVV7oBj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+tWArTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D9020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XQNPbLAPA7EGPtEVbItoaohmN21zWgAPv+Trh5U01+A=; b=JOVV7oBjClyrtk
	aS4ULyQex0nbMATC+EGZyw5xS1+6NFMG59pMKH89DotVOslZyF1w/R7ClZZ44BnVrQhwRniBKca3C
	HSn0tiXxlr5J7LzuAc+Olo1SBEDn7+Q2zhUz+aOWS038DUW+iycEryH1m6wZnatdIaVBOzX2jKmKV
	UQq8L7KqaNg2qYvKICEgotH5BXCvi7IgMvqLOsQ32X3sKfjB2SAiXPMRppEPWqt+52YhJLnfNPHgK
	tLXvWNh6VZDHocFnZUTYB0z6z7POgKm+sd82Pknc7EE2JmU56vG06LucAam7fZnim9Xvq9lKIVVrt
	L9WI3iO7C6gckZEofsCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtjX-00010r-6V; Thu, 06 Dec 2018 13:30:27 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtjP-0000ei-R3
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:30:25 +0000
Received: by mail-wr1-x442.google.com with SMTP id z5so463200wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mfKJIijKVOHLPxQxvHmWc2C5JM72MrjkRIP4pXrZkWY=;
 b=T+tWArTRgEaGFepCTqL+yHUkCUwdYkZiRNqw62iqM7J9KqQE/732sl2xnIGGszjuuQ
 F0sQzmgQQAiCkLLNvjK0dsMHBMTTM/vvyxvZSmnL9xW360xDhx10xkg6tIiChghlHh46
 tIIhhKB27dHUNplFNMbLZhg0bnP6A8NE+bFQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mfKJIijKVOHLPxQxvHmWc2C5JM72MrjkRIP4pXrZkWY=;
 b=mTAcX/llH+rfb6bPaD6OhlHV86/MqMjT94OVxPqjorcQHCfSeLg9pX8h6H1MlajNKA
 8DlRFvi2k8SWnPGAMsMlzAXvDv9GIsMIevjJhedDtVpSi2TxwkzKZeBmKy+0xvt1dZce
 nEvizQz53NsvVidU0SfPig2nEb3yySsl4GgeAtzg5vcgSduMHt4xQld5u1VpfG+rNSoW
 Cvew44eZxahQaOLWV4kQemP+sowX/cYOaQuZxsfTQSgXInQzYbdVi64Ws4Pn7oRD9S4x
 Qp7p3jL18S230fgzbXGTlXcJz55vJnWXPO4M3fE11Wf0G+h4X/93pJAoJtFv+JiUzZvI
 UkQw==
X-Gm-Message-State: AA+aEWbFjEgZnimAex5d3HleCPdQik3zVyzl7TmJ1mugZ6H85knfhp6f
 /wS5ReDDoWTAMo5K47uBFQF2HQ==
X-Google-Smtp-Source: AFSGD/VR2nEBF6Zhk9wMArU1Muo9rBNb+yYhlaUzkOhKknc8QJZ4ELqsmdGBMXWvwTL87wHa3OamWA==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr21909447wrs.318.1544103007242; 
 Thu, 06 Dec 2018 05:30:07 -0800 (PST)
Received: from [192.168.0.40] (172.220.136.77.rev.sfr.net. [77.136.220.172])
 by smtp.googlemail.com with ESMTPSA id c9sm1406802wmh.27.2018.12.06.05.30.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 05:30:06 -0800 (PST)
Subject: Re: [PATCH] thermal: stm32: Fix stm_thermal_read_factory_settings
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>,
 Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>
References: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ecfc241e-7453-36dd-70ba-34b0f2e69dc8@linaro.org>
Date: Thu, 6 Dec 2018 14:30:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_053019_874680_1C577B33 
X-CRM114-Status: GOOD (  17.62  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDYvMTIvMjAxOCAxNDoyMywgRGF2aWQgSEVSTkFOREVaIFNBTkNIRVogd3JvdGU6Cj4gQWRk
aW5nIGJyYWNrZXRzIGFsbG93cyB0byBtdWx0aXBseSB0aGUgcmVnaXN0ZXIgdmFsdWUsCj4gbWFz
a2VkIGJ5IFRTMV9SQU1QX0NPRUZGX01BU0ssIGJ5IGFuIEFESlVTVCB2YWx1ZQo+IHByb3Blcmx5
IGFuZCBub3QgdG8gbXVsdGlwbHkgQURKVVNUIGJ5IHJlZ2lzdGVyIHZhbHVlIGFuZAo+IHRoZW4g
bWFzayB0aGUgd2hvbGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGVybmFuZGV6IFNhbmNo
ZXogPGRhdmlkLmhlcm5hbmRlenNhbmNoZXpAc3QuY29tPgo+IEZpeGVzOiAxZDY5MzE1NSAoInRo
ZXJtYWw6IGFkZCBzdG0zMiB0aGVybWFsIGRyaXZlciIpCgpVc3VhbGx5ICdGaXhlcycgY29tZXMg
Zmlyc3QgaW4gdGhlIGxpc3QuCgpPdGhlciB0aGFuIHRoYXQ6CgpSZXZpZXdlZC1ieTogRGFuaWVs
IExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+Cgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3RoZXJtYWwvc3Qvc3RtX3RoZXJtYWwuYyBiL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhl
cm1hbC5jCj4gaW5kZXggZGFhMTI1Ny4uYmJkNzNjNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Ro
ZXJtYWwvc3Qvc3RtX3RoZXJtYWwuYwo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhl
cm1hbC5jCj4gQEAgLTI0MSw4ICsyNDEsOCBAQCBzdGF0aWMgaW50IHN0bV90aGVybWFsX3JlYWRf
ZmFjdG9yeV9zZXR0aW5ncyhzdHJ1Y3Qgc3RtX3RoZXJtYWxfc2Vuc29yICpzZW5zb3IpCj4gIAkJ
c2Vuc29yLT50MCA9IFRTMV9UMF9WQUwxOwo+ICAKPiAgCS8qIFJldHJpZXZlIGZtdDAgYW5kIHB1
dCBpdCBvbiBIeiAqLwo+IC0Jc2Vuc29yLT5mbXQwID0gQURKVVNUICogcmVhZGxfcmVsYXhlZChz
ZW5zb3ItPmJhc2UgKyBEVFNfVDBWQUxSMV9PRkZTRVQpCj4gLQkJCQkJICAgICAgJiBUUzFfRk1U
MF9NQVNLOwo+ICsJc2Vuc29yLT5mbXQwID0gQURKVVNUICogKHJlYWRsX3JlbGF4ZWQoc2Vuc29y
LT5iYXNlICsKPiArCQkJCSBEVFNfVDBWQUxSMV9PRkZTRVQpICYgVFMxX0ZNVDBfTUFTSyk7Cj4g
IAo+ICAJLyogUmV0cmlldmUgcmFtcCBjb2VmZmljaWVudCAqLwo+ICAJc2Vuc29yLT5yYW1wX2Nv
ZWZmID0gcmVhZGxfcmVsYXhlZChzZW5zb3ItPmJhc2UgKyBEVFNfUkFNUFZBTFJfT0ZGU0VUKSAm
Cj4gCgoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBz
b3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cu
ZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29t
LyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJs
b2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
