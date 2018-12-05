Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C265C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:37:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF49920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eNs/e+Hc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7qC+Qh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF49920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7+gypazaRWdkTrW7ZEGY7eZWCd+Re6obcTRjnOMKXbQ=; b=eNs/e+HcvicdO1
	GFDn8t24YHx/NbvDokqNk+5tNDX9YTLyjoUORLX+A4krIU26+/8RhCkzOSkQyRdcNTnpfSyjkiTqT
	BSw1DthPOcJPmWjCzjqfK2Xan3Gzv/nRKFe5CdRi+fQkpJYzWLdq3lNHAktjieCVOnr2ZTWxB99jz
	deJ+xsyRqH9tuV7gEaRnWlN4XDaLMTJ0S2opcNtUKUX7k600sgyEnaLnUwFOAhCU5qB0CvoGGm/vg
	YOZ4AuWy8LHUr0YcIZc18UJvkXr9a3YtW3ULjEsVkg2j24I5IvX/31l6qjz13nTD5znGRU66UHlVe
	nRDgCeCwMGWAvHeeZTcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaBC-0006D9-F2; Wed, 05 Dec 2018 16:37:42 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaB9-0006C4-Ap
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:37:40 +0000
Received: by mail-qt1-x842.google.com with SMTP id n21so22944684qtl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=ATOrwfo64RSIZVwG3zT6reeU4TTRPGlCQUXTMYzUBeE=;
 b=P7qC+Qh0yJg8wvBxco5Tv0YnPh8gaxi2jwTZX26+jm2H4hFfqdTC8CO8/Gj3BTdRrC
 a+muoSpP0JG93iTepOwGP+4Q8UM8VwT5eXwCmy5ULl3R5RuthBTUtPmsyqTpm643miSt
 43DSn8ERc7IN2FYihZdjw/lrqoLZ929ohWDS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=ATOrwfo64RSIZVwG3zT6reeU4TTRPGlCQUXTMYzUBeE=;
 b=JdoFjHNG8nge1w4Eeq26MmDBZeUnPfRxiFtcRuXnG/QzZv1+95MdcQaQv6USpKS1ra
 dDEEpA54aWhXz8NpSOvVlgfv5m9XfRnQgjlvU+mybS2phlQ+Anu1Hqj6+MsGa///rETu
 3fkr5423XsoLxobun5uEK7kZyMyJa8tK+wmc9GuJQhHR9Ii7fr5gJgw/xDgkUu+nH+bb
 hPEgBlxRgGJgaTxqUy0Huw91UVF75yybKAxGcgZoaoVvj/z/qrl517WNqVPs/Gv9hBmE
 TOcrqtgLYdAKnhee9uuLU8KOtNbMSK+xd5/HQ+X2JsWO3W/ekYzEcFvBZ2vvVFj6QHKo
 zaBg==
X-Gm-Message-State: AA+aEWZHi2Nl+RhAAKUvAxk4sqSbCnlPPz3kSmQgEW3ADom+NTAUobnc
 bWauv1aWYYUwYrDFoBsowpbStw==
X-Google-Smtp-Source: AFSGD/XB+dKMpQoMlgbpaelDKuiRR4aMMN6rE9htYWuRWE6JbgYo2k8sXSFFrXsIXB5V6QYc+qXizA==
X-Received: by 2002:a05:6214:1087:: with SMTP id
 o7mr24780663qvr.115.1544027847713; 
 Wed, 05 Dec 2018 08:37:27 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id v57sm14146080qtv.80.2018.12.05.08.37.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 08:37:26 -0800 (PST)
Date: Wed, 5 Dec 2018 11:37:23 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 1/2] ARM: Remove '-p' from LDFLAGS
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
Message-ID: <nycvar.YSQ.7.76.1812051136470.3623@knanqh.ubzr>
References: <20181205014213.943-1-natechancellor@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_083739_373790_67918597 
X-CRM114-Status: GOOD (  17.88  )
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

On Tue, 4 Dec 2018, Nathan Chancellor wrote:

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

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/Makefile                 | 2 +-
>  arch/arm/boot/compressed/Makefile | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 05a91d8b89f3..e2a0baf36766 100644
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
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 1f5a5ffe7fcf..dcd07bd24b85 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -131,8 +131,6 @@ endif
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux += --be8
>  endif
> -# ?
> -LDFLAGS_vmlinux += -p
>  # Report unresolved symbol references
>  LDFLAGS_vmlinux += --no-undefined
>  # Delete all temporary local symbols
> -- 
> 2.20.0.rc1
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
