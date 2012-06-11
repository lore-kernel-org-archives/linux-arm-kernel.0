From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 11 Jun 2012 13:40:57 +0000
Subject: am33xx: pin modes
In-Reply-To: <4FD5E268.7030105@visionsystems.de>
References: <4FD5E268.7030105@visionsystems.de>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA1E6F0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 17:49:52, Yegor Yefremov wrote:
> I'm working with Koen's repo (https://github.com/koenkooi/linux.git) and have a question. There are two places, where pin's function is defined:
> 
> 
> arch/arm/mach-omap2/mux33xx.c:
> static struct omap_mux __initdata am33xx_muxmodes[] = {
> /**/    _AM33XX_MUXENTRY(GPMC_AD0, 0,
>                 "gpmc_ad0", "mmc1_dat0", NULL, NULL,
>                 NULL, NULL, NULL, "gpio1_0"),
> 

This is the big AM33XX pin mux super set table. Here, Entire Mux entries for AM335x SOC
are defined.

> 
> arch/arm/mach-omap2/board-am335xevm.c:
> {"mdio_data.mdio_data", OMAP_MUX_MODE0 | AM33XX_PIN_INPUT_PULLUP},

This is where the actual board pin-mux is "defined". Later this structure is passed 
to setup_pin_mux() which calls omap_mux_init_signal() where the actual pin-mux
registers are written.

> 
> Is it redundant or OMAP_MUX_x is the only one that changes pins function?
> 
> Regards,
> Yegor
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


Regards, 
Gururaja
