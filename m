From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 29 Apr 2013 12:50:06 -0400
Subject: [PATCH] ARM: dove: fix Dove cpu type from V7 to PJ4
In-Reply-To: <1364051211-24414-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1364051211-24414-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130429165006.GR32497@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 04:06:51PM +0100, Sebastian Hesselbarth wrote:
> The CPU used in Marvell Dove SoCs is a PJ4 Sheeva core. Using
> CONFIG_CPU_PJ4 instead of CONFIG_CPU_V7 will also allow to enable
> iWMMXt extensions on Dove.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sebastian,

It looks as though Russell's fix for IWMMXT made it in.  Please place
this patch in Russell's patch tracker.  If you don't have the original
thread, Andrew Lunn gave this an Acked-by.  Now me as well:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2c3bdce..4fc9bca 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -556,7 +556,7 @@ config ARCH_IXP4XX
>  config ARCH_DOVE
>  	bool "Marvell Dove"
>  	select ARCH_REQUIRE_GPIOLIB
> -	select CPU_V7
> +	select CPU_PJ4
>  	select GENERIC_CLOCKEVENTS
>  	select MIGHT_HAVE_PCI
>  	select PINCTRL
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
