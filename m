From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 May 2013 11:39:48 +0200
Subject: Freescale imx35: sgtl5000 codec not working over i2c
In-Reply-To: <20130502204020.0462f080@jobraun>
References: <20130502200024.72c112cc@jobraun>
 <20130502181821.GC31135@pengutronix.de>
 <20130502204020.0462f080@jobraun>
Message-ID: <20130503093948.GT32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 08:40:20PM +0200, Johannes Braun wrote:
> Hello Sascha,
> 
> > On Thu, May 02, 2013 at 08:00:24PM +0200, Johannes Braun wrote:
> > > Hello @all,
> > > 
> > > I hope this is the right place for my problem. Currently I am
> > > trying to get a sigmatel sgtl5000 codec to work on a Freescale
> > > imx35 based board. I am using a vanilla kernel 3.7.10. The codec is
> > > connected via i2c. I configured the i2c device
> > > in /arch/arm/mach-imx/mach-proxmobil2.c. Proxmobil2 is the name of
> > > our device. Here is the part which configures the i2c device and
> > > the bus.
> > > 
> > > static const struct imxi2c_platform_data mx35_prox2_i2c0_data
> > > 	__initconst = {
> > >         .bitrate = 100000,
> > > };
> > > 
> > > imx35_add_imx_i2c0(&mx35_prox2_i2c0_data);
> > > 
> > > static struct i2c_board_info __initdata i2c_devices_prox2[] = {
> > >         {
> > >                 I2C_BOARD_INFO("imx-audio-sgtl5000", 0x0a),
> > >         },
> > 
> > The driver matches "sgtl5000", not "imx-audio-sgtl5000".
> 
> I tried "sgtl5000" and "fsl", both without success.

With "sgtl5000" at least sgtl5000_i2c_probe should be called. Is the
i.MX I2C driver registered correctly. What's in /sys/bus/i2c/devices/?

> 
> As I wrote before, my board is based on the very old imx35 processor
> platform and I think this processor type does not support device tree
> out of the box? Or is it possible to use a device tree with an imx35?

you won't need much more than something similar to
arch/arm/mach-imx/imx25-dt.c and an auxdata table for the clock lookups.
There even is pinctrl support.

That said, your actual problem won't be related to that.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
