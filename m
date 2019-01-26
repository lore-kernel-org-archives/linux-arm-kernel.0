Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D4C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:49:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC61214D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S0MSHQIq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="eaqcRrV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC61214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HdPCwLZuTSeDNndDbG1M5sds6FqQ1mHyuAwIWjutPo8=; b=S0MSHQIqp2tL9I
	A7k2uo0OOkKtE7qnym64gzUz4GvsGW0PyVuJleFgUL26qFWgMz6UCRmOyavMSh5loqTD4Qnm14qNT
	dHz4OFoRa8RYYYBE+Ba/c9Kuja97opuUW0jTHp7CKmh+oXKt5vr12uUpfs8ZuNqlr4VAOIzV8Lyd6
	UZW/eveI2cvDpXvmV2EZEOZ1X+r2ZqNuFWvpGbRQHblfZfdP+zHLkCSUfimmYU+8O/Zf5xer+QDO1
	nr/JGQ5wpSjfavd+ciPt8QMVHzXIMQSfzAjS1o9b1kGi96HA12PK7xhTuljAUcnM7hpKt53MZh9rG
	eLUtmXUw6AhQ8TIY8ZLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnR8P-0005Rm-OS; Sat, 26 Jan 2019 16:48:45 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnR8K-0005GE-JW
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 16:48:43 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 5C3ED5C00D5;
 Sat, 26 Jan 2019 17:48:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1548521313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmrneEBPESZO4rZ5YaNDNI0pxmdcbOzgYqXq0Y2bbBQ=;
 b=eaqcRrV1MQrUTIEgZuuch0+kNMaNqiI4CuhxKMKO3iMcoleILAHFNsxr6aIOqFz4xogg6u
 6eByMgx1djO69qnxID8p8zgVQiWGOdGQEYJ8aaflfOcrJ5/iqyd6XlUOnEnw+O4IDqZ/bm
 gqZzaUfWYW6MHs2pQBZOtfPmSglyr00=
MIME-Version: 1.0
Date: Sat, 26 Jan 2019 17:48:33 +0100
From: Stefan Agner <stefan@agner.ch>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH RESEND] ARM: Ensure that NEON code always compiles with
 Clang
In-Reply-To: <20190126040111.9013-1-natechancellor@gmail.com>
References: <20181215212304.19390-1-natechancellor@gmail.com>
 <20190126040111.9013-1-natechancellor@gmail.com>
Message-ID: <20e649cde3fadfa63d7ae9fefbda4915@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_084841_093627_DA219C9C 
X-CRM114-Status: GOOD (  28.25  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Tri Vo <trong@android.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 26.01.2019 05:01, Nathan Chancellor wrote:
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
>>From lib/Basic/Targets/ARM.cpp in the Clang source:
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
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> 
> Resending with Nicolas's ack and Nick's review, to give others a chance
> to pitch in with review/testing before submitting it to the patch
> system (specifically Stefan, sorry I should have included you in the
> previous posting).

No worries.

Looks good to me.

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
> With this patch and:
> * A tip of tree LLVM build (I used apt.llvm.org)
> * Clang GCOV support:
> https://lore.kernel.org/lkml/20190122233749.42220-1-trong@android.com/
> * Two minor hacks for unrelated issues that are still being worked through:
>   *
> https://raw.githubusercontent.com/nathanchance/patches/c313b2fa0efb/linux/build-hax/0003-DO-NOT-UPSTREAM-ARM-Don-t-select-HAVE_FUNCTION_TRACE.patch
> (see https://github.com/ClangBuiltLinux/linux/issues/35)
>   *
> https://gist.githubusercontent.com/nathanchance/b2f5a4015abade1a41e78d5fc3235c5b/raw/744321882ab05511331f26896bad7c9f0056a6a5/gistfile1.txt
> (see https://github.com/ClangBuiltLinux/linux/issues/325)
> 
> I can build and link a little endian allyesconfig ARM kernel. This
> patch alone works with GCC 8.2.0 and binutils 2.31.1.
> 
>  Documentation/arm/kernel_mode_neon.txt | 4 ++--
>  arch/arm/lib/Makefile                  | 2 +-
>  arch/arm/lib/xor-neon.c                | 2 +-
>  lib/raid6/Makefile                     | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/arm/kernel_mode_neon.txt
> b/Documentation/arm/kernel_mode_neon.txt
> index 525452726d31..b9e060c5b61e 100644
> --- a/Documentation/arm/kernel_mode_neon.txt
> +++ b/Documentation/arm/kernel_mode_neon.txt
> @@ -6,7 +6,7 @@ TL;DR summary
>  * Use only NEON instructions, or VFP instructions that don't rely on support
>    code
>  * Isolate your NEON code in a separate compilation unit, and compile it with
> -  '-mfpu=neon -mfloat-abi=softfp'
> +  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp'
>  * Put kernel_neon_begin() and kernel_neon_end() calls around the
> calls into your
>    NEON code
>  * Don't sleep in your NEON code, and be aware that it will be executed with
> @@ -87,7 +87,7 @@ instructions appearing in unexpected places if no
> special care is taken.
>  Therefore, the recommended and only supported way of using NEON/VFP in the
>  kernel is by adhering to the following rules:
>  * isolate the NEON code in a separate compilation unit and compile it with
> -  '-mfpu=neon -mfloat-abi=softfp';
> +  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp';
>  * issue the calls to kernel_neon_begin(), kernel_neon_end() as well
> as the calls
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
> index 2c40aeab3eaa..c691b901092f 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -14,7 +14,7 @@
>  MODULE_LICENSE("GPL");
>  
>  #ifndef __ARM_NEON__
> -#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
> +#error You should compile this file with '-march=armv7-a
> -mfloat-abi=softfp -mfpu=neon'
>  #endif
>  
>  /*
> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> index 4e90d443d1b0..e723eacf7868 100644
> --- a/lib/raid6/Makefile
> +++ b/lib/raid6/Makefile
> @@ -39,7 +39,7 @@ endif
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>  NEON_FLAGS := -ffreestanding
>  ifeq ($(ARCH),arm)
> -NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon
> +NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
>  endif
>  CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
>  ifeq ($(ARCH),arm64)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
