From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Sep 2014 17:09:17 +0100
Subject: [PATCH] arm: Remove redundant config value DEBUG_UART_NETX
In-Reply-To: <1410818986-13273-1-git-send-email-daniel.thompson@linaro.org>
References: <1410818986-13273-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140916160917.GK12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 11:09:46PM +0100, Daniel Thompson wrote:
> Commit 880fa9b6fd73 ("ARM: 8144/1: netx: Migrate DEBUG_LL macros to
> shared directory") spuriously introduces an unused config variable,
> DEBUG_UART_NETX. Let's remove it.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

I think arm-soc are handing these changes now...

> ---
>  arch/arm/Kconfig.debug | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 537dd04..b6ec25a 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -450,7 +450,6 @@ choice
>  	config DEBUG_NETX_UART
>  		bool "Kernel low-level debugging messages via NetX UART"
>  		depends on ARCH_NETX
> -		select DEBUG_UART_NETX
>  		help
>  		  Say Y here if you want kernel low-level debugging support
>  		  on Hilscher NetX based platforms.
> -- 
> 1.9.3
> 

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
