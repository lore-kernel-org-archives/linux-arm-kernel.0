From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 15 Sep 2014 18:34:34 +0200
Subject: [PATCH v8 6/9] arm: netx: Migrate DEBUG_LL macros to shared
 directory
In-Reply-To: <1408459715-10151-7-git-send-email-daniel.thompson@linaro.org>
References: <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>
 <1408459715-10151-1-git-send-email-daniel.thompson@linaro.org>
 <1408459715-10151-7-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1410798874.31130.57.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-08-19 at 15:48 +0100, Daniel Thompson wrote:
> As part of the migration we introduce DEBUG_UART_PHYS/DEBUG_UART_VIRT
> which default to UART1 but allow a user to configure UART2 or UART3.
> We also introduce symbolic names for the registers and flags.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Acked-by: Arnd Bergmann <arnd.bergmann@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org

This patch landed in today's linux-next, as 880fa9b6fd73 ("ARM: 8144/1:
netx: Migrate DEBUG_LL macros to shared directory").

> [...]
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -447,6 +447,14 @@ choice
>  		  Say Y here if you want kernel low-level debugging support
>  		  on Vybrid based platforms.
>  
> +	config DEBUG_NETX_UART
> +		bool "Kernel low-level debugging messages via NetX UART"
> +		depends on ARCH_NETX
> +		select DEBUG_UART_NETX

There's no Kconfig symbol DEBUG_UART_NETX in next-20140915. So in
linux-next this is currently a nop. Is this symbol queued somewhere?

> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on Hilscher NetX based platforms.
> +
>  	config DEBUG_NOMADIK_UART
>  		bool "Kernel low-level debugging messages via NOMADIK UART"
>  		depends on ARCH_NOMADIK


Paul Bolle
