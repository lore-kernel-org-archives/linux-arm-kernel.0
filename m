Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC18C2F43D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:45:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B21520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ebpsz6lt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcvAN8R9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B21520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=944v9ThNYl7eAuTnG6heAQgcP8t2IjBvmf5SwZFPNGw=; b=Ebpsz6lt4NqouO
	ozQMCCebJWLXL42OQFArnv05szrp7Sqios7a2nNYRYUHj010rpUQmO6dyeNSP9o/Q9y7pCt8+nrNe
	9mURrgfpj+igGL/VORDgh+NVZKYWpakO9vrf7xgFIEcqVV6hYnyofoODk5BrhhygBNqAV8Znwxf0f
	iY7ninIGqGsjLO0s9dqpwsRxUg1w7wFhyEt5wMbSBIeXES9G0kLmB0ZGcqkZSmifN7nDkRxA33Ldo
	DzP9/yDfEv8f4Op+lYmFGiMxRBLDfNZMN13jwrjjyckJwMdOFghJ+En+IN2ls+8FZhzOWLWcGmNEO
	4cbr1Fqh+UAFbNflynIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glblg-0001Ok-9A; Mon, 21 Jan 2019 15:45:44 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glblQ-0001Ab-Qy
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:45:41 +0000
Received: by mail-it1-x143.google.com with SMTP id a6so15751047itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PNev0wZfyiJbw9twBFu1eNBJ+MQBNRFBHLHo5P3/wg0=;
 b=AcvAN8R9pXmhmF2NHjENm5C1IUSukp4VLxp7wXQr5rYwfg2g6yxuuBftzbEYmlcE34
 IPLd74rKiWQL9gC6b1OC3qv4/fBazIxnJqCagMJRKtKbUuqZ5MTMf+gV0EG1CYOkSD2c
 I7cycJqjAxJrcgGhEFCPq7tc37PhaxLwar2WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PNev0wZfyiJbw9twBFu1eNBJ+MQBNRFBHLHo5P3/wg0=;
 b=F2eacbq5xVno9WFHBRoYnp7lX5/qWKwvMyesDERY67E+vQCpcJgxe8VixxU4ZTraZM
 UIfuP/iL7pUfXvndKjSX4gAlzxXhdpqqbvouNGN0SIdE7TgSuJ8Eb4kPsDJoafWk1IGl
 vgirGfsq0+aXWmskVnbcaf5GMfTyb69sTmX/EWarO5R7lfdUHdb4Z9sftqpb2JGZGh9c
 UQZELgcwLV+hNU2vxDatPHTZ84Qs8QneNGY0cJua9P6NZyQb1mFb2z9oUableodJ7WN7
 iItcf2eXj9TpTBC2cMWON4/GQUNIEljHuDVtmkLde6byH3zqhsPvsAgEGsu1CMRwV+qy
 YBEw==
X-Gm-Message-State: AJcUukeFcqYonCcJKGUW6YYZ1twOhnY680nwXV7hTaSDBm7N69yNTxx5
 Nvi02L8ZuBzbWE0/Tr5wlThwrbN5IscuYGn/Z1R6wZajI+U=
X-Google-Smtp-Source: ALg8bN5V7q/JMjKZCK+nCc1rPamgJ+wMgtJeybNndDN35rV75DiidvVxBFSWloy3iTsbMnfWMVxTwsQz1xYmC78zrB8=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr17686402itk.71.1548085527208; 
 Mon, 21 Jan 2019 07:45:27 -0800 (PST)
MIME-Version: 1.0
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
In-Reply-To: <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 16:45:15 +0100
Message-ID: <CAKv+Gu-m2KcbDNsM1AJZHOKrJkE5Ki=xX8qqUvFnDc=87-4OsA@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Julien Thierry <julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074529_209158_67C8F3F4 
X-CRM114-Status: GOOD (  21.22  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 Oleg Nesterov <oleg@redhat.com>, Joel Fernandes <joel@joelfernandes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 at 16:34, Julien Thierry <julien.thierry@arm.com> wrote:
>
> Instead disabling interrupts by setting the PSR.I bit, use a priority
> higher than the one used for interrupts to mask them via PMR.
>
> When using PMR to disable interrupts, the value of PMR will be used
> instead of PSR.[DAIF] for the irqflags.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/arm64/include/asm/efi.h      |   6 +++
>  arch/arm64/include/asm/irqflags.h | 104 ++++++++++++++++++++++++++++----------
>  2 files changed, 82 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 7ed3208..3db6772 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -44,6 +44,12 @@
>
>  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>
> +#define arch_efi_save_flags(state_flags)               \
> +       ((void)((state_flags) = read_sysreg(daif)))
> +
> +#define arch_efi_restore_flags(state_flags)    write_sysreg(state_flags, daif)
> +
> +
>  /* arch specific definitions used by the stub code */
>
>  /*

For the EFI changes

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

although it deserves a comment as to why it is unaffected by
ARM64_HAS_IRQ_PRIO_MASKING


> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..7e82a92 100644
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
> @@ -36,33 +38,31 @@
>  /*
>   * CPU interrupt mask handling.
>   */
> -static inline unsigned long arch_local_irq_save(void)
> -{
> -       unsigned long flags;
> -       asm volatile(
> -               "mrs    %0, daif                // arch_local_irq_save\n"
> -               "msr    daifset, #2"
> -               : "=r" (flags)
> -               :
> -               : "memory");
> -       return flags;
> -}
> -
>  static inline void arch_local_irq_enable(void)
>  {
> -       asm volatile(
> -               "msr    daifclr, #2             // arch_local_irq_enable"
> -               :
> +       unsigned long unmasked = GIC_PRIO_IRQON;
> +
> +       asm volatile(ALTERNATIVE(
> +               "msr    daifclr, #2             // arch_local_irq_enable\n"
> +               "nop",
> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +               "dsb    sy",
> +               ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
> +               : "r" (unmasked)
>                 : "memory");
>  }
>
>  static inline void arch_local_irq_disable(void)
>  {
> -       asm volatile(
> -               "msr    daifset, #2             // arch_local_irq_disable"
> -               :
> +       unsigned long masked = GIC_PRIO_IRQOFF;
> +
> +       asm volatile(ALTERNATIVE(
> +               "msr    daifset, #2             // arch_local_irq_disable",
> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> +               ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
> +               : "r" (masked)
>                 : "memory");
>  }
>
> @@ -71,12 +71,44 @@ static inline void arch_local_irq_disable(void)
>   */
>  static inline unsigned long arch_local_save_flags(void)
>  {
> +       unsigned long daif_bits;
>         unsigned long flags;
> -       asm volatile(
> -               "mrs    %0, daif                // arch_local_save_flags"
> -               : "=r" (flags)
> -               :
> +
> +       daif_bits = read_sysreg(daif);
> +
> +       /*
> +        * The asm is logically equivalent to:
> +        *
> +        * if (system_uses_irq_prio_masking())
> +        *      flags = (daif_bits & PSR_I_BIT) ?
> +        *                      GIC_PRIO_IRQOFF :
> +        *                      read_sysreg_s(SYS_ICC_PMR_EL1);
> +        * else
> +        *      flags = daif_bits;
> +        */
> +       asm volatile(ALTERNATIVE(
> +                       "mov    %0, %1\n"
> +                       "nop\n"
> +                       "nop",
> +                       "mrs_s  %0, " __stringify(SYS_ICC_PMR_EL1) "\n"
> +                       "ands   %1, %1, " __stringify(PSR_I_BIT) "\n"
> +                       "csel   %0, %0, %2, eq",
> +                       ARM64_HAS_IRQ_PRIO_MASKING)
> +               : "=&r" (flags), "+r" (daif_bits)
> +               : "r" (GIC_PRIO_IRQOFF)
>                 : "memory");
> +
> +       return flags;
> +}
> +
> +static inline unsigned long arch_local_irq_save(void)
> +{
> +       unsigned long flags;
> +
> +       flags = arch_local_save_flags();
> +
> +       arch_local_irq_disable();
> +
>         return flags;
>  }
>
> @@ -85,16 +117,32 @@ static inline unsigned long arch_local_save_flags(void)
>   */
>  static inline void arch_local_irq_restore(unsigned long flags)
>  {
> -       asm volatile(
> -               "msr    daif, %0                // arch_local_irq_restore"
> -       :
> -       : "r" (flags)
> -       : "memory");
> +       asm volatile(ALTERNATIVE(
> +                       "msr    daif, %0\n"
> +                       "nop",
> +                       "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0\n"
> +                       "dsb    sy",
> +                       ARM64_HAS_IRQ_PRIO_MASKING)
> +               : "+r" (flags)
> +               :
> +               : "memory");
>  }
>
>  static inline int arch_irqs_disabled_flags(unsigned long flags)
>  {
> -       return flags & PSR_I_BIT;
> +       int res;
> +
> +       asm volatile(ALTERNATIVE(
> +                       "and    %w0, %w1, #" __stringify(PSR_I_BIT) "\n"
> +                       "nop",
> +                       "cmp    %w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
> +                       "cset   %w0, ls",
> +                       ARM64_HAS_IRQ_PRIO_MASKING)
> +               : "=&r" (res)
> +               : "r" ((int) flags)
> +               : "memory");
> +
> +       return res;
>  }
>  #endif
>  #endif
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
