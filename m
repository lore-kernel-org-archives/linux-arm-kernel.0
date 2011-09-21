From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 21 Sep 2011 11:28:36 +0200
Subject: [PATCH 02/11] at91/boards: use -1 for invalid gpio
In-Reply-To: <1316436695-19194-2-git-send-email-plagnioj@jcrosoft.com>
References: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
	<1316436695-19194-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4E79AE44.3070006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/09/2011 14:51, Jean-Christophe PLAGNIOL-VILLARD :
> this will allow to use gpio_is_valid
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

[..]

> ---
>  34 files changed, 141 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
> index 5aa5885..17d9163 100644
> --- a/arch/arm/mach-at91/board-1arm.c
> +++ b/arch/arm/mach-at91/board-1arm.c
> @@ -70,6 +70,7 @@ static struct at91_eth_data __initdata onearm_eth_data = {
>  
>  static struct at91_usbh_data __initdata onearm_usbh_data = {
>  	.ports		= 1,
> +	.vbus_pin	= {-1, -1},

I would prefer to use "-EINVAL" as stated in the documentation.

Best regards,
-- 
Nicolas Ferre
