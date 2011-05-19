From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 19 May 2011 20:54:19 +0400
Subject: [PATCH 7/8] ARM i.MX debug macro: use CONFIG_SOC_* instead of
	CONFIG_ARCH_*
In-Reply-To: <1305823648-2428-8-git-send-email-s.hauer@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<1305823648-2428-8-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4DD54B3B.9030709@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Sascha Hauer wrote:

> CONFIG_ARCH_* are deprecated, so remove one user.

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/debug-macro.S |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)

> diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
> index 8e8d175..75a8933 100644
> --- a/arch/arm/plat-mxc/include/mach/debug-macro.S
> +++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
> @@ -12,32 +12,32 @@
>   */
>  #include <mach/hardware.h>
>  
> -#ifdef CONFIG_ARCH_MX1
> +#ifdef CONFIG_SOC_IMX1
>  #define UART_PADDR	MX1_UART1_BASE_ADDR
>  #endif
>  
> -#ifdef CONFIG_ARCH_MX25
> +#ifdef CONFIG_SOC_IMX25
>  #ifdef UART_PADDR
>  #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
>  #endif
>  #define UART_PADDR	MX25_UART1_BASE_ADDR
>  #endif
>  
> -#ifdef CONFIG_ARCH_MX2
> +#if defined CONFIG_SOC_IMX21 || defined CONFIG_SOC_IMX27

    Hm, does defined work without ()? Didn't know it...

WBR, Sergei
