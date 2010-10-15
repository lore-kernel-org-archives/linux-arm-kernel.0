From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 15 Oct 2010 10:58:20 +0900
Subject: [PATCH 2/3] ARM: S5PV310: Add the definition for external
	interrupt
In-Reply-To: <1286450698-12029-3-git-send-email-jongsun.han@samsung.com>
References: <1286450698-12029-1-git-send-email-jongsun.han@samsung.com>
	<1286450698-12029-3-git-send-email-jongsun.han@samsung.com>
Message-ID: <001a01cb6c0c$735b4600$5a11d200$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jongsun Han wrote:
> 
> This patch add the definition for both IRQs and GPIO registers for
external
> interrupt.
> 
> Signed-off-by: Jongsun Han <jongsun.han@samsung.com>
> ---
>  arch/arm/mach-s5pv310/include/mach/irqs.h      |   26 +++++++++++++++-
>  arch/arm/mach-s5pv310/include/mach/regs-gpio.h |   37
> ++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-gpio.h
> 
> diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-
> s5pv310/include/mach/irqs.h
> index e81332f..9faea58 100644
> --- a/arch/arm/mach-s5pv310/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
> @@ -78,10 +78,32 @@
> 
>  #define IRQ_ONENAND_AUDI	COMBINER_IRQ(34, 0)
> 
> +#define IRQ_EINT4		COMBINER_IRQ(37, 0)
> +#define IRQ_EINT5		COMBINER_IRQ(37, 1)
> +#define IRQ_EINT6		COMBINER_IRQ(37, 2)
> +#define IRQ_EINT7		COMBINER_IRQ(37, 3)
> +#define IRQ_EINT8		COMBINER_IRQ(38, 0)
> +
> +#define IRQ_EINT9		COMBINER_IRQ(38, 1)
> +#define IRQ_EINT10		COMBINER_IRQ(38, 2)
> +#define IRQ_EINT11		COMBINER_IRQ(38, 3)
> +#define IRQ_EINT12		COMBINER_IRQ(38, 4)
> +#define IRQ_EINT13		COMBINER_IRQ(38, 5)
> +#define IRQ_EINT14		COMBINER_IRQ(38, 6)
> +#define IRQ_EINT15		COMBINER_IRQ(38, 7)
> +
> +#define IRQ_EINT16_31		COMBINER_IRQ(39, 0)
> +
> +#define IRQ_EINT_BASE		(IRQ_EINT16_31 + 1)
> +
>  /* Set the default NR_IRQS */
> +#define NR_IRQS			(IRQ_EINT_BASE + 32)
> +
> +#define EINT_NUMBER(x)		((x) + IRQ_EINT_BASE)
> 
> -#define NR_IRQS
> 	COMBINER_IRQ(MAX_COMBINER_NR, 0)
> +#define S5P_EINT_BASE1		EINT_NUMBER(0)
> +#define S5P_EINT_BASE2		EINT_NUMBER(16)
> 
No need to add EINT_NUMBER(x) macro?

#define S5P_EINT_BASE1	(IRQ_EINT_BASE + 0)
#define S5P_EINT_BASE1	(IRQ_EINT_BASE + 16)

> -#define MAX_COMBINER_NR		39
> +#define MAX_COMBINER_NR		40
> 
>  #endif /* __ASM_ARCH_IRQS_H */

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
