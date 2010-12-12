From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 12 Dec 2010 01:50:48 +0100
Subject: [PATCH v4] mach-at91: Support for gsia18s board added
In-Reply-To: <1292000411-6691-1-git-send-email-plyatov@gmail.com>
References: <1292000411-6691-1-git-send-email-plyatov@gmail.com>
Message-ID: <20101212005048.GH19897@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:00 Fri 10 Dec     , Igor Plyatov wrote:
> The GS_IA18_S (GMS) is a carrier board from GeoSIG Ltd used with the
> Stamp9G20 SoM from Taskit company.
> It operate as an internet accelerometer.
> 
> Signed-off-by: Igor Plyatov <plyatov@gmail.com>
> ---
>  arch/arm/configs/gsia18s_defconfig        |  147 +++++++
please no new defconfig
start to merge them


your patch contain a lots of whitespace please fix it
> +
> +/*
> + * Up to date linux/arch/arm/tools/mach-types database required to support this.
> +MACHINE_START(GSIA18S, "GS_IA18_S")
> +*/
> +MACHINE_START(STAMP9G20, "GS_IA18_S")
if you do this you must use system_rev to identify the board
> +	.boot_params	= AT91_SDRAM_BASE + 0x100,
> +	.timer		= &at91sam926x_timer,
> +	.map_io		= gsia18s_map_io,
> +	.init_irq	= init_irq,
> +	.init_machine	= gsia18s_board_init,
> +MACHINE_END
Best Regards,
J.
