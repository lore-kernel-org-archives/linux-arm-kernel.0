From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 30 May 2018 15:38:09 +0300
Subject: [PATCH] ARM: debug: Add Iproc UART3 debug addresses
In-Reply-To: <20180530122922.1041-1-peron.clem@gmail.com>
References: <20180530122922.1041-1-peron.clem@gmail.com>
Message-ID: <20180530123809.khyzehg62ct6jzws@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cl?ment,

On Wed, May 30, 2018 at 02:29:22PM +0200, Cl?ment P?ron wrote:
> From: Cl?ment Peron <clement.peron@devialet.com>
> 
> Broadcom Iproc SoCs typically use the UART3 for
> debug/console, provide a known good location for that.
> 
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> ---
>  arch/arm/Kconfig.debug | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 199ebc1c4538..fa6fa1dae94d 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -207,6 +207,14 @@ choice
>  		depends on ARCH_BCM_HR2
>  		select DEBUG_UART_8250
>  
> +	config DEBUG_BCM_IPROC_UART3
> +		bool "Kernel low-level debugging on BCM IPROC UART3"
> +		depends on ARCH_BCM_CYGNUS
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to the third serial port on these devices.
> +
>  	config DEBUG_BCM_KONA_UART
>  		bool "Kernel low-level debugging messages via BCM KONA UART"
>  		depends on ARCH_BCM_MOBILE
> @@ -1564,6 +1572,7 @@ config DEBUG_UART_PHYS
>  	default 0x20068000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
>  	default 0x20201000 if DEBUG_BCM2835
>  	default 0x3f201000 if DEBUG_BCM2836
> +	default 0x18023000 if DEBUG_BCM_IPROC_UART3

Entries are sorted by the address value. Except that DEBUG_BCM_KONA_UART 
should be listed above DEBUG_BCM2836.

>  	default 0x3e000000 if DEBUG_BCM_KONA_UART
>  	default 0x4000e400 if DEBUG_LL_UART_EFM32
>  	default 0x40028000 if DEBUG_AT91_SAMV7_USART1
> @@ -1730,6 +1739,7 @@ config DEBUG_UART_VIRT
>  	default 0xfe018000 if DEBUG_MMP_UART3
>  	default 0xfe100000 if DEBUG_IMX23_UART || DEBUG_IMX28_UART
>  	default 0xfe230000 if DEBUG_PICOXCELL_UART
> +	default 0xf1023000 if DEBUG_BCM_IPROC_UART3

Same here.

>  	default 0xfe300000 if DEBUG_BCM_KONA_UART
>  	default 0xfe800000 if ARCH_IOP32X
>  	default 0xfeb00000 if DEBUG_HI3620_UART || DEBUG_HIX5HD2_UART
> @@ -1791,7 +1801,7 @@ config DEBUG_UART_8250_WORD
>  		DEBUG_KEYSTONE_UART0 || DEBUG_KEYSTONE_UART1 || \
>  		DEBUG_ALPINE_UART0 || \
>  		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
> -		DEBUG_DAVINCI_DA8XX_UART2 || \
> +		DEBUG_DAVINCI_DA8XX_UART2 || DEBUG_BCM_IPROC_UART3 || \
>  		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
