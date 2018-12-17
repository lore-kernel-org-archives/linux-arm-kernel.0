Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:35:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E88206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eV5ci6A9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7uyTR8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E88206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HkKpUzYtqQrtzLesHLDjzfYCty5OrBzvbuoS1LL4WPg=; b=eV5ci6A9q7al3p
	HKpzfX1/zinFIjLhsrlToQ2R20Ah6y6+Bsed5i6S+3JREZ+X1h/YYK6MV2+P32PuIa45ye1AvlbX+
	pEIna6+HcJYnDXtHuwWuLTeQ0Vdw6DBkutUmzlynLfEeqdKtBricTjyU3GBqNRGhjeeigvoyhUPm4
	5OhFxM2w1f9blYFMTYHrZqEh08t14ea9BjKtP6cnNtk0mM/BWQjb55omfXORvg2V1r69XtjfhuYc4
	tIOSoeSNM7wDRgj89MLTw5zYU9Oltl8Hvfd0uShoqeDbWtW3iXXZmci2WJbnpaBKawDx60h/nIFnV
	TvuxUnHPkolM7Mb+JJfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYyfc-0005Y5-K2; Mon, 17 Dec 2018 19:35:16 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYyfY-0004Hd-MB
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 19:35:14 +0000
Received: by mail-wm1-x343.google.com with SMTP id a62so379024wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 11:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=sTAKS+Vyc7ODkqW5h+mrhKCUCTFsO23j0Ib/dkzKqV0=;
 b=f7uyTR8IpNTJQFDNddjUPpaMlMplz3Lj/Ynio1pZvXo++F9VWslCZXEr4r96cOK5dW
 KBTtyAWfLgDakyQzoyAQYKtMsyVjcyy22Qd+mD0kjmCDqfTNtWY0k+XHxLFOsy+/jI24
 a23D3hqw7nXKeSx/1tUmkqk1QFxEuXHqywxhL4yXKyW1Tw4hgSzHl69TF9nItO1BBQ0j
 sJpHcB8EzKchPyZufOOEtJP8B/Dm/dO2deK6d5jgK78g7seCsPEzVpAUeRBVk7eV1BVV
 fIQRjlPyIft/wImSpv3sFp1PC9yh1o79FDzSeuKOOVtSO65wkH7WUDWJc9B3o/CSXi/q
 b6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=sTAKS+Vyc7ODkqW5h+mrhKCUCTFsO23j0Ib/dkzKqV0=;
 b=jNwXmu6R94Ger0vzjR4FJopF1pUkDb03ys3CKZfGPmS5adCIznGDOZdzFtKAiOch5y
 Y6rpvwP2XlshSNbN3Z+hyoNpqYs6Tish9beUhOf8alBGE0Ypyv4PoxkTx3AMqYKJ8ZRz
 ofRQOU/8aSQZgKCbMz8Rn8PrDidblCqO7Lo+dZwejbU1QH4H1RcPZGEXuQZIuX6BYxrT
 9ApmOCeMNC04K1MH+7Js8j/WcaHWbsrkGnHhkBnklxIPn35gNcMbEU7syGCFSG+YHkHQ
 PzroYKNKhoPgExGrW/Y0wQQMrwsrX1X8v1NTfxTbZFbRvWdN3FN00F6cZXSYrL6/71QO
 3b+A==
X-Gm-Message-State: AA+aEWaRYtdmFHJC4NSeGqqYYoHAB522OTqVimNspcqhpG8wAxy0IPRk
 3lJ+rihhldgdrQUzEH+AEPg=
X-Google-Smtp-Source: AFSGD/UAcrep4XoH8YXIr83xXW3TZH4SWqsJnEACpB2Ui1NxroWxCXcgG7k2+mNbBTM2OAZivNb7AQ==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr389555wmg.53.1545075300306;
 Mon, 17 Dec 2018 11:35:00 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id e9sm716361wro.16.2018.12.17.11.34.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 11:34:59 -0800 (PST)
Date: Mon, 17 Dec 2018 12:34:58 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: Ensure that NEON code always compiles with Clang
Message-ID: <20181217193458.GA6671@flashbox>
References: <20181215212304.19390-1-natechancellor@gmail.com>
 <nycvar.YSQ.7.76.1812171318310.3623@knanqh.ubzr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1812171318310.3623@knanqh.ubzr>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_113512_732974_6ADBA9FC 
X-CRM114-Status: GOOD (  33.06  )
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

On Mon, Dec 17, 2018 at 01:23:52PM -0500, Nicolas Pitre wrote:
> On Sat, 15 Dec 2018, Nathan Chancellor wrote:
> 
> > While building arm32 allyesconfig, I ran into the following errors:
> > 
> >   arch/arm/lib/xor-neon.c:17:2: error: You should compile this file with
> >   '-mfloat-abi=softfp -mfpu=neon'
> > 
> >   In file included from lib/raid6/neon1.c:27:
> >   /home/nathan/cbl/prebuilt/lib/clang/8.0.0/include/arm_neon.h:28:2:
> >   error: "NEON support not enabled"
> > 
> > Building V=1 showed NEON_FLAGS getting passed along to Clang but
> > __ARM_NEON__ was not getting defined. Ultimately, it boils down to Clang
> > only defining __ARM_NEON__ when targeting armv7, rather than armv6k,
> > which is the '-march' value for allyesconfig.
> > 
> > From lib/Basic/Targets/ARM.cpp in the Clang source:
> > 
> >   // This only gets set when Neon instructions are actually available, unlike
> >   // the VFP define, hence the soft float and arch check. This is subtly
> >   // different from gcc, we follow the intent which was that it should be set
> >   // when Neon instructions are actually available.
> >   if ((FPU & NeonFPU) && !SoftFloat && ArchVersion >= 7) {
> >     Builder.defineMacro("__ARM_NEON", "1");
> >     Builder.defineMacro("__ARM_NEON__");
> >     // current AArch32 NEON implementations do not support double-precision
> >     // floating-point even when it is present in VFP.
> >     Builder.defineMacro("__ARM_NEON_FP",
> >                         "0x" + Twine::utohexstr(HW_FP & ~HW_FP_DP));
> >   }
> > 
> > Ard Biesheuvel recommended explicitly adding '-march=armv7-a' at the
> > beginning of the NEON_FLAGS definitions so that __ARM_NEON__ always gets
> > definined by Clang. This doesn't functionally change anything because
> > that code will only run where NEON is supported, which is implicitly
> > armv7.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/287
> > Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Did you test that this doesn't create issues with gcc e.g. complaints 
> from the linker that objects have incompatible architecture 
> specifications or similar annoyance? This already happened in the past 
> but I forget the exact scenario. If you already did, or after you do 
> validate with gcc as well, then you may add:
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> 

Hi Nicolas,

I was 99% sure that I checked GCC before sending this but I just did
another run to confirm and everything links successfully. We still use
binutils for assembling/linking the kernel so I assume that I would have
seen a warning from ld.bfd even with Clang.

Thank you for the review!
Nathan

> 
> > ---
> >  Documentation/arm/kernel_mode_neon.txt | 4 ++--
> >  arch/arm/lib/Makefile                  | 2 +-
> >  arch/arm/lib/xor-neon.c                | 2 +-
> >  lib/raid6/Makefile                     | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/arm/kernel_mode_neon.txt b/Documentation/arm/kernel_mode_neon.txt
> > index 525452726d31..b9e060c5b61e 100644
> > --- a/Documentation/arm/kernel_mode_neon.txt
> > +++ b/Documentation/arm/kernel_mode_neon.txt
> > @@ -6,7 +6,7 @@ TL;DR summary
> >  * Use only NEON instructions, or VFP instructions that don't rely on support
> >    code
> >  * Isolate your NEON code in a separate compilation unit, and compile it with
> > -  '-mfpu=neon -mfloat-abi=softfp'
> > +  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp'
> >  * Put kernel_neon_begin() and kernel_neon_end() calls around the calls into your
> >    NEON code
> >  * Don't sleep in your NEON code, and be aware that it will be executed with
> > @@ -87,7 +87,7 @@ instructions appearing in unexpected places if no special care is taken.
> >  Therefore, the recommended and only supported way of using NEON/VFP in the
> >  kernel is by adhering to the following rules:
> >  * isolate the NEON code in a separate compilation unit and compile it with
> > -  '-mfpu=neon -mfloat-abi=softfp';
> > +  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp';
> >  * issue the calls to kernel_neon_begin(), kernel_neon_end() as well as the calls
> >    into the unit containing the NEON code from a compilation unit which is *not*
> >    built with the GCC flag '-mfpu=neon' set.
> > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> > index ad25fd1872c7..0bff0176db2c 100644
> > --- a/arch/arm/lib/Makefile
> > +++ b/arch/arm/lib/Makefile
> > @@ -39,7 +39,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
> >  $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
> >  
> >  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> > -  NEON_FLAGS			:= -mfloat-abi=softfp -mfpu=neon
> > +  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> >    CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
> >    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
> >  endif
> > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > index a6741a895189..4600b62d845f 100644
> > --- a/arch/arm/lib/xor-neon.c
> > +++ b/arch/arm/lib/xor-neon.c
> > @@ -14,7 +14,7 @@
> >  MODULE_LICENSE("GPL");
> >  
> >  #ifndef __ARM_NEON__
> > -#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
> > +#error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
> >  #endif
> >  
> >  /*
> > diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> > index 2f8b61dfd9b0..bfec7c87c61e 100644
> > --- a/lib/raid6/Makefile
> > +++ b/lib/raid6/Makefile
> > @@ -25,7 +25,7 @@ endif
> >  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> >  NEON_FLAGS := -ffreestanding
> >  ifeq ($(ARCH),arm)
> > -NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon
> > +NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> >  endif
> >  CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
> >  ifeq ($(ARCH),arm64)
> > -- 
> > 2.20.1
> > 
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
