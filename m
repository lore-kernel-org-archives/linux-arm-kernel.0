Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB778C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:34:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD652087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XhSuilr1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJ/XCvaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD652087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aO4vKxhCrAVoAJylEg8oVCr+SHy8oLiFO9J/nTlG0lw=; b=XhSuilr13z0d6u
	tb9i+lWBhx4UhTnRamFQZ1bvnmJ18bUKLW7BMqCjBTiyDxEi0hjcu6keynqpk0KA46FIlow91EWis
	IONU+Q+aiIk08a2AI495YTymMl9meVsq0E28dQTWovsVsnxnIctN3Gc61Labkn9rDRWdqGXoAmSJA
	KABca+7MJVkPZw7YVn8xZ4Xz17AR33lG9CMxKK1JYAdXNZvtDGElc+nJ66Y4PPHjpGx2Q1DbZ2flS
	473asw6PPZNJYtZoRYL/IhPkVqGlCMWsEmMK+vpWzZ5w7v+DxX/Ec2hp1NZlQa8Y24ogwVL3mWlPH
	dYyi+vCoTZx1QC56iTrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfouJ-00089c-Sw; Sat, 05 Jan 2019 16:34:43 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfouG-00088p-1p
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 16:34:41 +0000
Received: by mail-qt1-x842.google.com with SMTP id p17so43593783qtl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 05 Jan 2019 08:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=lFCcsjcIHNKsXtTsfi9t1v7WWsUtrFogl1Oy++xtw5c=;
 b=HJ/XCvaKr55MY9weQDtj3muQMBCdUVdcJ+kzQsfHfWTc1JWMa9OQJMzHP2IejUm89r
 YT7spI82z7pr1aPuQgjUQXl+VlExc7G09FEngOpNpTp6fAlO04D21z2eS2djuaU1JAYJ
 ZAdO20MvH1al37+mZTihgNOoFafXpJ4cGNT6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=lFCcsjcIHNKsXtTsfi9t1v7WWsUtrFogl1Oy++xtw5c=;
 b=DHIERfAtjgmP37cuGrgn3GLOB54yJVspgoKhkuU78GjmP0H15EWpLA4LVJL5rbiz4V
 WjUTXtyUm6TB+U3I4lJfWP6EI+gn9R0NmyzlGOp3R2GBy0u4V6rKqFltUZ9nx2A3ctsu
 LR+f1Oza7s888+l5KqOGxDK0Elkf0ytaAM/8qOoVR+yN3sax85tcfhwafPpBxAtI3T/9
 PwIPvkMSFH6DJaJ9EV6EDHMMFh1LBI7QOG9VRsgX59a6udFtaiFdZ2Ayp7bWU/GJo28x
 +zGs+AeM7upjXIjYiH/+7gpmlT2E5r2AiaCXRqAdb58HZEt5lVOAtXRzGkFcT7WGWHS9
 6D5A==
X-Gm-Message-State: AJcUukc36tWcPL2QjyffIMjNt8L8neytXCkFomFFRGVa7YMKVMjB6esX
 RfM2mSHEDtTugl+hZ/AlzqpqDg==
X-Google-Smtp-Source: ALg8bN4dTgCGTmW+w4hSsQUryTrtmZ+/UswVewMx1xrlkbBeO2AuCwMm+eIYUKNG2YtqaVe+uAoWaQ==
X-Received: by 2002:a0c:9144:: with SMTP id q62mr54119304qvq.87.1546706076964; 
 Sat, 05 Jan 2019 08:34:36 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id w34sm33727521qtj.27.2019.01.05.08.34.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 05 Jan 2019 08:34:35 -0800 (PST)
Date: Sat, 5 Jan 2019 11:34:31 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] ARM: Remove '-p' from LDFLAGS
In-Reply-To: <20181231181209.28695-1-natechancellor@gmail.com>
Message-ID: <nycvar.YSQ.7.76.1901051128160.1783@knanqh.ubzr>
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181231181209.28695-1-natechancellor@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_083440_108763_17DE6B1B 
X-CRM114-Status: GOOD (  18.68  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Russell King <linux@armlinux.org.uk>, Stefan Agner <stefan@agner.ch>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 31 Dec 2018, Nathan Chancellor wrote:

> This option is not supported by lld:
> 
>     ld.lld: error: unknown argument: -p
> 
> This has been a no-op in binutils since 2004 (see commit dea514f51da1 in
> that tree). Given that the lowest officially supported of binutils for
> the kernel is 2.20, which was released in 2009, nobody needs this flag
> around so just remove it. Commit 1a381d4a0a9a ("arm64: remove no-op -p
> linker flag") did the same for arm64.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Stefan Agner <stefan@agner.ch>

You may now submit your patch to RMK's patch system:
http://www.arm.linux.org.uk/developer/patches/


> ---
> 
> v1 -> v2:
> 
> * Collect tags
> 
> * Remove an additional occurence of '-p' in the bootp Makefile, thank
>   you to Stefan for pointing it out
> 
> * Drop patch 2/2, it will be fixed properly in lld: https://reviews.llvm.org/D55505
> 
>  arch/arm/Makefile                 | 2 +-
>  arch/arm/boot/bootp/Makefile      | 2 +-
>  arch/arm/boot/compressed/Makefile | 2 --
>  3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 0436002d5091..1d48c8ed5f89 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -10,7 +10,7 @@
>  #
>  # Copyright (C) 1995-2001 by Russell King
>  
> -LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
> +LDFLAGS_vmlinux	:= --no-undefined -X --pic-veneer
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux	+= --be8
>  KBUILD_LDFLAGS_MODULE	+= --be8
> diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
> index 83e1a076a5d6..981a8d03f064 100644
> --- a/arch/arm/boot/bootp/Makefile
> +++ b/arch/arm/boot/bootp/Makefile
> @@ -8,7 +8,7 @@
>  
>  GCOV_PROFILE	:= n
>  
> -LDFLAGS_bootp	:=-p --no-undefined -X \
> +LDFLAGS_bootp	:= --no-undefined -X \
>  		 --defsym initrd_phys=$(INITRD_PHYS) \
>  		 --defsym params_phys=$(PARAMS_PHYS) -T
>  AFLAGS_initrd.o :=-DINITRD=\"$(INITRD)\"
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 01bf2585a0fa..ecfa4ca320a7 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -132,8 +132,6 @@ endif
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux += --be8
>  endif
> -# ?
> -LDFLAGS_vmlinux += -p
>  # Report unresolved symbol references
>  LDFLAGS_vmlinux += --no-undefined
>  # Delete all temporary local symbols
> -- 
> 2.20.1
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
