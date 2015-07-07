From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Jul 2015 15:48:52 +0200
Subject: [PATCH v2 5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio
 for bus recovery
In-Reply-To: <1436276269.3344.94.camel@pengutronix.de>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-6-git-send-email-grygorii.strashko@ti.com>
 <20141126160407.GN4431@pengutronix.de> <5476085B.40009@ti.com>
 <1436276269.3344.94.camel@pengutronix.de>
Message-ID: <20150707134852.GE9671@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jul 07, 2015 at 03:37:49PM +0200, Jan L?bbe wrote:
> On Mi, 2014-11-26 at 19:05 +0200, Grygorii Strashko wrote:
> > On 11/26/2014 06:04 PM, Uwe Kleine-K?nig wrote:
> > > On Wed, Nov 26, 2014 at 03:59:53PM +0200, Grygorii Strashko wrote:
> > >> Having a board where the I2C bus locks up occasionally made it clear
> > >> that the bus recovery in the i2c-davinci driver will only work on
> > >> some boards, because on regular boards, this will only toggle GPIO
> > >> lines that aren't muxed to the actual pins.
> > >>
> > >> The I2C controller on SoCs like da850 (and da830), Keystone 2 has the
> > >> built-in capability to bit-bang its lines by using the ICPFUNC registers
> > >> of the i2c controller.
> > >> Implement the suggested procedure by toggling SCL and checking SDA using
> > >> the ICPFUNC registers of the I2C controller when present. Allow platforms
> > >> to indicate the presence of the ICPFUNC registers with a has_pfunc platform
> > >> data flag and add optional DT property "ti,has-pfunc" to indicate
> > >> the same in DT.
> > > On what does it depend if this pfunc stuff works or not? Only the SoC,
> > > or also on some board specific properties?
> > 
> > SoC / set of SoCs. Also, similar feature is supported by OMAP and AM335x/AM437x SoCs
> > using I2C_SYSTEST register.
> > 
> > > Given the former using the
> > > compatible string to detect its availability would be better. (In this
> > > case also sorry, didn't consider this case when requesting the property
> > > in the last round.)
> 
> I only stumbled across this after it was merged, with the additional
I also wonder how it came to the Reviewed-by tag for me. The last thing
that I said about the patch was "On what does it depend if this pfunc
stuff works or not? Only the SoC, or also on some board specific
properties?" (see above) and "the patch looks ok". IMHO this hardly
justifies to add the Reviewed-by tag for the next round. :-(

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
