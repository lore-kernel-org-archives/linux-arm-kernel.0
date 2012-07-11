From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 11 Jul 2012 15:23:11 +0100
Subject: [PATCH 9/9] ARM: vexpress: Config option for early printk console
In-Reply-To: <1342013791-19516-10-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-10-git-send-email-pawel.moll@arm.com>
Message-ID: <4FFD8C4F.40502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On 11/07/12 14:36, Pawel Moll wrote:
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 01a1341..12eee87 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -310,6 +310,32 @@ choice
>  		  The uncompressor code port configuration is now handled
>  		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
>  
> +	config DEBUG_VEXPRESS_UART0_DETECT
> +		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
> +		depends on ARCH_VEXPRESS
> +		help
> +		  This option enables simple heuristic which tries to determine
> +		  motherboard's memory map variant (original or RS1) and then
> +		  choose relevant UART0 base address.
> +
> +		  Note that this will only work with standard A-class core tiles,
> +		  and may fail with non-standard SMM or custom software model.
> +

Is it possible to make this depend on something like CPU_CP15_MMU,
instead of ARCH_VEXPRESS? Seems like a reasonable way to ensure that
this isn't used on some of the core tiles that don't have the required
cp15 registers to read the Configuration Base Address Register.

Jonny
