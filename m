Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6E9C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:35:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F222084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RyPZ156L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA4ENPUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F222084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bg2eiLUYNHU9jzqrVnuE2g+UcpyfepYCio7YEHQuTvA=; b=RyPZ156L9UMVow
	eQNbFdtfSPxCnrVt4mbEV5l/6h4j4pvUyzqm4RiTlvzNlO1VLo1ZahIb67GnHRsuAsus5DZoo/D0M
	OO7Y4fkQevgDCNk+EHpRRgi5Ds52ApNcnPrCKvZ5xNd9FTgIZ6XFHQ8cdtXv0e4tQHWuE5HW3zcqL
	ifTyEQksJ5kBijrPBNDZHNqJd/YKtCmVUM0MNGAmhO27HuLH/+ux9Zx8st6Og1bCBA/0SMHEBfFbm
	QLoKJ4BdrenpU0HQiYkrWSOmNOyjnob26ZS5/+yWyvv91CKVzgPQ/N/WSnhA+feMl2OacaHMlHgLU
	fjzVdXZwEF+w/TEN1F5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grxtJ-0006Rx-MI; Fri, 08 Feb 2019 04:35:53 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grxtF-0006Re-Uu
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 04:35:51 +0000
Received: by mail-ed1-x542.google.com with SMTP id t6so1675775edw.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 20:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jUTj8B+GtmhHYkTK2S0PrlLERdhvTf9uHTNZBWObPfs=;
 b=GA4ENPUYXXfI6dTgK7yb5NQbiBIxPYGT+YuxWGwl57lRxHD2Df47j0sshvJzH1W/WX
 LOWrxR+SwA+QLA/BVwPdOfQ8SRPrGeo6p9uRz1Wktg0ODV1/hqOIb+gsNnCHUcQFKotY
 U2an3HDhbB6imFEzRUGUWZSehYjv3FIU72ahBdW9jBRKlOwq8Wui7eMlhiHZPTQx3GZH
 /QO+t+UELXbJbbItEdJ1lzmJ49RuHO4LQIwKyvsN569rc1OSKSBzuHE32EamMSOvtBro
 Q0/Hj1oAH4ims5aw3PC1lA8EK13Dynh4zC5ZHzuGLZXmVaAa04RVwxaqYqTVY+Ighj5T
 Csvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jUTj8B+GtmhHYkTK2S0PrlLERdhvTf9uHTNZBWObPfs=;
 b=dxIDi7FLvoTcQMhrw0ji/HbSZLbPW7KqJ+nEcqDKcVSYP4SfBd3Ysa6X8aKk9S8Quh
 kS4/89a1akxNX1F/Mg+RWc5Xy2cYQQ+MoebLIpmsUZmQ2PppucsS8LYRE4cgRjMB8hOi
 0xKhu4KtKFjve9Q3XNoHzbuRVZ3tFq1V+ZOqP6FN7sYI5xA4Gy1OuE4341tNlX49guHN
 TyUZ4JfFEzMy4G8Bnb5IE3gUe/YhpKStyr4xMnxanPTeVcRlhhKEm/xJPS/BmeEqVfiS
 gyBf452GELzg1G2kZ8410H8eC20V4qqxoGRwReoWksmVBvrqccKgy2laWnCfRmbgk7cN
 dlqA==
X-Gm-Message-State: AHQUAuZBWoQaPzhFV58axybs1lsIirQv3LjCsfx5/Q1Cd9vAL9+S7uQJ
 1RnBI6apmGmQxAAMsCVvYFs=
X-Google-Smtp-Source: AHgI3IZuyZAbsoC4WXl+nDIJS142UwHnH+D5NgN25xfaqDSzz9LJTvPxGQEMqVtIQ1n5eodOvisK9w==
X-Received: by 2002:a17:906:7f95:: with SMTP id
 f21mr900294ejr.131.1549600546809; 
 Thu, 07 Feb 2019 20:35:46 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
 by smtp.gmail.com with ESMTPSA id v5sm244274eju.37.2019.02.07.20.35.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 07 Feb 2019 20:35:46 -0800 (PST)
Date: Thu, 7 Feb 2019 21:35:43 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v10 12/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190208043543.GA5040@archlinux-ryzen>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
 <1548946743-38979-13-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548946743-38979-13-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_203550_019627_52C23283 
X-CRM114-Status: GOOD (  23.45  )
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
Cc: mark.rutland@arm.com, Nick Desaulniers <ndesaulniers@google.com>,
 daniel.thompson@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 02:58:50PM +0000, Julien Thierry wrote:
> Instead disabling interrupts by setting the PSR.I bit, use a priority
> higher than the one used for interrupts to mask them via PMR.
> 
> When using PMR to disable interrupts, the value of PMR will be used
> instead of PSR.[DAIF] for the irqflags.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/arm64/include/asm/efi.h      |  11 +++++
>  arch/arm64/include/asm/irqflags.h | 100 +++++++++++++++++++++++++++-----------
>  2 files changed, 83 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 7ed3208..c9e9a69 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -44,6 +44,17 @@
>  
>  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>  
> +/*
> + * Even when Linux uses IRQ priorities for IRQ disabling, EFI does not.
> + * And EFI shouldn't really play around with priority masking as it is not aware
> + * which priorities the OS has assigned to its interrupts.
> + */
> +#define arch_efi_save_flags(state_flags)		\
> +	((void)((state_flags) = read_sysreg(daif)))
> +
> +#define arch_efi_restore_flags(state_flags)	write_sysreg(state_flags, daif)
> +
> +
>  /* arch specific definitions used by the stub code */
>  
>  /*
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..d4597b2 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -18,7 +18,9 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <asm/alternative.h>
>  #include <asm/ptrace.h>
> +#include <asm/sysreg.h>
>  
>  /*
>   * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
> @@ -36,33 +38,27 @@
>  /*
>   * CPU interrupt mask handling.
>   */
> -static inline unsigned long arch_local_irq_save(void)
> -{
> -	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_irq_save\n"
> -		"msr	daifset, #2"
> -		: "=r" (flags)
> -		:
> -		: "memory");
> -	return flags;
> -}
> -
>  static inline void arch_local_irq_enable(void)
>  {
> -	asm volatile(
> -		"msr	daifclr, #2		// arch_local_irq_enable"
> -		:
> +	asm volatile(ALTERNATIVE(
> +		"msr	daifclr, #2		// arch_local_irq_enable\n"
> +		"nop",
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +		"dsb	sy",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> +		: "r" (GIC_PRIO_IRQON)
>  		: "memory");
>  }
>  
>  static inline void arch_local_irq_disable(void)
>  {
> -	asm volatile(
> -		"msr	daifset, #2		// arch_local_irq_disable"
> -		:
> +	asm volatile(ALTERNATIVE(
> +		"msr	daifset, #2		// arch_local_irq_disable",
> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> +		: "r" (GIC_PRIO_IRQOFF)
>  		: "memory");
>  }
>  
> @@ -71,12 +67,44 @@ static inline void arch_local_irq_disable(void)
>   */
>  static inline unsigned long arch_local_save_flags(void)
>  {
> +	unsigned long daif_bits;
>  	unsigned long flags;
> -	asm volatile(
> -		"mrs	%0, daif		// arch_local_save_flags"
> -		: "=r" (flags)
> -		:
> +
> +	daif_bits = read_sysreg(daif);
> +
> +	/*
> +	 * The asm is logically equivalent to:
> +	 *
> +	 * if (system_uses_irq_prio_masking())
> +	 *	flags = (daif_bits & PSR_I_BIT) ?
> +	 *			GIC_PRIO_IRQOFF :
> +	 *			read_sysreg_s(SYS_ICC_PMR_EL1);
> +	 * else
> +	 *	flags = daif_bits;
> +	 */
> +	asm volatile(ALTERNATIVE(
> +			"mov	%0, %1\n"
> +			"nop\n"
> +			"nop",
> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1) "\n"
> +			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
> +			"csel	%0, %0, %2, eq",
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (flags), "+r" (daif_bits)
> +		: "r" (GIC_PRIO_IRQOFF)
>  		: "memory");
> +
> +	return flags;
> +}
> +
> +static inline unsigned long arch_local_irq_save(void)
> +{
> +	unsigned long flags;
> +
> +	flags = arch_local_save_flags();
> +
> +	arch_local_irq_disable();
> +
>  	return flags;
>  }
>  
> @@ -85,16 +113,32 @@ static inline unsigned long arch_local_save_flags(void)
>   */
>  static inline void arch_local_irq_restore(unsigned long flags)
>  {
> -	asm volatile(
> -		"msr	daif, %0		// arch_local_irq_restore"
> -	:
> -	: "r" (flags)
> -	: "memory");
> +	asm volatile(ALTERNATIVE(
> +			"msr	daif, %0\n"
> +			"nop",
> +			"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %0\n"
> +			"dsb	sy",
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "+r" (flags)
> +		:
> +		: "memory");
>  }
>  
>  static inline int arch_irqs_disabled_flags(unsigned long flags)
>  {
> -	return flags & PSR_I_BIT;
> +	int res;
> +
> +	asm volatile(ALTERNATIVE(
> +			"and	%w0, %w1, #" __stringify(PSR_I_BIT) "\n"
> +			"nop",
> +			"cmp	%w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
> +			"cset	%w0, ls",
> +			ARM64_HAS_IRQ_PRIO_MASKING)
> +		: "=&r" (res)
> +		: "r" ((int) flags)
> +		: "memory");
> +
> +	return res;
>  }
>  #endif
>  #endif
> -- 
> 1.9.1
> 

Hi Julien,

This patch introduced a slew of Clang warnings:

In file included from arch/arm64/kernel/signal.c:21:
In file included from include/linux/compat.h:10:
In file included from include/linux/time.h:6:
In file included from include/linux/seqlock.h:36:
In file included from include/linux/spinlock.h:54:
In file included from include/linux/irqflags.h:16:
arch/arm64/include/asm/irqflags.h:50:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                : "r" (GIC_PRIO_IRQON)
                       ^
arch/arm64/include/asm/ptrace.h:39:25: note: expanded from macro 'GIC_PRIO_IRQON'
#define GIC_PRIO_IRQON          0xf0
                                ^
arch/arm64/include/asm/irqflags.h:46:44: note: use constraint modifier "w"
                "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
                                                         ^~
                                                         %w0
arch/arm64/include/asm/alternative.h:286:29: note: expanded from macro 'ALTERNATIVE'
        _ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
                                   ^
arch/arm64/include/asm/alternative.h:88:30: note: expanded from macro '_ALTERNATIVE_CFG'
        __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
                                    ^
arch/arm64/include/asm/alternative.h:76:2: note: expanded from macro '__ALTERNATIVE_CFG'
        newinstr "\n"                                                   \
        ^
In file included from arch/arm64/kernel/signal.c:21:
In file included from include/linux/compat.h:10:
In file included from include/linux/time.h:6:
In file included from include/linux/seqlock.h:36:
In file included from include/linux/spinlock.h:54:
In file included from include/linux/irqflags.h:16:
arch/arm64/include/asm/irqflags.h:61:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                : "r" (GIC_PRIO_IRQOFF)
                       ^
arch/arm64/include/asm/ptrace.h:40:26: note: expanded from macro 'GIC_PRIO_IRQOFF'
#define GIC_PRIO_IRQOFF         (GIC_PRIO_IRQON & ~0x80)
                                ^
arch/arm64/include/asm/irqflags.h:58:45: note: use constraint modifier "w"
                "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
                                                          ^
arch/arm64/include/asm/irqflags.h:94:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                : "r" (GIC_PRIO_IRQOFF)
                       ^
arch/arm64/include/asm/ptrace.h:40:26: note: expanded from macro 'GIC_PRIO_IRQOFF'
#define GIC_PRIO_IRQOFF         (GIC_PRIO_IRQON & ~0x80)
                                ^
arch/arm64/include/asm/irqflags.h:91:18: note: use constraint modifier "w"
                        "csel   %0, %0, %2, eq",
                                        ^~
                                        %w2
arch/arm64/include/asm/alternative.h:286:29: note: expanded from macro 'ALTERNATIVE'
        _ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
                                   ^
arch/arm64/include/asm/alternative.h:88:30: note: expanded from macro '_ALTERNATIVE_CFG'
        __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
                                    ^
arch/arm64/include/asm/alternative.h:76:2: note: expanded from macro '__ALTERNATIVE_CFG'
        newinstr "\n"                                                   \
        ^
3 warnings generated.


I am not sure if they should be fixed with Clang's suggestion of a
constraint modifier or a cast like commit 1b57ec8c7527 ("arm64: io:
Ensure value passed to __iormb() is held in a 64-bit register"), hence
this message.

Thanks,
Nathan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
