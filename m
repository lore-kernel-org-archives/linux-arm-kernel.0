From: pgsellmann@portner-elektronik.at (Peter Gsellmann)
Date: Fri, 08 Oct 2010 17:10:44 +0200
Subject: [PATCH] ARM: AT91: add board support for Pcontrol_G20
In-Reply-To: <20101008123407.GB30252@game.jcrosoft.org>
References: <1286466086.4306.41.camel@aspire.localdomain>
	<20101008123407.GB30252@game.jcrosoft.org>
Message-ID: <1286550644.21584.34.camel@aspire.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 08.10.2010, 14:34 +0200 schrieb Jean-Christophe
PLAGNIOL-VILLARD: 
> On 17:41 Thu 07 Oct     , Peter Gsellmann wrote:
> > Added target is a carrier board for Stamp9G20 with additional
> > peripherals and memories. Configuration is mostly copied from there.
> > Added Code is only active if CONFIG_MACH_PCONTROL_G20=y
> > 
> > Signed-off-by: Peter Gsellmann <pgsellmann@portner-elektronik.at>
> > ---
> >  arch/arm/configs/pcontrol_g20_defconfig | 1721 +++++++++++++++++++++++++++++++
> please use savedefconfig
ok. didnt realize until now this useful target

> > +config MACH_PCONTROL_G20
> > +	bool "PControl G20 CPU module"
> > +	help
> > +	  Select this if you are using taskit's Stamp9G20 CPU module on this
> > +	  carrier board.
> > +
> what is the difference with stamg9g20?
As the stamp9g20 itself is little more than cpu+nandflash+sdram all the
needed peripherals, buffers and hardware drivers for my purpose
(building automation) are on my carrier board, which itself is a plug-in
card. Other boards using stamp9g20 may have an entire different set of
peripherals, incompatible to mine.

> > +/*
> > + * NAND flash 512MiB 1,8V 8-bit, sector size 128 KiB
> > + */
> > +static struct atmel_nand_data __initdata nand_data = {
> > +	.ale		= 21,
> > +	.cle		= 22,
> > +	.rdy_pin	= AT91_PIN_PC13,
> > +	.enable_pin	= AT91_PIN_PC14,
> > +	.bus_width_16	= 0,
> non need it's 0 by default
ok.

> > +/*
> > + * I2C devices: eeprom and phy/switch
> > + */
> > +static struct i2c_board_info __initdata pcontrol_g20_i2c_devices[] = {
> > +        {
> > +                I2C_BOARD_INFO("24c64", 0x50)	/* D7 address width=2, 8KiB */
> > +        }, {
> > +                I2C_BOARD_INFO("lan9303", 0x0a)	/* D8 address width=1, byte has 32 bits! */
> > +        },
> > +};
> whitespace please fix it
ok. work in progress, also wrapping the long lines

> > +/*
> > + * LEDs
> > + */
> > +static struct gpio_led pcontrol_g20_leds[] = {
> > +	{
> > +		.name			= "LED1",	/* red  H5 */
> is it no better to give a better namei for the leds?
I dont know what is the best name for a led. I could use the name from
the schematic (H5) which is random or the readable text nearby the led
(Alarm) which could contain spaces and/or german characters.
Are there any recommendations?


I will recreate and resubmit the patch on monday.

> best Regards,
> J.
thanks for review,
Peter
