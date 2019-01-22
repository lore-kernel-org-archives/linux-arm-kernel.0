Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED19BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:19:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91D5217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NzPdMrBG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMGS+hSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91D5217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sh51HtweVgTW4C08OxjnpRgjTl5jF71khUGSllDd50k=; b=NzPdMrBG2j06EW
	GpCmK8P7Pbg+EdYPvadxtJxJMQAgy8V45LNBvwVlkzRJdF3lTvcbKOFJMvHayuJmWFThJ8EwgdPcU
	9VG/Fkaw4/hX4EQmOSWURDoKTLp1ODH5qXA34h1cNB4xWYxYlq5/LSyelHMBh0KtrkpqKYtgp25h0
	AdxTQltmUtWVbbW0rP4HJqyTrCgI39vGnQIiodSDhOQZdUIRWWNgwFHy7HxLtL+AvSWjsa5f0OmG4
	4VBuP8OcdlkmjQIExYEgo6MGuGO3knOY7w0QTv28cuiabOHz8cRPXwbKwZ4vr01ZonOE1b8d/m7A+
	qxzAA7JxOpZurLQQ+Akw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm2Vi-0001XR-He; Tue, 22 Jan 2019 20:19:02 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm2Ve-0001X3-Bx
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 20:19:00 +0000
Received: by mail-it1-x141.google.com with SMTP id b5so21991758iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 12:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rJT1F0qIq8Tsw54r6HJtqhgv9rAheiXApZ/xRhlov+g=;
 b=TMGS+hSszdm5dq5n7TUbrF3ZUFew9a3yYBPtEZ+R29vkEOqdAEpSoDXdXJZyysl4vA
 xwgtzm7TmWHimBbbNPZboUppWT3r+Wt4EZLAh0hTyS1kRfInpsC2S0QCgWdoChKQV6sS
 jtVeafZ5wfqo/gsZxX0qpOpTyf4dShH8BvN/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rJT1F0qIq8Tsw54r6HJtqhgv9rAheiXApZ/xRhlov+g=;
 b=Hjh2oSoW0Zlbz3Cc0wJ16XngrLFGzGbcDH0XDGLH0n1+2Na1HvQQspbZZK6TSnIWCo
 i+OSgllVBY+jsqd+wq/rKscIfjM97ENTKEhuCwTxH9a+YSTYPrh3eLBGYNhIkM3TXGWa
 ReArpxZNvqotFnq6JtRWUBKcARP78nfIt9EoIRJ7tgxCjPjOPyFDM3oxNsGgbbnR3JAp
 Bd3x/Q+NoxJ4XGK3iTehN9hGbIG8LqMlPw0NSoZML9GHPdJSWY731PUCfPn4AZ0R4INU
 IQc7ykgZvi4zZdG7qkDkwsgO8CS4sfFaZOhWf43EGO/MdW2TVMIA0jZk6OjU08M9MYQ+
 tePQ==
X-Gm-Message-State: AJcUukdtcoSFAFv7fk8yuJlFBwnC+vlvnfthHuSgdOBYQOfeMGFFgEhx
 ad0DIsnRVVkMncCkc68pDq2o8vdWa7H19cZKe9vWXw==
X-Google-Smtp-Source: ALg8bN7ZSPCBtZpSW/6tE7vNhIk01WeXlaP6ZgI9xknccXjOxCZCY57zq6FnmgE8eukdUenQhcNgztF7HshFVOF2sb8=
X-Received: by 2002:a24:710:: with SMTP id f16mr2660624itf.121.1548188337202; 
 Tue, 22 Jan 2019 12:18:57 -0800 (PST)
MIME-Version: 1.0
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-10-git-send-email-julien.thierry@arm.com>
In-Reply-To: <1548084825-8803-10-git-send-email-julien.thierry@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 22 Jan 2019 21:18:45 +0100
Message-ID: <CAKv+Gu8qL1BWE-xXA+X0wrORBpv+tVKKOnN0Dv+FGQFZGWUB-w@mail.gmail.com>
Subject: Re: [PATCH v9 09/26] arm64: Unmask PMR before going idle
To: Julien Thierry <julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_121858_414056_F43F473D 
X-CRM114-Status: GOOD (  21.94  )
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
 Joel Fernandes <joel@joelfernandes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 at 16:36, Julien Thierry <julien.thierry@arm.com> wrote:
>
> CPU does not received signals for interrupts with a priority masked by
> ICC_PMR_EL1. This means the CPU might not come back from a WFI
> instruction.
>
> Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.
>
> Since the logic of cpu_do_idle is becoming a bit more complex than just
> two instructions, lets turn it from ASM to C.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/process.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/mm/proc.S        | 11 -----------
>  2 files changed, 45 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 6d410fc..f05b63f 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -51,6 +51,7 @@
>  #include <linux/thread_info.h>
>
>  #include <asm/alternative.h>
> +#include <asm/arch_gicv3.h>
>  #include <asm/compat.h>
>  #include <asm/cacheflush.h>
>  #include <asm/exec.h>
> @@ -74,6 +75,50 @@
>
>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>
> +static inline void __cpu_do_idle(void)
> +{
> +       dsb(sy);
> +       wfi();
> +}
> +
> +static inline void __cpu_do_idle_irqprio(void)

Can we drop the 'inline's from all the function definitions in .c
files? (not just in this patch)
We tend to leave that to the compiler.

> +{
> +       unsigned long pmr;
> +       unsigned long daif_bits;
> +
> +       daif_bits = read_sysreg(daif);
> +       write_sysreg(daif_bits | PSR_I_BIT, daif);
> +
> +       /*
> +        * Unmask PMR before going idle to make sure interrupts can
> +        * be raised.
> +        */
> +       pmr = gic_read_pmr();
> +       gic_write_pmr(GIC_PRIO_IRQON);
> +
> +       __cpu_do_idle();
> +
> +       gic_write_pmr(pmr);
> +       write_sysreg(daif_bits, daif);
> +}
> +
> +/*
> + *     cpu_do_idle()
> + *
> + *     Idle the processor (wait for interrupt).
> + *
> + *     If the CPU supports priority masking we must do additional work to
> + *     ensure that interrupts are not masked at the PMR (because the core will
> + *     not wake up if we block the wake up signal in the interrupt controller).
> + */
> +void cpu_do_idle(void)
> +{
> +       if (system_uses_irq_prio_masking())
> +               __cpu_do_idle_irqprio();
> +       else
> +               __cpu_do_idle();
> +}
> +
>  /*
>   * This is our default idle handler.
>   */
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 73886a5..3ea4f3b 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -55,17 +55,6 @@
>
>  #define MAIR(attr, mt) ((attr) << ((mt) * 8))
>
> -/*
> - *     cpu_do_idle()
> - *
> - *     Idle the processor (wait for interrupt).
> - */
> -ENTRY(cpu_do_idle)
> -       dsb     sy                              // WFI may enter a low-power mode
> -       wfi
> -       ret
> -ENDPROC(cpu_do_idle)
> -
>  #ifdef CONFIG_CPU_PM
>  /**
>   * cpu_do_suspend - save CPU registers context
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
