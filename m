From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 15 Oct 2012 07:59:41 +0200
Subject: [PATCH 1/5] ARM: AT91: Fix build failure on board-dt
In-Reply-To: <1350251199-28065-2-git-send-email-manabian@gmail.com>
References: <1350251199-28065-1-git-send-email-manabian@gmail.com>
 <1350251199-28065-2-git-send-email-manabian@gmail.com>
Message-ID: <20121015055941.GS12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:46 Sun 14 Oct     , Joachim Eastwood wrote:
> We need CONFIG_SOC_AT91SAM9 to get the at91sam926x_timer
> symbol used in board-dt.
as I said before you can not do a select you need to do a depends

as you will have no clock as you select no SoC

Best Regards,
J.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  arch/arm/mach-at91/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 0fafb6a..d9b0546 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -507,6 +507,7 @@ comment "Generic Board Type"
>  
>  config MACH_AT91SAM_DT
>  	bool "Atmel AT91SAM Evaluation Kits with device-tree support"
> +	select SOC_AT91SAM9
>  	select USE_OF
>  	help
>  	  Select this if you want to experiment device-tree with
> -- 
> 1.7.12.3
> 
