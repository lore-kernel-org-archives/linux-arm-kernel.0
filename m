From: thommycheck@gmx.de (Thomas Kunze)
Date: Thu, 31 Dec 2009 14:23:56 +0100
Subject: [PATCH 1/7] [ARM] sa1100: remove unreferenced IRQ definitions
In-Reply-To: <1261977488-18271-2-git-send-email-eric.y.miao@gmail.com>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
	<1261977488-18271-2-git-send-email-eric.y.miao@gmail.com>
Message-ID: <4B3CA5EC.30102@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> These IRQ definitions related to LOCOMO are never referenced anywhere,
> thus could be safely removed.
>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
>  arch/arm/mach-sa1100/include/mach/collie.h |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-sa1100/include/mach/collie.h b/arch/arm/mach-sa1100/include/mach/collie.h
> index 71a0b3f..52acda7 100644
> --- a/arch/arm/mach-sa1100/include/mach/collie.h
> +++ b/arch/arm/mach-sa1100/include/mach/collie.h
> @@ -72,13 +72,6 @@
>  #define COLLIE_IRQ_GPIO_GA_INT		IRQ_GPIO25
>  #define COLLIE_IRQ_GPIO_MAIN_BAT_LOW	IRQ_GPIO26
>  
> -#define COLLIE_LCM_IRQ_GPIO_RTS		IRQ_LOCOMO_GPIO0
> -#define COLLIE_LCM_IRQ_GPIO_CTS		IRQ_LOCOMO_GPIO1
> -#define COLLIE_LCM_IRQ_GPIO_DSR		IRQ_LOCOMO_GPIO2
> -#define COLLIE_LCM_IRQ_GPIO_DTR		IRQ_LOCOMO_GPIO3
> -#define COLLIE_LCM_IRQ_GPIO_nSD_DETECT	IRQ_LOCOMO_GPIO13
> -#define COLLIE_LCM_IRQ_GPIO_nSD_WP	IRQ_LOCOMO_GPIO14
> -
>  /* GPIO's on the TC35143AF (Toshiba Analog Frontend) */
>  #define COLLIE_TC35143_GPIO_BASE	(GPIO_MAX + 13)
>  #define COLLIE_TC35143_GPIO_VERSION0    UCB_IO_0
>   
Those definitions are used in out-of-tree drivers. So please don't 
remove them.

Regards,
Thomas
