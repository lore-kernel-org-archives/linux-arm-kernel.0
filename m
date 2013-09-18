From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 18 Sep 2013 14:56:11 -0400
Subject: [PATCH] arm: mvebu: use the main timer as clock source from DT
In-Reply-To: <1379530168-9359-1-git-send-email-jean.pihet@linaro.org>
References: <1379530168-9359-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <20130918185611.GP19937@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding clocksource maintainers to the Cc: ...

On Wed, Sep 18, 2013 at 08:49:28PM +0200, Jean Pihet wrote:
> This commit:
>   573145f08c2b92c45498468afbbba909f6ce6135
>   clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE
> 
> replaced a call to the driver's timer initialization by a call to
> clocksource_of_init(). However, it failed to select CONFIG_CLKSRC_OF.
> 
> Fix this by selecting CONFIG_CLKSRC_OF for Armada370/XP machines.
> Without this change the kernel is stuck at: 'Calibrating delay loop...'.
> 
> Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
> Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/clocksource/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

Daniel, John, Thomas,

Can you queue this up for v3.12-rc2?  It fixes a boot breakage.

thx,

Jason.

> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 41c6946..971d796 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -26,6 +26,7 @@ config DW_APB_TIMER_OF
>  
>  config ARMADA_370_XP_TIMER
>  	bool
> +	select CLKSRC_OF
>  
>  config ORION_TIMER
>  	select CLKSRC_OF
> -- 
> 1.7.11.7
> 
