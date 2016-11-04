From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 04 Nov 2016 08:36:09 +0100
Subject: [PATCH 5/6] ARM: add low level debug uart for rk1108
In-Reply-To: <1478176941-12188-1-git-send-email-andy.yan@rock-chips.com>
References: <1478175975-11779-1-git-send-email-andy.yan@rock-chips.com>
 <1478176941-12188-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <12034481.WHiLii4Pov@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. November 2016, 20:42:21 CET schrieb Andy Yan:
> RK1108 UARTs are Synopsis DesignWare 8250 compatible.
> Only with different register addresses.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  arch/arm/Kconfig.debug | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index d83f7c3..408540f 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -776,6 +776,30 @@ choice
>  		  their output to the standard serial port on the RealView
>  		  PB1176 platform.
> 
> +	config DEBUG_RK1108_UART0
> +		bool "Kernel low-level debugging messages via Rockchip RK1108 UART0"
> +		depends on ARCH_ROCKCHIP
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +                  on Rockchip RK1108 based platforms.
> +
> +	config DEBUG_RK1108_UART1
> +		bool "Kernel low-level debugging messages via Rockchip RK1108 UART1"
> +		depends on ARCH_ROCKCHIP
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on Rockchip RK1108 based platforms.
> +
> +	config DEBUG_RK1108_UART2
> +		bool "Kernel low-level debugging messages via Rockchip RK1108 UART2"
> +		depends on ARCH_ROCKCHIP
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on Rockchip RK1108 based platforms.
> +

are you sure, you need all 3 of them?

I.e. most Rockchip SoCs so far had one uart somewhat designated as debug uart. 
Most likely due to it not having rts/cts and being used in reference 
schematics, but no one ever used another uart than uart2 on previous socs. So 
ideally we could check and only add uarts we actually need for now. More can 
be added later anyway once boards try to use them.


Heiko
