Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668E7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:48:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBFA2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dd/RdLVU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QhGKxBJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBFA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lcwhhV+O2xWmWkU171PyTaGLlaNQfCzCp/sGH49N/iE=; b=dd/RdLVUp9jM66
	I721d6QXhRi+HXxS/XjDDC6mfQn0rRpj1pWyonjqt9LzS6bNoSS0AGj3uDXKJRnqXz8VHPQKfR0+n
	up7U07ByDS7C5DKDIuUUWz3UoZq7l5wKAo9vjuhmKuE+xXEkZ6yEEXt3KrcBsjr6yLvgFUBirFch7
	bL6i94jrjoe0dDTlmXFXrDtB6LtYw8Tw2xOCsq/X1StnynUJQJld+yNSbs5ue72jnFQb7tzB0TCwO
	t1p1pKWCIsFYMhanNM01h9CWBTEjr11obNMKpcjJRxDvuIVlso0diNsMr8gzK+N+XLXzRb/ICvDXY
	QUc8dkhhU5iq9zfgd29w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbHE-0006rj-95; Wed, 05 Dec 2018 17:48:00 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbHB-0006qx-8j
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:47:58 +0000
Received: by mail-pg1-x544.google.com with SMTP id w6so9336893pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GWWzcbrSwfAg0ZxQMB2tb6h9CB60uyE2zzgL39jC1qs=;
 b=QhGKxBJVc+/PGXaVm70xwsQpApDz+s2UfTF7gkB0RXEnJxCkN0udCkhAedwxkUZWQH
 Z3z+yxctfHtkqHdRXpei9BNSZqX4xFi+SqOCfAcwQRpbP+0jKjrOVbgmAa407gH6clxW
 sGKYxxsu2ISOUBYU9BMcDrQERLLYHptpxjmR1J54WgJk46n3Dh0XSFp09ZpaIF/9CgGz
 uVCywZ0/C9wIEcZEfr6GFJhWjo/Q7WKC7PL3b1V2KyhSkuKfGsQw97RVvgWSenVsSa02
 Fuq4Qg+6h69qsU0NONkDidqQIKACnNhD8FEpo3nqmjN5rL2VyxcDySRl13OM4AFKuRv/
 Q3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GWWzcbrSwfAg0ZxQMB2tb6h9CB60uyE2zzgL39jC1qs=;
 b=bJ1SB96IVk243WlrqCDE62XpYsrprI7uN0pCr4J8W1d5ecSNyJrn+6JBNs5XCkbTCv
 GNEK2hQZnb+XKeJ6DNTCnnsEmYXt+ByYwdKSighZwjGXAlSOpTs/vS4kTOS0X41fO3W5
 w/rwzhDsCzaHz/aVGq+iF+n5GK3Oca6djZH60Usk1vUUqgATHLb14SJoDpOv69EyPthH
 6sDnfuTYx9sxgp+d9zFpcZ0JisEgqYAq4WAYpo2h6PlKUGyIst4SStnVPtwa/CuNTBb2
 wt6jLwzESS4xqAPQU3FtISvXuzHAaNDB/B8UD0hIG5O7Geb9XzcRKgJzLGHaFgQjCRS4
 SCQQ==
X-Gm-Message-State: AA+aEWYkN0JrQUSFcRi1f7vFBbF3WEnnuJqzKiruIA6gLogvsZuWWeqM
 wWIhjzAIGKULIf4UjFRutyoPkZVaMyOSDAYhyAuKyg==
X-Google-Smtp-Source: AFSGD/U6fSaLsrqIwZBsF5ZBExT8q43sfVzlRaakRZOmgO7OaFsltOEv3p51DpiJfbYstF3xabVXWluEibUKyk2X4WY=
X-Received: by 2002:a65:4683:: with SMTP id h3mr20384165pgr.225.1544032063638; 
 Wed, 05 Dec 2018 09:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 5 Dec 2018 09:47:32 -0800
Message-ID: <CAKwvOdkMbf-=aKrWPZ7nPP0miKDxKMDYN4Kk46N4rxOwHb-zAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: Remove '-p' from LDFLAGS
To: Nathan Chancellor <natechancellor@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_094757_305070_DBFA8109 
X-CRM114-Status: GOOD (  17.77  )
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
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux@armlinux.org.uk,
 Stefan Agner <stefan@agner.ch>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 5:42 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
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

While investigating the context of 1a381d4a0a9a for review, I found
that bfd had removed -p's implementation a long time ago, but kept the
flag as a no-op for compatibility.  I asked that the patch be extended
to arm as well, but don't think a v2 was ever cut.

Thanks for sending this Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
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


-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
