From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 2 May 2013 20:18:21 +0200
Subject: Freescale imx35: sgtl5000 codec not working over i2c
In-Reply-To: <20130502200024.72c112cc@jobraun>
References: <20130502200024.72c112cc@jobraun>
Message-ID: <20130502181821.GC31135@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 08:00:24PM +0200, Johannes Braun wrote:
> Hello @all,
> 
> I hope this is the right place for my problem. Currently I am trying to
> get a sigmatel sgtl5000 codec to work on a Freescale imx35 based board.
> I am using a vanilla kernel 3.7.10. The codec is connected via i2c. I
> configured the i2c device in /arch/arm/mach-imx/mach-proxmobil2.c.
> Proxmobil2 is the name of our device. Here is the part which configures
> the i2c device and the bus.
> 
> static const struct imxi2c_platform_data mx35_prox2_i2c0_data
> 	__initconst = {
>         .bitrate = 100000,
> };
> 
> imx35_add_imx_i2c0(&mx35_prox2_i2c0_data);
> 
> static struct i2c_board_info __initdata i2c_devices_prox2[] = {
>         {
>                 I2C_BOARD_INFO("imx-audio-sgtl5000", 0x0a),
>         },

The driver matches "sgtl5000", not "imx-audio-sgtl5000".

You should use devicetree support for new boards. The platform support
will vanish sooner or later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
