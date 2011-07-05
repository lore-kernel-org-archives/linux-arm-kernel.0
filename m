From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Jul 2011 18:42:38 +0200
Subject: [PATCH 1/2] gpio/mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <20110705033227.GC10594@S2100-06.ap.freescale.net>
References: <1309681017-22970-1-git-send-email-shawn.guo@linaro.org>
	<1309681017-22970-2-git-send-email-shawn.guo@linaro.org>
	<20110704064603.GW6069@pengutronix.de>
	<20110704092800.GG10245@S2100-06.ap.freescale.net>
	<20110704094921.GG6069@pengutronix.de>
	<20110704102008.GH10245@S2100-06.ap.freescale.net>
	<20110704164457.GJ6069@pengutronix.de>
	<20110705030121.GB10594@S2100-06.ap.freescale.net>
	<CACxGe6vHF-k+xCXAYwuQnuRXceD9eJC4ZpSbNXey8cnkX1J2-Q@mail.gmail.com>
	<20110705033227.GC10594@S2100-06.ap.freescale.net>
Message-ID: <20110705164238.GA26347@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 11:32:28AM +0800, Shawn Guo wrote:
> On Mon, Jul 04, 2011 at 09:04:55PM -0600, Grant Likely wrote:
> > On Mon, Jul 4, 2011 at 9:01 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > > On Mon, Jul 04, 2011 at 06:44:57PM +0200, Sascha Hauer wrote:
> > >> Read again. We have three different types of gpio irq controllers, they
> > >> are first seen in the imx1, imx21 and imx31. So all others can be made
> > >> compatible with these three. No need for imx-gpio, imx25-gpio and
> > >> imx27-gpio. The mxc_gpio_devtype would look like this:
> > >>
> > >> static struct platform_device_id mxc_gpio_devtype[] = {
> > >> ? ? ? {
> > >> ? ? ? ? ? ? ? .name = "imx1-gpio",
> > >> ? ? ? ? ? ? ? .driver_data = IMX1_GPIO,
> > >> ? ? ? }, {
> > >> ? ? ? ? ? ? ? .name = "imx21-gpio",
> > >> ? ? ? ? ? ? ? .driver_data = IMX21_GPIO,
> > >> ? ? ? }, {
> > >> ? ? ? ? ? ? ? .name = "imx31-gpio",
> > >> ? ? ? ? ? ? ? .driver_data = IMX31_GPIO,
> > >> ? ? ? }, {
> > >> ? ? ? }
> > >> };
> > >>
> > > This is really what I want to do with dt match table. ?But before we
> > > totally remove platform device probe and switch it over to dt, I'm
> > > unsure we want to do this. ?It will require the following changes on
> > > platform device code registration right now. ?I guess this is
> > > something you do not want, right?
> > 
> > What is the problem with the below changes?  I see no issue with
> > changing the static platform_device registrations in this way.
> > 
> We end up to register "imx21-gpio" in imx27_soc_init, and "imx31-gpio"
> in imx25/35/50/51/53 per-soc-init function.  The may confuse people
> who only look at platform device registration code.  This is something
> may concern Sascha.  Let's see what he thinks.

If we vote for doing this in the device tree then I see no problem doing
so in the platform registration code aswell.


Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
