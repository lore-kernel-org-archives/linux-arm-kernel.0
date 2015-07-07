From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Tue, 07 Jul 2015 15:37:49 +0200
Subject: [PATCH v2 5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio
 for bus recovery
In-Reply-To: <5476085B.40009@ti.com>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-6-git-send-email-grygorii.strashko@ti.com>
 <20141126160407.GN4431@pengutronix.de> <5476085B.40009@ti.com>
Message-ID: <1436276269.3344.94.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mi, 2014-11-26 at 19:05 +0200, Grygorii Strashko wrote:
> On 11/26/2014 06:04 PM, Uwe Kleine-K?nig wrote:
> > On Wed, Nov 26, 2014 at 03:59:53PM +0200, Grygorii Strashko wrote:
> >> Having a board where the I2C bus locks up occasionally made it clear
> >> that the bus recovery in the i2c-davinci driver will only work on
> >> some boards, because on regular boards, this will only toggle GPIO
> >> lines that aren't muxed to the actual pins.
> >>
> >> The I2C controller on SoCs like da850 (and da830), Keystone 2 has the
> >> built-in capability to bit-bang its lines by using the ICPFUNC registers
> >> of the i2c controller.
> >> Implement the suggested procedure by toggling SCL and checking SDA using
> >> the ICPFUNC registers of the I2C controller when present. Allow platforms
> >> to indicate the presence of the ICPFUNC registers with a has_pfunc platform
> >> data flag and add optional DT property "ti,has-pfunc" to indicate
> >> the same in DT.
> > On what does it depend if this pfunc stuff works or not? Only the SoC,
> > or also on some board specific properties?
> 
> SoC / set of SoCs. Also, similar feature is supported by OMAP and AM335x/AM437x SoCs
> using I2C_SYSTEST register.
> 
> > Given the former using the
> > compatible string to detect its availability would be better. (In this
> > case also sorry, didn't consider this case when requesting the property
> > in the last round.)

I only stumbled across this after it was merged, with the additional
ti,has-pfunc property instead of using the compatible string (which
would be better for a soc-dependent feature). Can we still fix this?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
