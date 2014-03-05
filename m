From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 5 Mar 2014 12:57:07 +0100
Subject: [PATCH 1/4] mfd: mc13xxx: Honor designed SPI mode
In-Reply-To: <1393966265.723735713@f346.i.mail.ru>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
 <1393840265.156525459@f373.i.mail.ru>
 <20140304201312.GR17250@pengutronix.de>
 <1393966265.723735713@f346.i.mail.ru>
Message-ID: <20140305115707.GU17250@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 12:51:05AM +0400, Alexander Shiyan wrote:
> ???????,  4 ????? 2014, 21:13 +01:00 ?? Sascha Hauer <s.hauer@pengutronix.de>:
> > On Mon, Mar 03, 2014 at 01:51:05PM +0400, Alexander Shiyan wrote:
> > > ???????????,  3 ????? 2014, 10:41 +01:00 ?? Sascha Hauer <s.hauer@pengutronix.de>:
> > > > On Sun, Mar 02, 2014 at 11:44:32AM +0400, Alexander Shiyan wrote:
> > > > > Instead of using hard coded SPI mode, use mode described in
> > > > > devicetree or defined for the board.
> > > > > Additionally, patch updates all users of this PMIC to use
> > > > > correct SPI mode.
> > > > 
> > > > What's the reason for this change? Without it the driver just does the
> > > > correct thing, this only adds a chance for boards do get it wrong. This
> > > > for example happens with the i.MX27 phyCORE in this patch, see
> > > > happens with arch/arm/boot/dts/imx27-phytec-phycore-som.dts whih doesn't
> > > > have the spi-cs-high property.
> > > 
> > > How specify proper functionality if chipselect connected through inverter?
> > 
> > Is there such a hardware around?
> 
> AFAIK no, but it is a protection for the future. Since this driver handle several PMICs,
> we must anticipate the addition of new types of ICs and the emergence of new
> devices using these PMICs, which could use external logic for chipselect.
> Instead use tricks, use proper definitions (or DT description), from my point of view,
> better.

In that case rather than breaking devicetree compatibility we really
should leave this problem to someone who actually has this problem. He
could introduce an explicit spi-cs-low property to overwrite the driver
preference.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
