From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 4 May 2010 04:49:00 +0100
Subject: [PATCH 2/2] ARM: S5PV210: Add GPIO register definitions
In-Reply-To: <1272940652-31254-1-git-send-email-kgene.kim@samsung.com>
References: <1272940652-31254-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100504034859.GU6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 11:37:32AM +0900, Kukjin Kim wrote:
> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> This patch adds GPIO register definitions for group interrupt.
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv210/include/mach/regs-gpio.h |  338 ++++++++++++++++++++----
>  1 files changed, 282 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> index c78bbeb..4968b06 100644
> --- a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> +++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> @@ -17,61 +17,287 @@
>  
>  /* Base addresses for each of the banks */
>  
> -#define S5PV210_GPA0_BASE	(S5P_VA_GPIO + 0x000)
> -#define S5PV210_GPA1_BASE	(S5P_VA_GPIO + 0x020)
> -#define S5PV210_GPB_BASE	(S5P_VA_GPIO + 0x040)
> -#define S5PV210_GPC0_BASE	(S5P_VA_GPIO + 0x060)
> -#define S5PV210_GPC1_BASE	(S5P_VA_GPIO + 0x080)
> -#define S5PV210_GPD0_BASE	(S5P_VA_GPIO + 0x0A0)
> -#define S5PV210_GPD1_BASE	(S5P_VA_GPIO + 0x0C0)
> -#define S5PV210_GPE0_BASE	(S5P_VA_GPIO + 0x0E0)
> -#define S5PV210_GPE1_BASE	(S5P_VA_GPIO + 0x100)
> -#define S5PV210_GPF0_BASE	(S5P_VA_GPIO + 0x120)
> -#define S5PV210_GPF1_BASE	(S5P_VA_GPIO + 0x140)
> -#define S5PV210_GPF2_BASE	(S5P_VA_GPIO + 0x160)
> -#define S5PV210_GPF3_BASE	(S5P_VA_GPIO + 0x180)
> -#define S5PV210_GPG0_BASE	(S5P_VA_GPIO + 0x1A0)
> -#define S5PV210_GPG1_BASE	(S5P_VA_GPIO + 0x1C0)
> -#define S5PV210_GPG2_BASE	(S5P_VA_GPIO + 0x1E0)
> -#define S5PV210_GPG3_BASE	(S5P_VA_GPIO + 0x200)
> -#define S5PV210_GPH0_BASE	(S5P_VA_GPIO + 0xC00)
> -#define S5PV210_GPH1_BASE	(S5P_VA_GPIO + 0xC20)
> -#define S5PV210_GPH2_BASE	(S5P_VA_GPIO + 0xC40)
> -#define S5PV210_GPH3_BASE	(S5P_VA_GPIO + 0xC60)
> -#define S5PV210_GPI_BASE	(S5P_VA_GPIO + 0x220)
> -#define S5PV210_GPJ0_BASE	(S5P_VA_GPIO + 0x240)
> -#define S5PV210_GPJ1_BASE	(S5P_VA_GPIO + 0x260)
> -#define S5PV210_GPJ2_BASE	(S5P_VA_GPIO + 0x280)
> -#define S5PV210_GPJ3_BASE	(S5P_VA_GPIO + 0x2A0)
> -#define S5PV210_GPJ4_BASE	(S5P_VA_GPIO + 0x2C0)
> -#define S5PV210_MP01_BASE	(S5P_VA_GPIO + 0x2E0)
> -#define S5PV210_MP02_BASE	(S5P_VA_GPIO + 0x300)
> -#define S5PV210_MP03_BASE	(S5P_VA_GPIO + 0x320)
> -#define S5PV210_MP04_BASE	(S5P_VA_GPIO + 0x340)
> -#define S5PV210_MP05_BASE	(S5P_VA_GPIO + 0x360)
> -#define S5PV210_MP06_BASE	(S5P_VA_GPIO + 0x380)
> -#define S5PV210_MP07_BASE	(S5P_VA_GPIO + 0x3A0)
> -#define S5PV210_MP10_BASE	(S5P_VA_GPIO + 0x3C0)
> -#define S5PV210_MP11_BASE	(S5P_VA_GPIO + 0x3E0)
> -#define S5PV210_MP12_BASE	(S5P_VA_GPIO + 0x400)
> -#define S5PV210_MP13_BASE	(S5P_VA_GPIO + 0x420)
> -#define S5PV210_MP14_BASE	(S5P_VA_GPIO + 0x440)
> -#define S5PV210_MP15_BASE	(S5P_VA_GPIO + 0x460)
> -#define S5PV210_MP16_BASE	(S5P_VA_GPIO + 0x480)
> -#define S5PV210_MP17_BASE	(S5P_VA_GPIO + 0x4A0)
> -#define S5PV210_MP18_BASE	(S5P_VA_GPIO + 0x4C0)
> -#define S5PV210_MP20_BASE	(S5P_VA_GPIO + 0x4E0)
> -#define S5PV210_MP21_BASE	(S5P_VA_GPIO + 0x500)
> -#define S5PV210_MP22_BASE	(S5P_VA_GPIO + 0x520)
> -#define S5PV210_MP23_BASE	(S5P_VA_GPIO + 0x540)
> -#define S5PV210_MP24_BASE	(S5P_VA_GPIO + 0x560)
> -#define S5PV210_MP25_BASE	(S5P_VA_GPIO + 0x580)
> -#define S5PV210_MP26_BASE	(S5P_VA_GPIO + 0x5A0)
> -#define S5PV210_MP27_BASE	(S5P_VA_GPIO + 0x5C0)
> -#define S5PV210_MP28_BASE	(S5P_VA_GPIO + 0x5E0)
> -#define S5PV210_ETC0_BASE	(S5P_VA_GPIO + 0x600)
> -#define S5PV210_ETC1_BASE	(S5P_VA_GPIO + 0x620)
> -#define S5PV210_ETC2_BASE	(S5P_VA_GPIO + 0x640)
> -#define S5PV210_ETC4_BASE	(S5P_VA_GPIO + 0x660)
> +#define S5PV210_GPA0_BASE		(S5P_VA_GPIO + 0x000)
> +#define S5PV210_GPA1_BASE		(S5P_VA_GPIO + 0x020)
> +#define S5PV210_GPB_BASE 		(S5P_VA_GPIO + 0x040)
> +#define S5PV210_GPC0_BASE		(S5P_VA_GPIO + 0x060)
> +#define S5PV210_GPC1_BASE		(S5P_VA_GPIO + 0x080)
> +#define S5PV210_GPD0_BASE		(S5P_VA_GPIO + 0x0A0)
> +#define S5PV210_GPD1_BASE		(S5P_VA_GPIO + 0x0C0)
> +#define S5PV210_GPE0_BASE		(S5P_VA_GPIO + 0x0E0)
> +#define S5PV210_GPE1_BASE		(S5P_VA_GPIO + 0x100)
> +#define S5PV210_GPF0_BASE		(S5P_VA_GPIO + 0x120)
> +#define S5PV210_GPF1_BASE		(S5P_VA_GPIO + 0x140)
> +#define S5PV210_GPF2_BASE		(S5P_VA_GPIO + 0x160)
> +#define S5PV210_GPF3_BASE		(S5P_VA_GPIO + 0x180)
> +#define S5PV210_GPG0_BASE		(S5P_VA_GPIO + 0x1A0)
> +#define S5PV210_GPG1_BASE		(S5P_VA_GPIO + 0x1C0)
> +#define S5PV210_GPG2_BASE		(S5P_VA_GPIO + 0x1E0)
> +#define S5PV210_GPG3_BASE		(S5P_VA_GPIO + 0x200)
> +#define S5PV210_GPH0_BASE		(S5P_VA_GPIO + 0xC00)
> +#define S5PV210_GPH1_BASE		(S5P_VA_GPIO + 0xC20)
> +#define S5PV210_GPH2_BASE		(S5P_VA_GPIO + 0xC40)
> +#define S5PV210_GPH3_BASE		(S5P_VA_GPIO + 0xC60)
> +#define S5PV210_GPI_BASE 		(S5P_VA_GPIO + 0x220)
> +#define S5PV210_GPJ0_BASE		(S5P_VA_GPIO + 0x240)
> +#define S5PV210_GPJ1_BASE		(S5P_VA_GPIO + 0x260)
> +#define S5PV210_GPJ2_BASE		(S5P_VA_GPIO + 0x280)
> +#define S5PV210_GPJ3_BASE		(S5P_VA_GPIO + 0x2A0)
> +#define S5PV210_GPJ4_BASE		(S5P_VA_GPIO + 0x2C0)
> +#define S5PV210_MP01_BASE		(S5P_VA_GPIO + 0x2E0)
> +#define S5PV210_MP02_BASE		(S5P_VA_GPIO + 0x300)
> +#define S5PV210_MP03_BASE		(S5P_VA_GPIO + 0x320)
> +#define S5PV210_MP04_BASE		(S5P_VA_GPIO + 0x340)
> +#define S5PV210_MP05_BASE		(S5P_VA_GPIO + 0x360)
> +#define S5PV210_MP06_BASE		(S5P_VA_GPIO + 0x380)
> +#define S5PV210_MP07_BASE		(S5P_VA_GPIO + 0x3A0)
> +#define S5PV210_MP10_BASE		(S5P_VA_GPIO + 0x3C0)
> +#define S5PV210_MP11_BASE		(S5P_VA_GPIO + 0x3E0)
> +#define S5PV210_MP12_BASE		(S5P_VA_GPIO + 0x400)
> +#define S5PV210_MP13_BASE		(S5P_VA_GPIO + 0x420)
> +#define S5PV210_MP14_BASE		(S5P_VA_GPIO + 0x440)
> +#define S5PV210_MP15_BASE		(S5P_VA_GPIO + 0x460)
> +#define S5PV210_MP16_BASE		(S5P_VA_GPIO + 0x480)
> +#define S5PV210_MP17_BASE		(S5P_VA_GPIO + 0x4A0)
> +#define S5PV210_MP18_BASE		(S5P_VA_GPIO + 0x4C0)
> +#define S5PV210_MP20_BASE		(S5P_VA_GPIO + 0x4E0)
> +#define S5PV210_MP21_BASE		(S5P_VA_GPIO + 0x500)
> +#define S5PV210_MP22_BASE		(S5P_VA_GPIO + 0x520)
> +#define S5PV210_MP23_BASE		(S5P_VA_GPIO + 0x540)
> +#define S5PV210_MP24_BASE		(S5P_VA_GPIO + 0x560)
> +#define S5PV210_MP25_BASE		(S5P_VA_GPIO + 0x580)
> +#define S5PV210_MP26_BASE		(S5P_VA_GPIO + 0x5A0)
> +#define S5PV210_MP27_BASE		(S5P_VA_GPIO + 0x5C0)
> +#define S5PV210_MP28_BASE		(S5P_VA_GPIO + 0x5E0)
> +#define S5PV210_ETC0_BASE		(S5P_VA_GPIO + 0x600)
> +#define S5PV210_ETC1_BASE		(S5P_VA_GPIO + 0x620)
> +#define S5PV210_ETC2_BASE		(S5P_VA_GPIO + 0x640)
> +#define S5PV210_ETC4_BASE		(S5P_VA_GPIO + 0x660)
> +
> +#define S5PV210_GPA0_INT_CON		(S5P_VA_GPIO + 0x700)
> +#define S5PV210_GPA0_INTFLTCON0		(S5P_VA_GPIO + 0x800)
> +#define S5PV210_GPA0_INTFLTCON1		(S5P_VA_GPIO + 0x804)
> +#define S5PV210_GPA0_INT_MASK		(S5P_VA_GPIO + 0x900)
> +#define S5PV210_GPA0_INT_PEND		(S5P_VA_GPIO + 0xA00)
> +#define S5PV210_GPA0_INT_FIXPRI		(S5P_VA_GPIO + 0xB14)

These look like they could be defined as offsets from a base and
each bank given its own index. It would avoid a whole pile of defines
and make it easier to review, and possibly easier to code...

> +#define S5PV210_EINT32PEND		(S5P_VA_GPIO + 0xF48)
> +#define S5PV210_EINT33PEND		(S5P_VA_GPIO + 0xF4C)
> +
> +#define S5P_EINT_PEND(x)		(S5PV210_EINT30PEND + ((x) * 0x4))

why bother with individial S5PV210_EINT32PEND defines, when youve got
this.

> +#define eint_offset(irq)		((irq) < IRQ_EINT16_31 ? ((irq)-IRQ_EINT0)	\
> +						: (irq-S5P_IRQ_EINT_BASE))
> +

this might be better as an inline function.

> +#define eint_irq_to_bit(irq)		(1 << (eint_offset(irq) & 0x7))
> +
> +#define eint_conf_reg(irq)		((eint_offset(irq)) >> 3)
> +#define eint_filt_reg(irq)		((eint_offset(irq)) >> 2)
> +#define eint_mask_reg(irq)		((eint_offset(irq)) >> 3)
> +#define eint_pend_reg(irq)		((eint_offset(irq)) >> 3)
> +
> +#define S5P_EINT30CON			S5PV210_EINT30CON
> +#define S5P_EINT31CON			S5PV210_EINT31CON
> +#define S5P_EINT32CON			S5PV210_EINT32CON
> +#define S5P_EINT33CON			S5PV210_EINT33CON
> +#define S5P_EINT30FLTCON0		S5PV210_EINT30FLTCON0
> +#define S5P_EINT30FLTCON1		S5PV210_EINT30FLTCON1
> +#define S5P_EINT31FLTCON0		S5PV210_EINT31FLTCON0
> +#define S5P_EINT31FLTCON1		S5PV210_EINT31FLTCON1
> +#define S5P_EINT32FLTCON0		S5PV210_EINT32FLTCON0
> +#define S5P_EINT32FLTCON1		S5PV210_EINT32FLTCON1
> +#define S5P_EINT33FLTCON0		S5PV210_EINT33FLTCON0
> +#define S5P_EINT33FLTCON1		S5PV210_EINT33FLTCON1
> +#define S5P_EINT30MASK			S5PV210_EINT30MASK
> +#define S5P_EINT31MASK			S5PV210_EINT31MASK
> +#define S5P_EINT32MASK			S5PV210_EINT32MASK
> +#define S5P_EINT33MASK			S5PV210_EINT33MASK

if you'd avoided creating these in the first place you'd have less
work re-defining them here,..

> +/* values for S5P_EXTINT0 */
> +#define S5P_EXTINT_LOWLEV		(0x00)
> +#define S5P_EXTINT_HILEV		(0x01)
> +#define S5P_EXTINT_FALLEDGE		(0x02)
> +#define S5P_EXTINT_RISEEDGE		(0x03)
> +#define S5P_EXTINT_BOTHEDGE		(0x04)

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
