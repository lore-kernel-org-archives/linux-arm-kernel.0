From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 4 May 2010 06:00:59 +0100
Subject: [PATCH 1/2] ARM: S5PV210: Add IRQ definitions for EINT
In-Reply-To: <1272948680-19183-1-git-send-email-kgene.kim@samsung.com>
References: <1272948680-19183-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100504050059.GN2589@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 01:51:20PM +0900, Kukjin Kim wrote:
> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> This patch adds IRQ definitions for external interrupt.
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv210/include/mach/irqs.h |   71 +++++++++++++++++++++++++++--
>  1 files changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
> index 62c5175..e8e43db 100644
> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> @@ -71,7 +71,7 @@
>  #define IRQ_SPI1		S5P_IRQ_VIC1(16)
>  #define IRQ_SPI2		S5P_IRQ_VIC1(17)
>  #define IRQ_IRDA		S5P_IRQ_VIC1(18)
> -#define IRQ_CAN0		S5P_IRQ_VIC1(19)
> +#define IRQ_IIC2		S5P_IRQ_VIC1(19)

fix and addition in same patch. no comment on fix.

>  #define IRQ_CAN1		S5P_IRQ_VIC1(20)
>  #define IRQ_HSIRX		S5P_IRQ_VIC1(21)
>  #define IRQ_HSITX		S5P_IRQ_VIC1(22)
> @@ -139,8 +139,71 @@
>  #define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
>  #define IRQ_EINT(x)		S5P_EINT(x)
>  
> -/* Set the default NR_IRQS */
> +/* Next the external interrupt groups. These are similar to the IRQ_EINT(x)
> + * that they are sourced from the GPIO pins but with a different scheme for
> + * priority and source indication.
> + *
> + * The IRQ_EINT(x) can be thought of as 'group 0' of the available GPIO
> + * interrupts, but for historical reasons they are kept apart from these
> + * next interrupts.
> + *
> + * Use IRQ_EINT_GROUP(group, offset) to get the number for use in the
> + * machine specific support files.
> + */
> +
> +#define IRQ_EINT_GROUP1_NR	(8)	/* A0 */
> +#define IRQ_EINT_GROUP2_NR	(4)	/* A1 */
> +#define IRQ_EINT_GROUP3_NR	(8)     /* B */
> +#define IRQ_EINT_GROUP4_NR	(5)     /* C0 */
> +#define IRQ_EINT_GROUP5_NR	(5)     /* C1 */
> +#define IRQ_EINT_GROUP6_NR	(4)     /* D0 */
> +#define IRQ_EINT_GROUP7_NR	(6)     /* D1 */
> +#define IRQ_EINT_GROUP8_NR	(8)     /* E0 */
> +#define IRQ_EINT_GROUP9_NR	(5)     /* E1 */
> +#define IRQ_EINT_GROUP10_NR	(8)     /* F0 */
> +#define IRQ_EINT_GROUP11_NR	(8)     /* F1 */
> +#define IRQ_EINT_GROUP12_NR	(8)     /* F2 */
> +#define IRQ_EINT_GROUP13_NR	(6)     /* F3 */
> +#define IRQ_EINT_GROUP14_NR	(7)     /* G0 */
> +#define IRQ_EINT_GROUP15_NR	(7)     /* G1 */
> +#define IRQ_EINT_GROUP16_NR	(7)     /* G2 */
> +#define IRQ_EINT_GROUP17_NR	(7)     /* G3 */
> +#define IRQ_EINT_GROUP18_NR	(8)     /* J0 */
> +#define IRQ_EINT_GROUP19_NR	(6)     /* J1 */
> +#define IRQ_EINT_GROUP20_NR	(8)     /* J2 */
> +#define IRQ_EINT_GROUP21_NR	(8)     /* J3 */
> +#define IRQ_EINT_GROUP22_NR	(5)     /* J4 */
> +
> +#define IRQ_EINT_GROUP_BASE	S5P_EINT(31 + 1)
> +
> +#define IRQ_EINT_GROUP1_BASE	(IRQ_EINT_GROUP_BASE)
> +#define IRQ_EINT_GROUP2_BASE	(IRQ_EINT_GROUP1_BASE + IRQ_EINT_GROUP1_NR)
> +#define IRQ_EINT_GROUP3_BASE	(IRQ_EINT_GROUP2_BASE + IRQ_EINT_GROUP2_NR)
> +#define IRQ_EINT_GROUP4_BASE	(IRQ_EINT_GROUP3_BASE + IRQ_EINT_GROUP3_NR)
> +#define IRQ_EINT_GROUP5_BASE	(IRQ_EINT_GROUP4_BASE + IRQ_EINT_GROUP4_NR)
> +#define IRQ_EINT_GROUP6_BASE	(IRQ_EINT_GROUP5_BASE + IRQ_EINT_GROUP5_NR)
> +#define IRQ_EINT_GROUP7_BASE	(IRQ_EINT_GROUP6_BASE + IRQ_EINT_GROUP6_NR)
> +#define IRQ_EINT_GROUP8_BASE	(IRQ_EINT_GROUP7_BASE + IRQ_EINT_GROUP7_NR)
> +#define IRQ_EINT_GROUP9_BASE	(IRQ_EINT_GROUP8_BASE + IRQ_EINT_GROUP8_NR)
> +#define IRQ_EINT_GROUP10_BASE	(IRQ_EINT_GROUP9_BASE + IRQ_EINT_GROUP9_NR)
> +#define IRQ_EINT_GROUP11_BASE	(IRQ_EINT_GROUP10_BASE + IRQ_EINT_GROUP10_NR)
> +#define IRQ_EINT_GROUP12_BASE	(IRQ_EINT_GROUP11_BASE + IRQ_EINT_GROUP11_NR)
> +#define IRQ_EINT_GROUP13_BASE	(IRQ_EINT_GROUP12_BASE + IRQ_EINT_GROUP12_NR)
> +#define IRQ_EINT_GROUP14_BASE	(IRQ_EINT_GROUP13_BASE + IRQ_EINT_GROUP13_NR)
> +#define IRQ_EINT_GROUP15_BASE	(IRQ_EINT_GROUP14_BASE + IRQ_EINT_GROUP14_NR)
> +#define IRQ_EINT_GROUP16_BASE	(IRQ_EINT_GROUP15_BASE + IRQ_EINT_GROUP15_NR)
> +#define IRQ_EINT_GROUP17_BASE	(IRQ_EINT_GROUP16_BASE + IRQ_EINT_GROUP16_NR)
> +#define IRQ_EINT_GROUP18_BASE	(IRQ_EINT_GROUP17_BASE + IRQ_EINT_GROUP17_NR)
> +#define IRQ_EINT_GROUP19_BASE	(IRQ_EINT_GROUP18_BASE + IRQ_EINT_GROUP18_NR)
> +#define IRQ_EINT_GROUP20_BASE	(IRQ_EINT_GROUP19_BASE + IRQ_EINT_GROUP19_NR)
> +#define IRQ_EINT_GROUP21_BASE	(IRQ_EINT_GROUP20_BASE + IRQ_EINT_GROUP20_NR)
> +#define IRQ_EINT_GROUP22_BASE	(IRQ_EINT_GROUP21_BASE + IRQ_EINT_GROUP21_NR)
> +
> +#define IRQ_EINT_GROUP(group, no)	(IRQ_EINT_GROUP##group##_BASE + (no))
> +
> +#define IRQ_EINT_BIT(x)		((x) < IRQ_EINT16_31 ? \
> +				(x - IRQ_EINT0) : (x - S5P_IRQ_EINT_BASE))

No protection around 'x', either fix that or change to an inline function.
  
> -#define NR_IRQS 		(IRQ_EINT(31) + 1)
> +#define NR_IRQS		(IRQ_EINT_GROUP22_BASE + IRQ_EINT_GROUP22_NR + 1)
>  
> -#endif /* ASM_ARCH_IRQS_H */
> +#endif /* __ASM_ARCH_IRQS_H */
> -- 
> 1.6.2.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
