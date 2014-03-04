From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 4 Mar 2014 21:13:12 +0100
Subject: [PATCH 1/4] mfd: mc13xxx: Honor designed SPI mode
In-Reply-To: <1393840265.156525459@f373.i.mail.ru>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
 <20140303094121.GM24917@pengutronix.de>
 <1393840265.156525459@f373.i.mail.ru>
Message-ID: <20140304201312.GR17250@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 01:51:05PM +0400, Alexander Shiyan wrote:
> ???????????,  3 ????? 2014, 10:41 +01:00 ?? Sascha Hauer <s.hauer@pengutronix.de>:
> > On Sun, Mar 02, 2014 at 11:44:32AM +0400, Alexander Shiyan wrote:
> > > Instead of using hard coded SPI mode, use mode described in
> > > devicetree or defined for the board.
> > > Additionally, patch updates all users of this PMIC to use
> > > correct SPI mode.
> > 
> > What's the reason for this change? Without it the driver just does the
> > correct thing, this only adds a chance for boards do get it wrong. This
> > for example happens with the i.MX27 phyCORE in this patch, see
> > happens with arch/arm/boot/dts/imx27-phytec-phycore-som.dts whih doesn't
> > have the spi-cs-high property.
> 
> How specify proper functionality if chipselect connected through inverter?

Is there such a hardware around?

> 
> For i.MX27 phyCORE:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi?id=986cc4920412d8a7b5c9dba85601651f6373f45e

Ok, I missed that one.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
