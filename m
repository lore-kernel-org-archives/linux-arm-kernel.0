Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB21C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:34:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5FA21B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l12GMxOv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vc9pKRA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5FA21B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZSSypVaLO0g2Lbd9PB4Xz+lcss0DShQZweAPch4Wa+A=; b=l12GMxOv6+3xBr
	Mt1ped9IlZyzjWSSpHGsW2cCeY6FCR1druG73yDLD/2W5pq6VhnfCqOypznsOP8kcRD0N4YB2K+Mw
	xxW65kCOuyKtWdwub6FWjGG6KdG8redYWvQ2Fa9SzWjDq+LPsHltWwY3VthcvI8IMpcVF/NU89jxn
	84SHcSOpyuTnkYC6A5ewz/8A1tBYKhxA4nJ1pHZxtaFR6svbDPlV2zcf17RPzKczLzoZIXH3M7A/S
	BkqVda8+aQdaVfUir9NURVHrvUYlN6ApD8onRvDm2qbPV/B008Ab1C1aqvzaelndg8PmxntdVGKL0
	qp262MJilCUMpQqMRVHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gteks-0003Lo-7q; Tue, 12 Feb 2019 20:34:10 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtekn-0003Ks-OC
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:34:07 +0000
Received: by mail-it1-x143.google.com with SMTP id o131so62782itc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 12:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KsP52gXpIrDlK2bHNK6azfsaCrp5vyuXdhZ92N0Vgfc=;
 b=vc9pKRA4uKiOJzb9TkfXKvyDbPoQE7sAI9osiFpfZtsTuq/UdzlKNA6eBMCmzAoXW0
 bPwPqBiuxxi8VjM8FYafqAD2JTLkwpMjIGTugcjA7+ZskGB62CD/khnIaFTUdumU5vAe
 QmJWuHxqEQZydaQpM5/Vkr3y4mrG3+42q66vzq/EGEU3dvw/ap0zMbnSXj2o1lh5Psqb
 LSslbL4zWm6u4i8pJn2E5JAEa3LYy7ojtoIEGOYyIsnZEldVRUkelB3rW6JxOvS8Jhkp
 re2bxXKkCOrEFhAWwGhJQnLDux/pyk8OADtzc9LfBYRQRv9+3ojB3KwCYwBTdmvdN4lY
 Fdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KsP52gXpIrDlK2bHNK6azfsaCrp5vyuXdhZ92N0Vgfc=;
 b=JMiC8zurmM0Ex8RmKxXnanLDpJGeTU/C/oIG/XbQGu5qu9KyH/N7Pc9uZMLrWiQbxP
 KKYz0pj23ztm4xJgoC7JGz+eIbQnihbxN86MSZCc2bbsTwOsUvIOb/Xgy22Pr8K2tN5+
 5FYdnRhzJGm+M1cpW6gP+M1X1WEckAbqGPe5qRA7py14v74cmy66KX5z328kE6NEOISY
 RpETpIjC7w4TnBPda/JZPt+VHga31m+GStYX78Oj0+jz+m+XX8Gg4TGPf6uWiu92pyQv
 JrABlRH6/WjL2P2P82JKRyoJ0RaExarblPIdaT+oWhbLENX1TrfezhZI27QhU1pISuto
 46Cw==
X-Gm-Message-State: AHQUAubk2zwJyZ20JrExAyWPvd6eFo8QWvUwiyg9K9wXvKIS/OB+LzQ2
 73DKaXRIKLl/GzZMjQr7JF2rzBLi5o0mXqu9m4vj2A==
X-Google-Smtp-Source: AHgI3IbflAdIGmgaUuPONaXGFJgvUecTLtBWQe/1V1RUjrwldhvT0b1cxWXsDF/CzcnkestXSnOibR9GNlixV9EqwJw=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr423122itk.71.1550003643398; 
 Tue, 12 Feb 2019 12:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20190212194645.32504-1-broonie@kernel.org>
In-Reply-To: <20190212194645.32504-1-broonie@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 12 Feb 2019 20:33:57 +0000
Message-ID: <CAKv+Gu-W2X32ZCqKsJVqSqyJ04UK2eoNCDKp=2OfsO1HhKaCuw@mail.gmail.com>
Subject: Re: [PATCH] arm64: crypto: Disable xor-neon build when using clang
To: Mark Brown <broonie@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_123405_809040_55187B10 
X-CRM114-Status: GOOD (  26.63  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jackie Liu <liuyun01@kylinos.cn>,
 Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will.deacon@arm.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 12 Feb 2019 at 20:46, Mark Brown <broonie@kernel.org> wrote:
>
> Currently clang is able to build an arm64 defconfig or allmodconfig
> using the release branch for clang 8 apart from a series of errors in
> xor-neon.c in the form:
>
>   arch/arm64/lib/xor-neon.c:27:28: error: incompatible pointer types assigning to 'const unsigned long *' from 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
>
> This issue has been extensively discussed between various interested
> parties but it is still unclear what if any the best solution is in the
> compiler and there are concerns about just disabling the warning with a
> pragma in the header due to the potential for masking other serious
> issues.  Details of the discussion can be followed here:
>
>    https://github.com/ClangBuiltLinux/linux/issues/283
>
> In order to avoid the issue and facilitate further clang work and
> testing for the time being just disable the use of xor-neon.c if we are
> building with clang.  Obviously this is not actually resolving the
> problem and is not something that should be with us for the long term
> but since it only affects clang and enables people working on that to
> work directly with upstream it seems like a useful tradeoff.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>
> It would also be possible to achieve the same effect by using either a
> Makefile change or a pragma to disable the warning for this specific
> file, I can send a patch for those approaches if that's OK and
> preferable.  Disabling the acceleration entirely seemed safer and less
> likely to be forgotten to me.
>
> We've got some KernelCI support for clang in the middle of getting
> deployed:
>
>    https://staging.kernelci.org/job/next-clang/branch/master/
>
> so being able to build and run upstream kernels directly would be
> enormously helpful.
>
>  arch/arm64/include/asm/xor.h | 2 +-
>  arch/arm64/lib/Makefile      | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
> index 856386ad076c..971b8336d2d2 100644
> --- a/arch/arm64/include/asm/xor.h
> +++ b/arch/arm64/include/asm/xor.h
> @@ -14,7 +14,7 @@
>  #include <asm/hwcap.h>
>  #include <asm/neon.h>
>
> -#ifdef CONFIG_KERNEL_MODE_NEON
> +#if defined(CONFIG_KERNEL_MODE_NEON) && !defined(CONFIG_CC_IS_CLANG)
>
>  extern struct xor_block_template const xor_block_inner_neon;
>
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 5540a1638baf..b2a5b8d56354 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -6,10 +6,12 @@ lib-y         := clear_user.o delay.o copy_from_user.o                \
>                    strchr.o strrchr.o tishift.o
>
>  ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
> +ifneq ($(CONFIG_CC_IS_CLANG), y)
>  obj-$(CONFIG_XOR_BLOCKS)       += xor-neon.o
>  CFLAGS_REMOVE_xor-neon.o       += -mgeneral-regs-only
>  CFLAGS_xor-neon.o              += -ffreestanding
>  endif
> +endif
>
>  # Tell the compiler to treat all general purpose registers (with the
>  # exception of the IP registers, which are already handled by the caller
> --
> 2.20.1
>

Can we just add the pragma to neon-instrinsics.h and be done with it?
As long as Clang is not the dominant compiler, I don't buy the 'hiding
real bugs' argument, especially since neon-intrinsics.h should never
be included transitively, so it only affects source files that
actually call NEON intrinsics.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
