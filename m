From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 05 Mar 2014 00:51:05 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzRdIG1mZDogbWMxM3h4eDogSG9ub3IgZGVzaWduZWQg?=
 =?UTF-8?B?U1BJIG1vZGU=?=
In-Reply-To: <20140304201312.GR17250@pengutronix.de>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
 <1393840265.156525459@f373.i.mail.ru>
 <20140304201312.GR17250@pengutronix.de>
Message-ID: <1393966265.723735713@f346.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????,  4 ????? 2014, 21:13 +01:00 ?? Sascha Hauer <s.hauer@pengutronix.de>:
> On Mon, Mar 03, 2014 at 01:51:05PM +0400, Alexander Shiyan wrote:
> > ???????????,  3 ????? 2014, 10:41 +01:00 ?? Sascha Hauer <s.hauer@pengutronix.de>:
> > > On Sun, Mar 02, 2014 at 11:44:32AM +0400, Alexander Shiyan wrote:
> > > > Instead of using hard coded SPI mode, use mode described in
> > > > devicetree or defined for the board.
> > > > Additionally, patch updates all users of this PMIC to use
> > > > correct SPI mode.
> > > 
> > > What's the reason for this change? Without it the driver just does the
> > > correct thing, this only adds a chance for boards do get it wrong. This
> > > for example happens with the i.MX27 phyCORE in this patch, see
> > > happens with arch/arm/boot/dts/imx27-phytec-phycore-som.dts whih doesn't
> > > have the spi-cs-high property.
> > 
> > How specify proper functionality if chipselect connected through inverter?
> 
> Is there such a hardware around?

AFAIK no, but it is a protection for the future. Since this driver handle several PMICs,
we must anticipate the addition of new types of ICs and the emergence of new
devices using these PMICs, which could use external logic for chipselect.
Instead use tricks, use proper definitions (or DT description), from my point of view,
better.

> > For i.MX27 phyCORE:
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi?id=986cc4920412d8a7b5c9dba85601651f6373f45e
> 
> Ok, I missed that one.

---
