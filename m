From: jjo.braun@gmail.com (Johannes Braun)
Date: Thu, 2 May 2013 20:40:20 +0200
Subject: Freescale imx35: sgtl5000 codec not working over i2c
In-Reply-To: <20130502181821.GC31135@pengutronix.de>
References: <20130502200024.72c112cc@jobraun>
 <20130502181821.GC31135@pengutronix.de>
Message-ID: <20130502204020.0462f080@jobraun>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

> On Thu, May 02, 2013 at 08:00:24PM +0200, Johannes Braun wrote:
> > Hello @all,
> > 
> > I hope this is the right place for my problem. Currently I am
> > trying to get a sigmatel sgtl5000 codec to work on a Freescale
> > imx35 based board. I am using a vanilla kernel 3.7.10. The codec is
> > connected via i2c. I configured the i2c device
> > in /arch/arm/mach-imx/mach-proxmobil2.c. Proxmobil2 is the name of
> > our device. Here is the part which configures the i2c device and
> > the bus.
> > 
> > static const struct imxi2c_platform_data mx35_prox2_i2c0_data
> > 	__initconst = {
> >         .bitrate = 100000,
> > };
> > 
> > imx35_add_imx_i2c0(&mx35_prox2_i2c0_data);
> > 
> > static struct i2c_board_info __initdata i2c_devices_prox2[] = {
> >         {
> >                 I2C_BOARD_INFO("imx-audio-sgtl5000", 0x0a),
> >         },
> 
> The driver matches "sgtl5000", not "imx-audio-sgtl5000".

I tried "sgtl5000" and "fsl", both without success.

> 
> You should use devicetree support for new boards. The platform support
> will vanish sooner or later.
> 

As I wrote before, my board is based on the very old imx35 processor
platform and I think this processor type does not support device tree
out of the box? Or is it possible to use a device tree with an imx35?
Haven`t seen this before. Is the problem realy the missing device tree
support? 

There are much reasons why I don`t want to spend that much time with
this old product. We had so much problems with this board and probably
in summer there is a new board coming. Maybe an im6q.

---
Johannes
