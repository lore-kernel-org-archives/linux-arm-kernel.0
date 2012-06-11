From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Mon, 11 Jun 2012 14:19:52 +0200
Subject: am33xx: pin modes
Message-ID: <4FD5E268.7030105@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm working with Koen's repo (https://github.com/koenkooi/linux.git) and have a question. There are two places, where pin's function is defined:


arch/arm/mach-omap2/mux33xx.c:
static struct omap_mux __initdata am33xx_muxmodes[] = {
/**/    _AM33XX_MUXENTRY(GPMC_AD0, 0,
                "gpmc_ad0", "mmc1_dat0", NULL, NULL,
                NULL, NULL, NULL, "gpio1_0"),


arch/arm/mach-omap2/board-am335xevm.c:
{"mdio_data.mdio_data", OMAP_MUX_MODE0 | AM33XX_PIN_INPUT_PULLUP},

Is it redundant or OMAP_MUX_x is the only one that changes pins function?

Regards,
Yegor
