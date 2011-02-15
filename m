From: sbkim73@samsung.com (Sangbeom Kim)
Date: Tue, 15 Feb 2011 10:52:09 +0900
Subject: [PATCH 0/11] ARM: EXYNOS4: Change ARCH name,
	ARCH_EXYNOS4 from ARCH_S5PV310
In-Reply-To: <AANLkTimOqg4XGMv+Gsarpa9U56MB3hxewhZxznHpx4-u@mail.gmail.com>
References: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTim49dpC_r4BcK7tqo9wmu8W=qMDZE5szDUja6Wo@mail.gmail.com>
	<002d01cbcca2$5900e430$0b02ac90$@com>
	<AANLkTimOqg4XGMv+Gsarpa9U56MB3hxewhZxznHpx4-u@mail.gmail.com>
Message-ID: <003301cbccb2$f8511720$e8f34560$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday, February 14, 2011 8:16 PM, Kyungmin Park wrote:
> > Hi,
> > I answer your questions in detail.
> >
> >> On Monday, February 14, 2011 8:16 PM, Kyungmin Park wrote:
> >>
> >> Hi,
> >>
> >> Wow, fast move, but need to more explanation.
> >> what's the exact meaning of exynos4210?
> >> Exynos4 is prefix and remaining are variants?
> >
> > Exynos4210 means below.
> >
> > 1st digit means ARM core version. In this case, 4 means Cortex A9.
> > (If we release cortex A15, it will be Exynos5xxx)
> > 2nd digit means number of core. ?2 mean dual core.
> > 3rd digit means application category(LSI internal category).
> > 4th digit means design rule (generation or shrink version)
> 
> Nice, I want these rules.
> >
> >> Now you changed all s5pv310 to exynos4. if new exynos4xxx chip are
> >> comes then how to handle this one?
> >> e.g., exynos4220 or later.
> >> it's also conflict with mach-exynos4. do you handle all exynos4 series
> >> at this mach directory?
> >> historically there's no rules of the base RAM address at least samsung
> >> chips.
> >
> > Yes, we will handle all exynos4 series at mach-exynos4 directory.
> > In the past, there is no rule.
> > But now, we are making consistent rules with AP design team.
> > So, new version of exynos4 series will have same base RAM address.
> 
> Okay, no problem with base ram address,
> 
> Another one is how do you handle the GPIOs?
> Now it's also changed as EXYNOS4_GPXX, I think it's difficult to use
> the same banks as exynos4210 has if new chips are introduced.
> maybe IRQ also has similar issue.

We already had reviewed your concern before.
S5P6450 and S5P6440 is basically same processor. 
But GPIO, IRQ and some peripheral is little different.
We can handle that by checking each processors chipid.

Please check the below patch.
http://www.spinics.net/lists/linux-samsung-soc/msg03530.html

Thanks and regards,
Sangbeom Kim
> 
> Now these patches assumes all exynos4 has same gpios, irqs and so on.
> 
> How do you think about it?
> 
> Thank you,
> Kyungmin Park
> >
> > Thanks and regards,
> > Sangbeom Kim
> >
> >>
> >> Thank you,
> >> Kyungmin Park
> >>
> >> On Mon, Feb 14, 2011 at 5:22 PM, Kukjin Kim <kgene.kim@samsung.com>
> wrote:
> >> > This patch set changes to ARCH_EXYNOS4 from ARCH_S5PV310 for
> supporting
> >> Samsung's
> >> > new brand name EXYNOS. Samsung officially announced about the brand
> name
> >> of EXYNOS
> >> > at MWC 2011 and The EXYNOS4 integrates a ARM Cortex A9 microporcessor
> >> with several
> >> > other peripherals to support features such as multimedai, storage,
> >> graphics and gaming.
> >> > Especially, the EXYNOS4210 CPU which is one of EXYNOS4 SoC series can
> be
> >> used in
> >> > products such as Mobile devices.
> >> >
> >> > This patch set consists of the following patches.
> >> >
> >> > [PATCH 01/11] ARM: EXYNOS4: Add EXYNOS4 CPU initialization support
> >> > [PATCH 02/11] ARM: EXYNOS4: Update Clock part
> >> > [PATCH 03/11] ARM: EXYNOS4: Update IRQ part
> >> > [PATCH 04/11] ARM: EXYNOS4: Update Timer part
> >> > [PATCH 05/11] ARM: EXYNOS4: Update device support
> >> > [PATCH 06/11] ARM: EXYNOS4: Moved board support files
> >> > [PATCH 07/11] ARM: EXYNOS4: Update Kconfig and Makefile for the new
> >> ARCH_EXYNOS4
> >> > [PATCH 08/11] ARM: exynos4_defconfig: Add defconfig for EXYNOS4
> >> > [PATCH 09/11] mtd: OneNAND: Change dependency of ARCH_EXYNOS4
> >> > [PATCH 10/11] ASoC: Change dependency of ARCH_EXYNOS4
> >> > [PATCH 11/11] tty: Change dependency of ARCH_EXYNOS4
> >> >
> >> > _______________________________________________
> >> > linux-arm-kernel mailing list
> >> > linux-arm-kernel at lists.infradead.org
> >> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-
> samsung-
> >> soc" in
> >> the body of a message to majordomo at vger.kernel.org
> >> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> soc" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
