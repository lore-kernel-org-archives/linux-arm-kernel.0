Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2504C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:24:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F4920675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cfuWySiY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="anF8KtfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F4920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e1sruC2iRGWunnmbAoAEN4BpkI3mPac+174XVyVSB5g=; b=cfuWySiYHz6RWj
	5H7yo9nPwhhkZ89tgcKal0u8i7G55QIyZlze0hsSX4OmJRHGRM8sQsd8A6earFx01mSNn9o8qGaXp
	hP5fDnwHhl6Q/4DZE6SGx7v0RBI2BAv8iMag33kGhhZgrLb/CpjaNHZgJ3T/97Pq8w88lIQBxqN9L
	Q2yvToWXG7LFyK7EdzSacddWrXM8ac4YOi7p/mpjBhheIhgxYST5kTcj24PgRprNnfOcBst2uV8Q2
	sIL0Sq8s/oS3yNB+YcB6gTC+zD0UXl5XezV6AZb27kIovHLNVNuM0R5jXJ4dUBbvZ12GNg1JVu7F2
	3XBspDv8CPPP9cxCIcJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYxYq-0001z8-BV; Mon, 17 Dec 2018 18:24:12 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYxYm-0001xi-C1
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 18:24:10 +0000
Received: by mail-qk1-x744.google.com with SMTP id q1so7882258qkf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 10:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=P4GuFcNbaeLR0enY0NKknfehQDA9aBA5NA7dHQ7FTFc=;
 b=anF8KtfH5h2u/u82lNXVbLnHnW4pRnT8emNbzdMGu4BVrB6/eK5wFEc29YYbAerAD7
 8TFU2Ikpx/oTA3wsOw1h3HHmT2g6P1K8dYE1MjqHdLadMKKWEVNNECn2+pfgb4O6TPzC
 W66NLk1F8RRLiJKu4NV4aP4pNyXJ8kTICIsH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=P4GuFcNbaeLR0enY0NKknfehQDA9aBA5NA7dHQ7FTFc=;
 b=Gf8wQaXTcG/Q8H3S81+EtHdbloK9fkqlENaRlZI0W+tgbvjBCzrtjEQgn+qlJqiFig
 cIP2mNGqDfRW/5348nOoHRcIw9BBmTGf7Q0QjR3U0EEvSLlsO9vGT6YVpgrAw9qW9erC
 X5Dd+VK+GJWVwqZb9i46NwRiPDZEKy8GAKWiWJRelHG2l+zNnxypG4M5cgCJniGNKBds
 ybFLeiAAy3RIqwWGuZwXkgcLgTIgW09bc+0LhIMkpKwIpwbCZ6jzEiuK3U2pX4U3SlZS
 wnPnQXaQFjENAgAeOGXsuq6e5+ePy6hld2K+533zIQ234Q104CQEtx87jEROhAwShjOa
 5R/A==
X-Gm-Message-State: AA+aEWb/36UZnmDZtb8KmHRP70nWz5uNlpwSXjkHkWsaPWnKHuu0c+DV
 jVc7oI4OxymJXWLtfkd6IMQInA==
X-Google-Smtp-Source: AFSGD/XZyrsTzjtpaEzU+kGYptY/buHBFtYNi8KH/A9Ew6NwUND1DLZc3TjqMKW8qwnyT1lL52vBOQ==
X-Received: by 2002:a37:1ad9:: with SMTP id l86mr12842072qkh.54.1545071036115; 
 Mon, 17 Dec 2018 10:23:56 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id 5sm10590138qtw.50.2018.12.17.10.23.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 10:23:54 -0800 (PST)
Date: Mon, 17 Dec 2018 13:23:52 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] ARM: Ensure that NEON code always compiles with Clang
In-Reply-To: <20181215212304.19390-1-natechancellor@gmail.com>
Message-ID: <nycvar.YSQ.7.76.1812171318310.3623@knanqh.ubzr>
References: <20181215212304.19390-1-natechancellor@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_102408_416143_68253C12 
X-CRM114-Status: GOOD (  27.64  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Tri Vo <trong@android.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 15 Dec 2018, Nathan Chancellor wrote:

> While building arm32 allyesconfig, I ran into the following errors:
> 
>   arch/arm/lib/xor-neon.c:17:2: error: You should compile this file with
>   '-mfloat-abi=softfp -mfpu=neon'
> 
>   In file included from lib/raid6/neon1.c:27:
>   /home/nathan/cbl/prebuilt/lib/clang/8.0.0/include/arm_neon.h:28:2:
>   error: "NEON support not enabled"
> 
> Building V=1 showed NEON_FLAGS getting passed along to Clang but
> __ARM_NEON__ was not getting defined. Ultimately, it boils down to Clang
> only defining __ARM_NEON__ when targeting armv7, rather than armv6k,
> which is the '-march' value for allyesconfig.
> 
> From lib/Basic/Targets/ARM.cpp in the Clang source:
> 
>   // This only gets set when Neon instructions are actually available, unlike
>   // the VFP define, hence the soft float and arch check. This is subtly
>   // different from gcc, we follow the intent which was that it should be set
>   // when Neon instructions are actually available.
>   if ((FPU & NeonFPU) && !SoftFloat && ArchVersion >= 7) {
>     Builder.defineMacro("__ARM_NEON", "1");
>     Builder.defineMacro("__ARM_NEON__");
>     // current AArch32 NEON implementations do not support double-precision
>     // floating-point even when it is present in VFP.
>     Builder.defineMacro("__ARM_NEON_FP",
>                         "0x" + Twine::utohexstr(HW_FP & ~HW_FP_DP));
>   }
> 
> Ard Biesheuvel recommended explicitly adding '-march=armv7-a' at the
> beginning of the NEON_FLAGS definitions so that __ARM_NEON__ always gets
> definined by Clang. This doesn't functionally change anything because
> that code will only run where NEON is supported, which is implicitly
> armv7.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/287
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Did you test that this doesn't create issues with gcc e.g. complaints 
from the linker that objects have incompatible architecture 
specifications or similar annoyance? This already happened in the past 
but I forget the exact scenario. If you already did, or after you do 
validate with gcc as well, then you may add:

Acked-by: Nicolas Pitre <nico@linaro.org>



> ---
>  Documentation/arm/kernel_mode_neon.txt | 4 ++--
>  arch/arm/lib/Makefile                  | 2 +-
>  arch/arm/lib/xor-neon.c                | 2 +-
>  lib/raid6/Makefile                     | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/arm/kernel_mode_neon.txt b/Documentation/arm/kernel_mode_neon.txt
> index 525452726d31..b9e060c5b61e 100644
> --- a/Documentation/arm/kernel_mode_neon.txt
> +++ b/Documentation/arm/kernel_mode_neon.txt
> @@ -6,7 +6,7 @@ TL;DR summary
>  * Use only NEON instructions, or VFP instructions that don't rely on support
>    code
>  * Isolate your NEON code in a separate compilation unit, and compile it with
> -  '-mfpu=neon -mfloat-abi=softfp'
> +  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp'
>  * Put kernel_neon_begin() and kernel_neon_end() calls around the calls into your
>    NEON code
>  * Don't sleep in your NEON code, and be aware that it will be executed with
> @@ -87,7 +87,7 @@ instructions appearing in unexpected places if no special care is taken.
>  Therefore, the recommended and only supported way of using NEON/VFP in the
>  kernel is by adhering to the following rules:
>  * isolate the NEON code in a separate compilation unit and compile it with
> -  '-mfpu=neon -mfloat-abi=softfp';
> +  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp';
>  * issue the calls to kernel_neon_begin(), kernel_neon_end() as well as the calls
>    into the unit containing the NEON code from a compilation unit which is *not*
>    built with the GCC flag '-mfpu=neon' set.
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index ad25fd1872c7..0bff0176db2c 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -39,7 +39,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
>  $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
>  
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> -  NEON_FLAGS			:= -mfloat-abi=softfp -mfpu=neon
> +  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
>    CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
>    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
>  endif
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index a6741a895189..4600b62d845f 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -14,7 +14,7 @@
>  MODULE_LICENSE("GPL");
>  
>  #ifndef __ARM_NEON__
> -#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
> +#error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
>  #endif
>  
>  /*
> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> index 2f8b61dfd9b0..bfec7c87c61e 100644
> --- a/lib/raid6/Makefile
> +++ b/lib/raid6/Makefile
> @@ -25,7 +25,7 @@ endif
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>  NEON_FLAGS := -ffreestanding
>  ifeq ($(ARCH),arm)
> -NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon
> +NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
>  endif
>  CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
>  ifeq ($(ARCH),arm64)
> -- 
> 2.20.1
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
