Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:22:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F542086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BB/6MLOI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDjkM5O3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F542086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x2/J6oY3ld42QKu7cdjfOAQoZXjTo143/WA/avNgoPc=; b=BB/6MLOIaVvvAH
	GHr7DNRAOal+I+XxwDJuthpHfCUBoZYY45B6cxmb26WBSBkxi94msLnFtkzxF66NALO7kONCoIDCm
	qAHCBrSIC5Zj1dkMA7AqEdrkXlZEbU4CuvN+yeqBxtcKDFwcTn2ENuXNnXq/gcivmoH3iMbK65eeJ
	hT1sqd9FWGjd15hnLrJIhCClAXcfhChrHW7CeUMw4ND9Y46vyJIDVE+lobKNG4JdMokn9h1Zbgl2B
	8SknuN9zInS5QJk544dPLbTpKttUoPn486/9EnXqHjLSBMtyn1EPhmIneJD71hLh0jeps6rzVgm72
	WMgVookOO0/IpXrzx+Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMS3-0005UP-B6; Mon, 10 Dec 2018 14:22:27 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMRx-0005Tb-V9
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 14:22:25 +0000
Received: by mail-ot1-x342.google.com with SMTP id n8so10511150otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 06:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l4J1rNwiRfY2atde+pNuC/RCOGv0XvhLnWyTfm8Kx6o=;
 b=VDjkM5O3nKtNwOdTGGUS50kGy2mre1CwAriJZw6w4tTFULajmo+DAhviWwa3j2iEeC
 YFLl5Gj8YWvO11HgjsUWNxj4CiYs1DdLIL2E4MfwOM8aves3WvSvskmEg2YRa+37Ka0w
 N/e2zcfBU0oYLp/ab2e/P0CXfJr7KwVBtrF8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l4J1rNwiRfY2atde+pNuC/RCOGv0XvhLnWyTfm8Kx6o=;
 b=PawWye5kRWoqVL6FbbPHoh4eQ7g6ToAShRzdD8i9FmI2+ZtVW4NHkiGRbO7fNNClWJ
 Qv9hcnoF8HMIYpSflYg8YHvHhbM3EIvor2VRzZa1SgE6PBZEDi58dfZBW/xpzUQ4vs9E
 7kHpM0jw20xHEi0CVrvdc6FWIMfMln43012lxlRfJ1p6HaSCocQEVWncIfhSzjz42ACD
 WF9DXabNmKznzI/scmV2qYWylHBi1IBdkXFZQsGH+5+FzRyPzxkNOHX/q2x3F1+ZKlYi
 YByvcIGqqfjjaMtTnMtZ2Rz8PimItUxUrQuMd/g/6qwjrtEp0X81s+AcwAnbSHl4wCY2
 bHiw==
X-Gm-Message-State: AA+aEWYjYHKlQURLdtm6peeS1MS7AA29VloOMBJdldlXpPAcZFDTRfmA
 MviqI/HmR0dYvL4XQznEQKTVWA==
X-Google-Smtp-Source: AFSGD/UOxM2x7WK6gkfI6r6Qaia7FeCuytHyl3UQp9MmQQewhmjOgm6aVq/ASsKhAgyx4rMy7nhtxw==
X-Received: by 2002:a9d:42c:: with SMTP id 41mr9300029otc.41.1544451730481;
 Mon, 10 Dec 2018 06:22:10 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id m2sm9077478otp.34.2018.12.10.06.22.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 06:22:09 -0800 (PST)
Subject: Re: [PATCH v6 08/13] arm64: expose user PAC bit positions via ptrace
To: Catalin Marinas <catalin.marinas@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-9-kristina.martsenko@arm.com>
 <a31ca10a-ee1a-71fb-2c3d-a6184e12b543@linaro.org>
 <20181210120330.GB4048@arrakis.emea.arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ba48e082-3e47-43bc-77d1-97d741c59284@linaro.org>
Date: Mon, 10 Dec 2018 08:22:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210120330.GB4048@arrakis.emea.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_062224_256417_2518040C 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Steve Capper <Steve.Capper@arm.com>, Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Dave P Martin <dave.martin@arm.com>, Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/10/18 6:03 AM, Catalin Marinas wrote:
>> However, it won't be too long before someone implements support for
>> ARMv8.2-LVA, at which point, without changes to mandatory pointer tagging, we
>> will only have 3 authentication bits: [54:52].  This seems useless and easily
>> brute-force-able.
> 
> Such support is already here (about to be queued):
> 
> https://lore.kernel.org/linux-arm-kernel/20181206225042.11548-1-steve.capper@arm.com/

Thanks for the pointer.

>> Unfortunately, there is no obvious path to making this optional that does not
>> break compatibility with Documentation/arm64/tagged-pointers.txt.
> 
> There is also the ARMv8.5 MTE (memory tagging) which relies on tagged
> pointers.

So it does.  I hadn't read through that extension completely before.

> An alternative would be to allow the opt-in to 52-bit VA, leaving it at
> 48-bit by default. However, it has the problem of changing the PAC size
> and not being able to return.

Perhaps the opt-in should be at exec time, with ELF flags (or equivalent) on
the application.  Because, as you say, changing the shape of the PAC in the
middle of execution is in general not possible.

It isn't perfect, since old kernels won't fail to exec an application setting
flags that can't be supported.  And it requires tooling changes.


r~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
