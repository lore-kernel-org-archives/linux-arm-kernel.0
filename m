From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 12 Jan 2015 14:45:14 +0000
Subject: GIC_CPU_MASK_SIMPLE(8)" on big.LITTLE?
In-Reply-To: <CAMuHMdWQQBECdXT1pbChT31y8YdHzcjvTGR1A2HhtdtwpRmdPQ@mail.gmail.com>
References: <CAMuHMdWQQBECdXT1pbChT31y8YdHzcjvTGR1A2HhtdtwpRmdPQ@mail.gmail.com>
Message-ID: <20150112144514.GL823@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 10:37:47AM +0000, Geert Uytterhoeven wrote:
> A while ago, I wondered:
> 
> | It's my understanding GIC_CPU_MASK_SIMPLE should reflect the actual number
> | of CPU cores the interrupt is wired too. Is that correct?
> |
> | [Fixes for incorrect masks on shmobile]
> |
> | Should it be "GIC_CPU_MASK_SIMPLE(8)" on big.LITTLE configurations
> | with four Cortex-A15 cores and four Cortex-A7 cores?
> | Or should the interrupts be delivered to the four Cortex-A15 cores
> | only by default?
> |
> | Note that incorrect masks for GIC PPI interrupts are not limited to
> | shmobile. Presumably the interrupt specifiers got copied around a lot,
> | cfr. the proliferation of "GIC_CPU_MASK_SIMPLE(4)" (and the older
> | hardcoded "0xf0x" variant) in various dtsi files, not always limited to
> | quad-core CPUs.
> 
> In the mean time, arch/arm64/boot/dts/arm/juno.dts got added, which has 2 A57
> cores and 4 A53 cores, and uses GIC_CPU_MASK_SIMPLE(6), so it seems like
> my two RFC patches to use GIC_CPU_MASK_SIMPLE(8) for 4 A15 cores and 4
> A7 cores are actually correct?
> 
> Thanks for your comments!
> 
> References:
>   1. Original RFC series:
>      [PATCH/RFC 0/4] ARM: shmobile: Correct masks for GIC PPI interrupts
>      http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306743.html
>   2. RFC patches:
>        a. [PATCH/RFC 3/4] ARM: shmobile: r8a7790: Correct mask for GIC
> PPI interrupts
>           http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306741.html
>        b. [PATCH/RFC 4/4] ARM: shmobile: r8a73a4: Correct mask for GIC
> PPI interrupts
>           http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306740.html
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

Hi Geert,

Sorry for delay in responding, I'm just coming back online.

Your patches are correct, the mask should reflect the number of CPUs present *and* they way
they are wired in the GIC. AFAIK, HW designers have been sane so far and wired the CPUs
in sequence in the GIC, but I lack inside knowledge of the shmobile design.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
