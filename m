Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D376FC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:39:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A4921726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="furLfrs+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBcS1T4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A4921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O05EsCX91Kdz9YS+Hkl+Q2/aBZU+zJ8ACxP+TnoefDw=; b=furLfrs+1Ccs/a
	NJ/l0+5VZJCLzW2SHxXJQ0lwXhEK+ITY1cUzZ/YH7dzI+1C3F96mLzFJNohgm89RgcuUdPvvA8BgG
	odBln7bF6z+naJYuvv7aS3FLLzWeeNeZthhG4YHUiLjBjxgqjjC2lzBDGuoyiqU2xCbCGfTKMMD8V
	gEiGO/Wz+nJZHu5wegVBf51+ci9WoQtodG9nGIvHVkwS5OtnvngT5NuNT0H63V7tAuQFmGxioxukC
	O7OSaq45YLxW5CS12Q4M6krlFSUKhkBTcX1wP89xLKP3c205GicbrhdPjF9i5S7dOeP+NHJUptL+z
	Mnibwx0EF5P8O0qP1LQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmF05-0002mx-Oz; Wed, 23 Jan 2019 09:39:13 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmF02-0002mY-Np
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 09:39:12 +0000
Received: by mail-it1-x142.google.com with SMTP id d11so965921itf.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iy86gF7Uj2nsZP0wrYXVRzKAVM/GOwOcj6pG0TWI63g=;
 b=cBcS1T4PSfdjt6kfJSNAX8zEChfr3wzKFbGi+E6YjlLi5IIgQcO1RCohTmsCcdRtvG
 dESs5LalhXFFMZxpOwxTvrQEd3UZckrW6uu/5C2CbjOkDjywmM2Q08OA9QMX137tVzhR
 lkzpr6B5sd4sjl7HV6+OfBxFS8ebCxJbr1Qo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iy86gF7Uj2nsZP0wrYXVRzKAVM/GOwOcj6pG0TWI63g=;
 b=NNlSW2apA7h/Yko2T+eRHRHJ6GzKDpTa4elwikh8Gw8O0UFxhiwJb8vdnDBvkfEv68
 X73EwZdVAkImkkwMqlhOr+8HuJZOY7CYeU3oitDpLPmdlrAe3QY/uhJYz3FbIA7uoBt2
 sOXAphoZFIda4J6YbHpyB0XmVo9hDbBkZeiRakOSXjaTeArpnnaz6ItxfKxafeV0VIaV
 u7aVy1/jxMySZGcMhjfYf0V4xIytzGKaN53oIemK87tSMgqiDkXrZ/oAYBZItdha3jaL
 bNjJUkHI0vlUyxah3sd07rfvmwsIrwrXdG1Nh2uyJnVffktz/yNP5KHpicDz8gjqRBHr
 iYRw==
X-Gm-Message-State: AJcUukcuq1IA2LvJ9NRg259Oas2FQs+yBCmxv71bvO9rBvbEESvkFRNt
 0Lfnr9pEEPONeaVbUgBHydVp+yvq03+Mw3vi+n/k9tl4v7uJ1A==
X-Google-Smtp-Source: ALg8bN42fNwUmWVFod8Gxbr0vIsMSyDwLhaJljnjf9qDCMcKc9tcEKsoe+CbAqwsEwdEoFzKpBZl0ACjorRA8erDzyE=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr1202188itk.71.1548236349236; 
 Wed, 23 Jan 2019 01:39:09 -0800 (PST)
MIME-Version: 1.0
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-10-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8qL1BWE-xXA+X0wrORBpv+tVKKOnN0Dv+FGQFZGWUB-w@mail.gmail.com>
 <6d9cd0ea-d487-bfb0-0461-1e0fcd24a7e1@arm.com>
In-Reply-To: <6d9cd0ea-d487-bfb0-0461-1e0fcd24a7e1@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 23 Jan 2019 10:38:58 +0100
Message-ID: <CAKv+Gu8nviYL5BKwhVZH3BY12mWBQ8zam7vijNDGQdtheLuDZw@mail.gmail.com>
Subject: Re: [PATCH v9 09/26] arm64: Unmask PMR before going idle
To: Julien Thierry <julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_013910_773536_E7B5E816 
X-CRM114-Status: GOOD (  25.10  )
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

On Wed, 23 Jan 2019 at 09:56, Julien Thierry <julien.thierry@arm.com> wrote:
>
>
>
> On 22/01/2019 20:18, Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 16:36, Julien Thierry <julien.thierry@arm.com> wrote:
> >>
> >> CPU does not received signals for interrupts with a priority masked by
> >> ICC_PMR_EL1. This means the CPU might not come back from a WFI
> >> instruction.
> >>
> >> Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.
> >>
> >> Since the logic of cpu_do_idle is becoming a bit more complex than just
> >> two instructions, lets turn it from ASM to C.
> >>
> >> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> >> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> ---
> >>  arch/arm64/kernel/process.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >>  arch/arm64/mm/proc.S        | 11 -----------
> >>  2 files changed, 45 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> >> index 6d410fc..f05b63f 100644
> >> --- a/arch/arm64/kernel/process.c
> >> +++ b/arch/arm64/kernel/process.c
> >> @@ -51,6 +51,7 @@
> >>  #include <linux/thread_info.h>
> >>
> >>  #include <asm/alternative.h>
> >> +#include <asm/arch_gicv3.h>
> >>  #include <asm/compat.h>
> >>  #include <asm/cacheflush.h>
> >>  #include <asm/exec.h>
> >> @@ -74,6 +75,50 @@
> >>
> >>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
> >>
> >> +static inline void __cpu_do_idle(void)
> >> +{
> >> +       dsb(sy);
> >> +       wfi();
> >> +}
> >> +
> >> +static inline void __cpu_do_idle_irqprio(void)
> >
> > Can we drop the 'inline's from all the function definitions in .c
> > files? (not just in this patch)
> > We tend to leave that to the compiler.
> >
>
> Sure, I guess cpu_do_idle() isn't a performance critical path anyway.
>

And even if they were, it would not make a difference, since the
compiler will inline this anyway.

For arm64, inline expands to

#define inline inline __attribute__((__always_inline__)) __gnu_inline \
        __maybe_unused notrace

so please just avoid it where you can.


> Unless anyone argues against it, I'll drop these inlines for the next
> version.
>
> Thanks,
>
> Julien
>
> >> +{
> >> +       unsigned long pmr;
> >> +       unsigned long daif_bits;
> >> +
> >> +       daif_bits = read_sysreg(daif);
> >> +       write_sysreg(daif_bits | PSR_I_BIT, daif);
> >> +
> >> +       /*
> >> +        * Unmask PMR before going idle to make sure interrupts can
> >> +        * be raised.
> >> +        */
> >> +       pmr = gic_read_pmr();
> >> +       gic_write_pmr(GIC_PRIO_IRQON);
> >> +
> >> +       __cpu_do_idle();
> >> +
> >> +       gic_write_pmr(pmr);
> >> +       write_sysreg(daif_bits, daif);
> >> +}
> >> +
> >> +/*
> >> + *     cpu_do_idle()
> >> + *
> >> + *     Idle the processor (wait for interrupt).
> >> + *
> >> + *     If the CPU supports priority masking we must do additional work to
> >> + *     ensure that interrupts are not masked at the PMR (because the core will
> >> + *     not wake up if we block the wake up signal in the interrupt controller).
> >> + */
> >> +void cpu_do_idle(void)
> >> +{
> >> +       if (system_uses_irq_prio_masking())
> >> +               __cpu_do_idle_irqprio();
> >> +       else
> >> +               __cpu_do_idle();
> >> +}
> >> +
> >>  /*
> >>   * This is our default idle handler.
> >>   */
> >> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> >> index 73886a5..3ea4f3b 100644
> >> --- a/arch/arm64/mm/proc.S
> >> +++ b/arch/arm64/mm/proc.S
> >> @@ -55,17 +55,6 @@
> >>
> >>  #define MAIR(attr, mt) ((attr) << ((mt) * 8))
> >>
> >> -/*
> >> - *     cpu_do_idle()
> >> - *
> >> - *     Idle the processor (wait for interrupt).
> >> - */
> >> -ENTRY(cpu_do_idle)
> >> -       dsb     sy                              // WFI may enter a low-power mode
> >> -       wfi
> >> -       ret
> >> -ENDPROC(cpu_do_idle)
> >> -
> >>  #ifdef CONFIG_CPU_PM
> >>  /**
> >>   * cpu_do_suspend - save CPU registers context
> >> --
> >> 1.9.1
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
