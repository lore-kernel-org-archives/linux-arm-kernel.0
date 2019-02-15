Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A3AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:50:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECED321929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M/Ft+Wxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECED321929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qxsnxDvC0hlSqGxxS1yeyGmqkODwk7QNarri0SBXBYY=; b=M/Ft+WxsRBy1KI
	6ht8BF3HUqgTF3KLTHwNlaPIvKLQriLATNIeB84aTY++gDM+HD9NxXqo2IBHwllerckwYdMF7EIQ4
	EH/XIHmWSR80z2T7MKTgzewiSlFNtm4Y4hHAUnfvfHXO4ulqQyC3ehkAhtKmjBAY4Npchu7D/yFc9
	G47nfZlXeeI/h0Sbe2wxPYZAi615eMoAUGUafr2ciJThd9NnWWzn5QUNmRcZ101WmtLa4AfP/yDCV
	MOe//y5TSqer9CcO31KweXTxa4jcqny5X71Z7J5F1WBRuEl9kpmJhKpI+F/9wrIXrQTfL2wXPuZL5
	IUM2xd4F/8dqfIgksZjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guiZG-0006W7-Cm; Fri, 15 Feb 2019 18:50:34 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guiZC-0006Vc-Pk
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:50:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF6EA78;
 Fri, 15 Feb 2019 10:50:30 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D99813F589;
 Fri, 15 Feb 2019 10:50:28 -0800 (PST)
Date: Fri, 15 Feb 2019 18:50:26 +0000
From: Will Deacon <will.deacon@arm.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
Message-ID: <20190215185026.GE15084@fuggles.cambridge.arm.com>
References: <20190215013959.21320-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215013959.21320-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_105030_841892_7136811B 
X-CRM114-Status: GOOD (  16.66  )
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 06:39:59PM -0700, Nathan Chancellor wrote:
> After commit cc9f8349cb33 ("arm64: crypto: add NEON accelerated XOR
> implementation"), Clang builds for arm64 started failing with the
> following error message.
> 
> arch/arm64/lib/xor-neon.c:58:28: error: incompatible pointer types
> assigning to 'const unsigned long *' from 'uint64_t *' (aka 'unsigned
> long long *') [-Werror,-Wincompatible-pointer-types]
>                 v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 + 6));
>                                          ^~~~~~~~
> /usr/lib/llvm-9/lib/clang/9.0.0/include/arm_neon.h:7538:47: note:
> expanded from macro 'vld1q_u64'
>   __ret = (uint64x2_t) __builtin_neon_vld1q_v(__p0, 51); \
>                                               ^~~~
> 
> There has been quite a bit of debate and triage that has gone into
> figuring out what the proper fix is, viewable at the link below, which
> is still ongoing. Ard suggested disabling this warning with Clang with a
> pragma so no neon code will have this type of error. While this is not
> at all an ideal solution, this build error is the only thing preventing
> KernelCI from having successful arm64 defconfig and allmodconfig builds
> on linux-next. Getting continuous integration running is more important
> so new warnings/errors or boot failures can be caught and fixed quickly.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/283
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm64/include/asm/neon-intrinsics.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
> index 2ba6c6b9541f..71abfc7612b2 100644
> --- a/arch/arm64/include/asm/neon-intrinsics.h
> +++ b/arch/arm64/include/asm/neon-intrinsics.h
> @@ -36,4 +36,8 @@
>  #include <arm_neon.h>
>  #endif
>  
> +#ifdef CONFIG_CC_IS_CLANG
> +#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
> +#endif

I'd like Ard's ack on this one, please.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
