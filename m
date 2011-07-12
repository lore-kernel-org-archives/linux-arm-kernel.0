From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Jul 2011 09:44:06 +0200
Subject: [PATCH 1/1] ARM: i.MX50/53: debug-macro: fix UART_PADDR
In-Reply-To: <1310438444-4237-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1310438444-4237-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20110712074405.GF7751@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 07:40:44PM -0700, Troy Kisky wrote:
> The i.MX51 UART_PADDR value does not work for MX50/53.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
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
I'm not sure it's worth the effort to do this. Still you should at least
note it in the change log or better move it to a separate patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
