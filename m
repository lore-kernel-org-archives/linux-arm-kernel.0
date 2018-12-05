Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E749C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:38:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F38F2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MuFlNFpp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVYBbuwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F38F2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y/v49VR0pzmsFOupIr9qIdBRFLSNk7zs4+A81WYjyoo=; b=MuFlNFppgR8Ukp
	0uL1ulK33zSFiQ6Qb7VlCRrIfY8Npkqg/Ct6aqbnZhdkD7fqRCX716eGxtMh5XV9lfUyzXUpLYxNq
	LmjhS8lBT/OCxQaAbvlRqhGMOPylJT4Cw48L4Y7uCVSObmqYnYhi45nIrengB//0WQ+GmYY57uDLF
	CjmEj/WcFAApaVPlZNcA5/gXugGKEBQAbbzYxPEcpr9J6G9UxooNAEYJ7kNOr7ywyX7cgpK1oKngz
	a8gN4sGZ6ZyTMerQqeeTQ92jm0C4QpgJekt8mKozl6I+ODbsgsoFk6B130d1NXyan4W/vFhr9NyGF
	daWATYqPJ3Vk7TVFiUfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gURkr-0006i7-Q3; Wed, 05 Dec 2018 07:37:57 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gURko-0006b9-Ao
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 07:37:55 +0000
Received: by mail-it1-x142.google.com with SMTP id p197so18808234itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 23:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z76If0p+l5i8rlrL5R28Djtm7LDYPTVAIf0MqlMbqMk=;
 b=OVYBbuwiJanc+Q0bDCmTelZkKYgn9PTeVkDuj6aOvU1h0ERxw1ES5z05T0OFe4Vzi+
 /ibR1ORs/7k3pgX+kR7HIoMGF6wZgkuveJjn3AeErH+p2dmvLejtGZ+roRpXl1dWlZyU
 U9yE24m9LiDof1MYukKqog87XwO88pLKIwhXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z76If0p+l5i8rlrL5R28Djtm7LDYPTVAIf0MqlMbqMk=;
 b=LpmyvWEXAD5FVJC2TvglxK+5NwJl6At8eQqt0cJQGh+R1Khd3Rqxw4FzcllFWRJtr7
 /5Pd1zve99pCmNKBiQaSEp423w7CD/G4tPtkk4fw7Pf19DyZkDHgq42tzCjSUQl3adHu
 3pb5kEMUNqyLpw+pf65WBHYVKCogWw2rV9pvCkIK6O8pNRnG8HYedX7GowXxsd46UlWb
 V2BrTE7ZAdBEhRRPE7uVlGaScgzsfhyq45FXKoEsrs39mc6Pna4AfYxQTavMjvNpsimh
 eFKSXWvJx/p3kKPFyhY+sgy6qusDsV+qb7qMGr5qZbcd+/Ugb+qK3E8QZs5NCmHYt0j0
 Ucgw==
X-Gm-Message-State: AA+aEWYmRbdO/ILmt4n0WqOlcoWL+EGMbaRkTgvmjLLSPPYs+3Bdd+uP
 xWAx8Wkqqiy/VhGWs2aP5/AiyPFhl2Uq80nF3pRJPQ==
X-Google-Smtp-Source: AFSGD/U1CGTfQ45w7yMuwmETfrPAE0jLsyuJcfuIXJrn/27Yh8JJItcfWnh0wk+b5LRnnCy4ng7DWeKm8Asu4Y9shNc=
X-Received: by 2002:a24:710:: with SMTP id f16mr12835659itf.121.1543995463471; 
 Tue, 04 Dec 2018 23:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 5 Dec 2018 08:37:32 +0100
Message-ID: <CAKv+Gu9doPESm7sb03m=55U6Md=ir8KesRmmMiBeDf+VFm98Cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: Remove '-p' from LDFLAGS
To: Nathan Chancellor <natechancellor@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_233754_364894_DD1E276C 
X-CRM114-Status: GOOD (  17.18  )
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
 Nick Desaulniers <ndesaulniers@google.com>,
 Russell King <linux@armlinux.org.uk>, Stefan Agner <stefan@agner.ch>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
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

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

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
> -LDFLAGS_vmlinux        :=-p --no-undefined -X --pic-veneer
> +LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux        += --be8
>  KBUILD_LDFLAGS_MODULE  += --be8
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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
