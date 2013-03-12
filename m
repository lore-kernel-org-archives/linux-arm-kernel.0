From: karl.beldan@gmail.com (Karl Beldan)
Date: Tue, 12 Mar 2013 15:35:10 +0100
Subject: [PATCH 2/4] ARM: imx: support DEBUG_LL uart port selection for
 all i.MX SoCs
In-Reply-To: <1355319945-3199-3-git-send-email-shawn.guo@linaro.org>
References: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
 <1355319945-3199-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130312143510.GA26044@magnum.frso.rivierawaves.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 09:45:43PM +0800, Shawn Guo wrote:
> Extend imx6q DEBUG_LL uart port selection support to cover all i.MX
> SoCs.  The 'range' of the Kconfig option gets dropped, as users
> looking at the option must know the uart number on his board.  The
> bottom line is that the build system will report an error if an
> invalid port number is picked for given SoC.
> 
> The header arch/arm/include/debug/imx-uart.h is created to accommodate
> all the uart base addresses.  And the header will also be used for
> other low-level debug facility later.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/Kconfig.debug            |   13 ++++--
>  arch/arm/include/debug/imx-uart.h |   88 +++++++++++++++++++++++++++++++++++++
>  arch/arm/include/debug/imx.S      |   29 +-----------
>  3 files changed, 98 insertions(+), 32 deletions(-)
>  create mode 100644 arch/arm/include/debug/imx-uart.h
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index ae2ee04..05f83c8 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -457,11 +457,16 @@ choice
>  
>  endchoice
>  
> -config DEBUG_IMX6Q_UART_PORT
> -	int "i.MX6Q Debug UART Port (1-5)" if DEBUG_IMX6Q_UART
> -	range 1 5
> +config DEBUG_IMX_UART_PORT
> +	int "i.MX Debug UART Port Selection" if DEBUG_IMX1_UART || \
> +						DEBUG_IMX25_UART || \
> +						DEBUG_IMX21_IMX27_UART || \
> +						DEBUG_IMX31_UART || \
> +						DEBUG_IMX35_UART || \
> +						DEBUG_IMX51_UART || \
> +						DEBUG_IMX50_IMX53_UART || \
> +						DEBUG_IMX6Q_UART
>  	default 1
> -	depends on SOC_IMX6Q

After removing any dependency everybody gets a DEBUG_IMX_UART_PORT in
their config now.
 
Karl
