From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Jun 2010 15:05:13 +0900
Subject: [PATCH 1/6] S5PV210 Add IRQ/EINT register information for the CPU.
In-Reply-To: <1276504755-24741-2-git-send-email-MyungJoo.Ham@samsung.com>
References: <1276504755-24741-1-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-2-git-send-email-MyungJoo.Ham@samsung.com>
Message-ID: <009601cb0c50$c04e3920$40eaab60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> Signed-off-by: MyungJoo Ham <MyungJoo.Ham@samsung.com>

Is above your e-mail right? myungjoo.ham or MyungJoo.Ham?

> ---
>  arch/arm/mach-s5pv210/include/mach/irqs.h     |    9 +++++++++
>  arch/arm/mach-s5pv210/include/mach/regs-irq.h |    6 ++++++
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-
> s5pv210/include/mach/irqs.h
> index 9689537..6c5f491 100644
> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> @@ -118,9 +118,18 @@
>  #define IRQ_MDNIE3		S5P_IRQ_VIC3(8)
>  #define IRQ_VIC_END		S5P_IRQ_VIC3(31)
> 
> +/* External interrupt */
> +

No need above comment.
Because xxx_EINT_xxx means External Interrupt blah...

>  #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
>  #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
> 
> +#define S5P_EINT(x)             (S5P_EINT_BASE2 + ((x) - 16))
> +#define IRQ_EINT_BIT(x) ((x) < IRQ_EINT16_31 ? (x) - S5P_VIC0_BASE : (x) -
> S5P_EINT(0))
> +

IRQ_EINT_BIT is same as EINT_OFFSET.
In your patch set, could not find where you has used IRQ_EINT_BIT!!

> +/* GPIO interrupt */
> +#define S5P_IRQ_GPIO_BASE       (IRQ_EINT(31) + 1)
> +#define S5P_IRQ_GPIO(x)         (S5P_IRQ_GPIO_BASE + (x))
> +
>  /* Set the default NR_IRQS */
>  #define NR_IRQS			(IRQ_EINT(31) + 1)
> 
> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-irq.h b/arch/arm/mach-
> s5pv210/include/mach/regs-irq.h
> index 5c3b104..139604f 100644
> --- a/arch/arm/mach-s5pv210/include/mach/regs-irq.h
> +++ b/arch/arm/mach-s5pv210/include/mach/regs-irq.h
> @@ -16,4 +16,10 @@
>  #include <asm/hardware/vic.h>
>  #include <mach/map.h>
> 
> +/* interrupt controller */
> +#define S5PV210_VIC0REG(x)                      ((x) + VA_VIC0)
> +#define S5PV210_VIC1REG(x)                      ((x) + VA_VIC1)
> +#define S5PV210_VIC2REG(x)                      ((x) + VA_VIC2)
> +#define S5PV210_VIC3REG(x)                      ((x) + VA_VIC3)
> +

Also not used anywhere in your patch set...

>  #endif /* __ASM_ARCH_REGS_IRQ_H */
> --
> 1.6.3.3
> 
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
