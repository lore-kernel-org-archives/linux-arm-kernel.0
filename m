Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96210C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:00:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C91620831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KzaZeSKs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QkwNnTPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C91620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HSLmQCOTl51eRISjT24kSMkG465xQBQZgJ0ebJc7dyw=; b=KzaZeSKs3tYfur
	YiIr+zE59QKRrWZhc6UN+mWITzfsklVGD86+6Eifd0WWF2fm3mF0tOd/lwPChK//ae01euIn9y4E9
	gNyzWJC6QHEbCKGn5/Ku3QDBDwnuqO6ihXGVVFwy82jRcusRDfEVoEgqpfwN7YhnyPPUqau/+nTGY
	Aav+A5afvLZaMT2SF+NCisv7seb2kU8UVHOtMSZ4StVyS88Zp1FnCLF/qpqW9dyEss4QrAVc4H75y
	5ck+Yw71GE0K6TZWgwoyFTUPG+10KZX1+zSb3xm1BtG7+DM6NTcv8Iwr5zJ8UaFVV8fjKg/ckOl86
	wnuB1XMMClkNUv63M6QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW0Yq-0005ys-0v; Sun, 09 Dec 2018 15:00:00 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW0Yn-0005xb-AG
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 14:59:58 +0000
Received: by mail-ot1-x344.google.com with SMTP id i20so8134130otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 06:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cNDhZFMf/+5Sbma1vzSzIDHZ8WGRRV+Q1JX55LNm8NU=;
 b=QkwNnTPW7guKA6TNhaSpmx5XBNdLO9Tvl2Ihnn9dEn7DMEPOjDoAH5kBI5p/gEU+z+
 qwLFSx4c9ztkQaABHSRZ/m3KDz7RvGZoaT+cMjKOegI/ViayN3vN1uDJyd9HtsM5TosX
 EeZx/s1nhUahsgkzxAs56Vq92fEWUEOCFoV00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cNDhZFMf/+5Sbma1vzSzIDHZ8WGRRV+Q1JX55LNm8NU=;
 b=ISzYSYsepIX0H8ace0BBGIqE9B1gie28nh3MAMok6S2mUj42c389s4Yj5WfY2B59tf
 VEmu+Ek7f0AudLjPvj+sfZaYUQHfyHQ+mkj1jSyfbf2Sgn65yDAdz/8EQfiRzR2j4bjO
 ytbg68eJI62Dj92k/yXsVHmuLIrQYWYP3yyCtTYII9d/7MBsZkzX4CuBLNm8qk6DnyaN
 qqnU67WxmSwf+Xz6au/qOUunbir0LXXFqY9JMOppK3uabrM9E0PqxHN7GoB63w4NKi/7
 DLGcRqE8XeEK7XYuHFVq78OVDyRCI48CBgC39zp71ka0twKOu/+SuyOfD7yyowbrvrUY
 D31w==
X-Gm-Message-State: AA+aEWaho5Hh9xi+lXLnwhDEThy9coTNj+Dr1oGKkjtrX+dKem7Yg9bO
 uZfexxx56bGMGPupaKh/X8pTTw==
X-Google-Smtp-Source: AFSGD/WKa/GERQKFIJs5Uxt7J2h8aSHjXtJ/MN5F3cnq1fK3q9qywU91Uh/JaobsBM2PhkDzCbWqXw==
X-Received: by 2002:a9d:72a:: with SMTP id 39mr6888134ote.134.1544367586327;
 Sun, 09 Dec 2018 06:59:46 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id h24sm6360742otm.72.2018.12.09.06.59.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 06:59:45 -0800 (PST)
Subject: Re: [PATCH v6 07/13] arm64: add basic pointer authentication support
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-8-kristina.martsenko@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0cd3ea5e-c705-7e14-bac0-900a4ca7782c@linaro.org>
Date: Sun, 9 Dec 2018 08:59:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-8-kristina.martsenko@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_065957_348056_D8631ACD 
X-CRM114-Status: GOOD (  17.31  )
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
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/18 12:39 PM, Kristina Martsenko wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> This patch adds basic support for pointer authentication, allowing
> userspace to make use of APIAKey, APIBKey, APDAKey, APDBKey, and
> APGAKey. The kernel maintains key values for each process (shared by all
> threads within), which are initialised to random values at exec() time.
> 
> The ID_AA64ISAR1_EL1.{APA,API,GPA,GPI} fields are exposed to userspace,
> to describe that pointer authentication instructions are available and
> that the kernel is managing the keys. Two new hwcaps are added for the
> same reason: PACA (for address authentication) and PACG (for generic
> authentication).
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Tested-by: Adam Wallis <awallis@codeaurora.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/pointer_auth.h | 75 +++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/thread_info.h  |  4 ++
>  arch/arm64/include/uapi/asm/hwcap.h   |  2 +
>  arch/arm64/kernel/cpufeature.c        | 13 ++++++
>  arch/arm64/kernel/cpuinfo.c           |  2 +
>  arch/arm64/kernel/process.c           |  4 ++
>  6 files changed, 100 insertions(+)
>  create mode 100644 arch/arm64/include/asm/pointer_auth.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
