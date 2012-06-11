From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Mon, 11 Jun 2012 16:27:41 +0200
Subject: am33xx: pin modes
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA1E6F0@DBDE01.ent.ti.com>
References: <4FD5E268.7030105@visionsystems.de>
 <1BAFE6F6C881BF42822005164F1491C33EA1E6F0@DBDE01.ent.ti.com>
Message-ID: <4FD6005D.8070503@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.06.2012 15:40, schrieb Hebbar, Gururaja:
> On Mon, Jun 11, 2012 at 17:49:52, Yegor Yefremov wrote:
>> I'm working with Koen's repo (https://github.com/koenkooi/linux.git) and have a question. There are two places, where pin's function is defined:
>>
>>
>> arch/arm/mach-omap2/mux33xx.c:
>> static struct omap_mux __initdata am33xx_muxmodes[] = {
>> /**/    _AM33XX_MUXENTRY(GPMC_AD0, 0,
>>                 "gpmc_ad0", "mmc1_dat0", NULL, NULL,
>>                 NULL, NULL, NULL, "gpio1_0"),
>>
> This is the big AM33XX pin mux super set table. Here, Entire Mux entries for AM335x SOC
> are defined.
>
>> arch/arm/mach-omap2/board-am335xevm.c:
>> {"mdio_data.mdio_data", OMAP_MUX_MODE0 | AM33XX_PIN_INPUT_PULLUP},
> This is where the actual board pin-mux is "defined". Later this structure is passed 
> to setup_pin_mux() which calls omap_mux_init_signal() where the actual pin-mux
> registers are written.

I understand this, but I see here two redundant definitions:

 {"mii1_txd2.rgmii1_td2", OMAP_MUX_MODE2 | AM33XX_PIN_OUTPUT},

Here both "rgmii1_td2" and "OMAP_MUX_MODE2" are defined. If I misspell "rgmii1_td2"
will the pin have OMAP_MUX_MODE2 or not?

Best regards,
Yegor 
