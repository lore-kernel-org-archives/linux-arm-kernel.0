From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 14 Jun 2010 10:48:17 +0530
Subject: [PATCH 2/5] SPEAR3xx: Rename register/irq defines to remove naming
	conflicts
In-Reply-To: <1275717955-14545-3-git-send-email-ryan@bluewatersys.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<1275717955-14545-3-git-send-email-ryan@bluewatersys.com>
Message-ID: <4C15BB99.4060108@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/5/2010 11:35 AM, Ryan Mallon wrote:
> Prefix register and irq defintions to remove naming conflicts between
> the three SPEAr3xx platforms.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
>  arch/arm/mach-spear3xx/include/mach/generic.h  |    4 +-
>  arch/arm/mach-spear3xx/include/mach/irqs.h     |  195 ++++++++++++------------
>  arch/arm/mach-spear3xx/include/mach/spear300.h |   26 ++--
>  arch/arm/mach-spear3xx/include/mach/spear310.h |   44 +++---
>  arch/arm/mach-spear3xx/include/mach/spear320.h |   50 +++---
>  arch/arm/mach-spear3xx/spear300.c              |   65 ++++----
>  arch/arm/mach-spear3xx/spear310.c              |   92 ++++++------
>  arch/arm/mach-spear3xx/spear320.c              |  134 ++++++++--------
>  arch/arm/mach-spear3xx/spear3xx.c              |    4 +-
>  9 files changed, 308 insertions(+), 306 deletions(-)
> 
> diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
> index af7e02c..48dfb9c 100644
> --- a/arch/arm/mach-spear3xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear3xx/include/mach/generic.h
> @@ -27,8 +27,8 @@
>   * Following GPT channels will be used as clock source and clockevent
>   */
>  #define SPEAR_GPT0_BASE		SPEAR3XX_ML1_TMR_BASE
> -#define SPEAR_GPT0_CHAN0_IRQ	IRQ_CPU_GPT1_1
> -#define SPEAR_GPT0_CHAN1_IRQ	IRQ_CPU_GPT1_2
> +#define SPEAR_GPT0_CHAN0_IRQ	SPEAR3XX_IRQ_CPU_GPT1_1
> +#define SPEAR_GPT0_CHAN1_IRQ	SPEAR3XX_IRQ_CPU_GPT1_2
>  
>  /* Add spear3xx family device structure declarations here */
>  extern struct amba_device gpio_device;
> diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
> index 7f940b8..668bf72 100644
> --- a/arch/arm/mach-spear3xx/include/mach/irqs.h
> +++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
> @@ -15,138 +15,141 @@
>  #define __MACH_IRQS_H
>  
>  /* SPEAr3xx IRQ definitions */
> -#define IRQ_HW_ACCEL_MOD_0			0
> -#define IRQ_INTRCOMM_RAS_ARM			1
> -#define IRQ_CPU_GPT1_1				2
> -#define IRQ_CPU_GPT1_2				3
> -#define IRQ_BASIC_GPT1_1			4
> -#define IRQ_BASIC_GPT1_2			5
> -#define IRQ_BASIC_GPT2_1			6
> -#define IRQ_BASIC_GPT2_2			7
> -#define IRQ_BASIC_DMA				8
> -#define IRQ_BASIC_SMI				9
> -#define IRQ_BASIC_RTC				10
> -#define IRQ_BASIC_GPIO				11
> -#define IRQ_BASIC_WDT				12
> -#define IRQ_DDR_CONTROLLER			13
> -#define IRQ_SYS_ERROR				14
> -#define IRQ_WAKEUP_RCV				15
> -#define IRQ_JPEG				16
> -#define IRQ_IRDA				17
> -#define IRQ_ADC					18
> -#define IRQ_UART				19
> -#define IRQ_SSP					20
> -#define IRQ_I2C					21
> -#define IRQ_MAC_1				22
> -#define IRQ_MAC_2				23
> -#define IRQ_USB_DEV				24
> -#define IRQ_USB_H_OHCI_0			25
> -#define IRQ_USB_H_EHCI_0			26
> -#define IRQ_USB_H_EHCI_1			IRQ_USB_H_EHCI_0
> -#define IRQ_USB_H_OHCI_1			27
> -#define IRQ_GEN_RAS_1				28
> -#define IRQ_GEN_RAS_2				29
> -#define IRQ_GEN_RAS_3				30
> -#define IRQ_HW_ACCEL_MOD_1			31
> -#define IRQ_VIC_END				32
> -
> -#define VIRQ_START				IRQ_VIC_END
> +#define SPEAR3XX_IRQ_HW_ACCEL_MOD_0		0
> +#define SPEAR3XX_IRQ_INTRCOMM_RAS_ARM		1
> +#define SPEAR3XX_IRQ_CPU_GPT1_1			2
> +#define SPEAR3XX_IRQ_CPU_GPT1_2			3
> +#define SPEAR3XX_IRQ_BASIC_GPT1_1		4
> +#define SPEAR3XX_IRQ_BASIC_GPT1_2		5
> +#define SPEAR3XX_IRQ_BASIC_GPT2_1		6
> +#define SPEAR3XX_IRQ_BASIC_GPT2_2		7
> +#define SPEAR3XX_IRQ_BASIC_DMA			8
> +#define SPEAR3XX_IRQ_BASIC_SMI			9
> +#define SPEAR3XX_IRQ_BASIC_RTC			10
> +#define SPEAR3XX_IRQ_BASIC_GPIO			11
> +#define SPEAR3XX_IRQ_BASIC_WDT			12
> +#define SPEAR3XX_IRQ_DDR_CONTROLLER		13
> +#define SPEAR3XX_IRQ_SYS_ERROR			14
> +#define SPEAR3XX_IRQ_WAKEUP_RCV			15
> +#define SPEAR3XX_IRQ_JPEG			16
> +#define SPEAR3XX_IRQ_IRDA			17
> +#define SPEAR3XX_IRQ_ADC			18
> +#define SPEAR3XX_IRQ_UART			19
> +#define SPEAR3XX_IRQ_SSP			20
> +#define SPEAR3XX_IRQ_I2C			21
> +#define SPEAR3XX_IRQ_MAC_1			22
> +#define SPEAR3XX_IRQ_MAC_2			23
> +#define SPEAR3XX_IRQ_USB_DEV			24
> +#define SPEAR3XX_IRQ_USB_H_OHCI_0		25
> +#define SPEAR3XX_IRQ_USB_H_EHCI_0		26
> +#define SPEAR3XX_IRQ_USB_H_EHCI_1		SPEAR3XX_IRQ_USB_H_EHCI_0
> +#define SPEAR3XX_IRQ_USB_H_OHCI_1		27
> +#define SPEAR3XX_IRQ_GEN_RAS_1			28
> +#define SPEAR3XX_IRQ_GEN_RAS_2			29
> +#define SPEAR3XX_IRQ_GEN_RAS_3			30
> +#define SPEAR3XX_IRQ_HW_ACCEL_MOD_1		31
> +#define SPEAR3XX_IRQ_VIC_END			32
> +

We have kept it, the way it was intentionally. I don't understand why any
conflicts will occur.
