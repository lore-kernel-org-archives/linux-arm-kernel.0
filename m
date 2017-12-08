From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 8 Dec 2017 21:08:13 +0530
Subject: [PATCH v1 1/6] ARM: davinci: clean up map_io functions
In-Reply-To: <1512182054-17410-2-git-send-email-david@lechnology.com>
References: <1512182054-17410-1-git-send-email-david@lechnology.com>
 <1512182054-17410-2-git-send-email-david@lechnology.com>
Message-ID: <2f847539-0425-5d26-a48c-537ed32940ca@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 December 2017 08:04 AM, David Lechner wrote:
>  static int dm355leopard_mmc_get_cd(int module)
>  {
>  	if (!gpio_is_valid(leopard_mmc_gpio))
> @@ -269,7 +264,7 @@ static __init void dm355_leopard_init(void)
>  
>  MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
>  	.atag_offset  = 0x100,
> -	.map_io	      = dm355_leopard_map_io,
> +	.map_io		= dm355_map_io,
>  	.init_irq     = davinci_irq_init,
>  	.init_time	= davinci_timer_init,
>  	.init_machine = dm355_leopard_init,

It seems like spaces were used in original code for indentation. Can you
please introduce a patch to fix that first since you are now touching
this part of the code?

Thanks,
Sekhar
