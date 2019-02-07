Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C529C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:34:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5F4206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tHVsOtk+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5T1SF6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5F4206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hugDtYGHoFJXTmenQ+RBGRSEEukOkMNa+4u8KPBwCP8=; b=tHVsOtk+ENWYo0
	su0lbwNOPEoUAEPts9MnZGXvszkUT07xBCt0Gn+qGIBAk1LiOvlAPukbKJJK33pi+hZSDKEeS/DJO
	NYbyXV8RCic1Se9ouI8RWXLoEkih2Nu1msmnpfIZA7yTmU6fkG0jBOIpBhPE2YUWMtPhKFlYSWHDH
	adFaMb7yhMEk1sV6ly8yB8jXzqgaS41LrFqsQA8F5auYsIkeYJZqCI/ZuT+ikfw2UeKewGEvGKem7
	spzzD8RIjAnLFMwRfQrG1nSiutGAkzOeDNnaZE/pIJn5e5xqtewuGrAOSwnMuAReaATHt3MwaslL1
	s2d3qMKdhepncivLcqlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjpD-0003Ay-BT; Thu, 07 Feb 2019 13:34:43 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjpA-0003Ae-AQ
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:34:41 +0000
Received: by mail-it1-x144.google.com with SMTP id q78so5499233itc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4JkB7tkcxbbK3agVR2jQok9w+5Zbzlx0aaFAqKfM03I=;
 b=W5T1SF6jdEsuUqv6d17UoJrsZBcCP0NikNoDcomPUq+0g2v8gYD+WR2E2p5k7t/ZDJ
 CYi5No/1yi0U3rFYYPsHvpQgf70Jy46Vd+5Ch3aTMkYfAB1K5jiENFCxsnvJSpWacZQj
 Yr9IczkN2j3SBWR8yAsGR/t+M9amEZ8mSs0INwnEw6ePPRb+a96kMWQ1bkdqkFUQEygw
 Ii+yeVQnY/eBLRp09Tq2xyt/I+/Wua3XFXlP8TYCXqgyTlTMfNC4n+sFfelTU/nATPC8
 sZLPqW6jAmbT9Z2njrUU4BUUgdOwhfcR3E1wtJtxzs/mUAzAl6SfKRLfdR1mgcM6/qJq
 TfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4JkB7tkcxbbK3agVR2jQok9w+5Zbzlx0aaFAqKfM03I=;
 b=olH4Iipq5hD10QCIC/+j5rWmi69CW9WLsOtkTes1QLPNAEB8EzZz+5KqeyiJxwoRgk
 ooQuNIMEFkDu6zfltb+leGqpsBOaBWqoNX/jqp7ozmM8dCjWUaA25x2spAQPG9AxqlVt
 BctCtDmT1wc+BhjMHmnK6ZxR5WDafQN96K2ix3SmE9eSaRn/4ch+sqsk0g2z+A7LHqzl
 jy2LH90S+NL6qkFFjmPnmnk3/j0TQtV9wJrK2aoPvrlDSOwAAgFYrhVKdAQZun+PdWo6
 Z7eWna+qBdrQ/ijuMtM7nm96QWnA6N23n012S/YIBlj2A3CKM2sa3V9/KafUzoYcAURj
 1OiA==
X-Gm-Message-State: AHQUAuboLRQL7vcpF79Cirv+NRGQk4JIRANu5ppKbyw0Zg+R43SwGSyu
 s93cp2dYkDGN8avAj15BwD6YcClrvtJdf1cTc5DtEw==
X-Google-Smtp-Source: AHgI3IaX/dgjnukzwfvJI2QNvYhoF+7bgFwR9XZoKMgId8AENtAa3WHxYus9EjG2ibv9rCbrMmLwmcxAlvu6fJEdnOA=
X-Received: by 2002:a5e:9704:: with SMTP id w4mr1512278ioj.60.1549546479240;
 Thu, 07 Feb 2019 05:34:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549532513.git.stefan@agner.ch>
 <5b710816f634307d6a67ffcf7e4b538818dcb2a3.1549532513.git.stefan@agner.ch>
In-Reply-To: <5b710816f634307d6a67ffcf7e4b538818dcb2a3.1549532513.git.stefan@agner.ch>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 7 Feb 2019 14:34:27 +0100
Message-ID: <CAKv+Gu97N_DFpaYGq60i0Fvn3XS=1k7Zihh2Zz9Cs+uua1EuLw@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: use unified assembler in macros
To: Stefan Agner <stefan@agner.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_053440_384970_214457E6 
X-CRM114-Status: GOOD (  16.29  )
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
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Julien Thierry <julien.thierry@arm.com>, Will Deacon <will.deacon@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stefan,

On Thu, 7 Feb 2019 at 10:46, Stefan Agner <stefan@agner.ch> wrote:
>
> Use unified assembler syntax (UAL) in macros. Divided syntax is
> considered depricated.

'deprecated'

> This will also allow to build the kernel
> using LLVM's integrated assembler.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/lib/copy_from_user.S | 2 +-
>  arch/arm/lib/copy_to_user.S   | 2 +-
>  arch/arm/lib/memcpy.S         | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> index 0d4c189c7f4f..712ca399f559 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -91,7 +91,7 @@
>         .endm
>
>         .macro str1b ptr reg cond=al abort
> -       str\cond\()b \reg, [\ptr], #1
> +       strb\cond\() \reg, [\ptr], #1

You can drop the null token here, you only need that in the middle of
a word. Same below.


>         .endm
>
>         .macro enter reg1 reg2
> diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
> index 97a6ff4b7e3c..2e402b815e13 100644
> --- a/arch/arm/lib/copy_to_user.S
> +++ b/arch/arm/lib/copy_to_user.S
> @@ -49,7 +49,7 @@
>         .endm
>
>         .macro ldr1b ptr reg cond=al abort
> -       ldr\cond\()b \reg, [\ptr], #1
> +       ldrb\cond\() \reg, [\ptr], #1
>         .endm
>
>  #ifdef CONFIG_CPU_USE_DOMAINS
> diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
> index 64111bd4440b..1c9e625148ca 100644
> --- a/arch/arm/lib/memcpy.S
> +++ b/arch/arm/lib/memcpy.S
> @@ -30,7 +30,7 @@
>         .endm
>
>         .macro ldr1b ptr reg cond=al abort
> -       ldr\cond\()b \reg, [\ptr], #1
> +       ldrb\cond\() \reg, [\ptr], #1
>         .endm
>
>         .macro str1w ptr reg abort
> @@ -42,7 +42,7 @@
>         .endm
>
>         .macro str1b ptr reg cond=al abort
> -       str\cond\()b \reg, [\ptr], #1
> +       strb\cond\() \reg, [\ptr], #1
>         .endm
>
>         .macro enter reg1 reg2
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
