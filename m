From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 18 Sep 2013 18:45:09 +0200
Subject: [PATCH] arm: mvebu: use the main timer as clock source from DT
In-Reply-To: <1379519624-4267-1-git-send-email-jean.pihet@linaro.org>
References: <1379519624-4267-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <20130918184509.0ad0a5be@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jean Pihet,

On Wed, 18 Sep 2013 17:53:44 +0200, Jean Pihet wrote:
> This commit:
>   573145f08c2b92c45498468afbbba909f6ce6135
>   clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE
> 
> replaced a call to the driver's timer initialization by a call to
> clocksource_of_init(). However, it failed to select CONFIG_CLKSRC_OF.
> 
> Fix this by selecting CONFIG_CLKSRC_OF for Armada370/XP machines.
> Without this change the kernel is stuck at: 'Calibrating delay
> loop...'.
> 
> Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
> Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 9eb63d7..25e6c00 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -26,6 +26,7 @@ config MACH_ARMADA_370_XP
>  	select HAVE_SMP
>  	select CACHE_L2X0
>  	select CPU_PJ4B
> +	select CLKSRC_OF

I disagree. This should go to drivers/clocksource/Kconfig, because it's
the clocksource driver that uses CLOCKSOURCE_OF_DECLARE. See what is
already done in drivers/clocksource/Kconfig for other drivers.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
