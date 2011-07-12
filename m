From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 12 Jul 2011 15:34:43 +0200
Subject: [PATCH 1/1] ARM: i.MX50/53: debug-macro: fix UART_PADDR
In-Reply-To: <1310438444-4237-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1310438444-4237-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20110712133443.GR6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 07:40:44PM -0700, Troy Kisky wrote:
> The i.MX51 UART_PADDR value does not work for MX50/53.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Your first patch looked better...

Sascha

> ---
>  arch/arm/plat-mxc/include/mach/debug-macro.S |   42 +++++++++++++++++++++-----
>  1 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
> index 8e8d175..6b696cd 100644
> --- a/arch/arm/plat-mxc/include/mach/debug-macro.S
> +++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
> @@ -17,32 +17,58 @@
>  #endif
>  
>  #ifdef CONFIG_ARCH_MX25
> -#ifdef UART_PADDR
> +#ifndef UART_PADDR
> +#define UART_PADDR	MX25_UART1_BASE_ADDR
> +#endif
> +#if UART_PADDR != MX25_UART1_BASE_ADDR
>  #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
>  #endif
> -#define UART_PADDR	MX25_UART1_BASE_ADDR
>  #endif
>  
>  #ifdef CONFIG_ARCH_MX2
> -#ifdef UART_PADDR
> +#ifndef UART_PADDR
> +#define UART_PADDR	MX2x_UART1_BASE_ADDR
> +#endif
> +#if UART_PADDR != MX2x_UART1_BASE_ADDR
>  #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
>  #endif
> -#define UART_PADDR	MX2x_UART1_BASE_ADDR
>  #endif
>  
>  #ifdef CONFIG_ARCH_MX3
> -#ifdef UART_PADDR
> +#ifndef UART_PADDR
> +#define UART_PADDR	MX3x_UART1_BASE_ADDR
> +#endif
> +#if UART_PADDR != MX3x_UART1_BASE_ADDR
>  #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
>  #endif
> -#define UART_PADDR	MX3x_UART1_BASE_ADDR
>  #endif
>  
> -#ifdef CONFIG_ARCH_MX5
> -#ifdef UART_PADDR
> +#ifdef CONFIG_ARCH_MX50
> +#ifndef UART_PADDR
> +#define UART_PADDR	MX50_UART1_BASE_ADDR
> +#endif
> +#if UART_PADDR != MX50_UART1_BASE_ADDR
>  #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
>  #endif
> +#endif
> +
> +#ifdef CONFIG_ARCH_MX51
> +#ifndef UART_PADDR
>  #define UART_PADDR	MX51_UART1_BASE_ADDR
>  #endif
> +#if UART_PADDR != MX51_UART1_BASE_ADDR
> +#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
> +#endif
> +#endif
> +
> +#ifdef CONFIG_ARCH_MX53
> +#ifndef UART_PADDR
> +#define UART_PADDR	MX53_UART1_BASE_ADDR
> +#endif
> +#if UART_PADDR != MX53_UART1_BASE_ADDR
> +#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
> +#endif
> +#endif
>  
>  #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
>  
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
