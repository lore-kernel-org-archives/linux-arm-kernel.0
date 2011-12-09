From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 9 Dec 2011 14:01:09 +0100
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <20111209110807.GG27267@pengutronix.de>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
 <20111209010147.GH7913@S2100-06.ap.freescale.net>
 <4EE18403.30604@nvidia.com>
 <20111209043220.GJ7913@S2100-06.ap.freescale.net>
 <4EE192DC.3080209@nvidia.com>
 <20111209051413.GK7913@S2100-06.ap.freescale.net>
 <20111209110807.GG27267@pengutronix.de>
Message-ID: <20111209130109.GT4585@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 12:08:07PM +0100, Sascha Hauer wrote:
> On Fri, Dec 09, 2011 at 01:14:14PM +0800, Shawn Guo wrote:
> > On Thu, Dec 08, 2011 at 09:47:24PM -0700, Stephen Warren wrote:
> > > 
> > > pin X: function = UART A TX
> > > pin Y: function = UART A RX
> > > 
> > 
> > We really do not expect per pin function mapping but per block function
> > mapping.  That said, the UART driver is going to tell pinctrl subsystem
> > "I'm UARTA, please set all my pins up for me".
> 
> I still think it should be "I'm board Y, please set all my pins up for me"
> 
> Drivers should not be bothered with pin muxing *at all*. When we add
> pinmux_request to drivers all SoCs using this driver are doomed to
> implement pinmux support regardless if they have any pinmux support in
> hardware or not.
> Where this leads we can currently see in current next branch with the
> smc91x driver where one single board has a regulator for.  Suddenly all
> other boards using this driver stopped working because they have no
> regulator provided for the driver.
It's the same problem with clks. IMHO that's OK.

> There is this CONFIG_REGULATOR_DUMMY option which will cause *all*
> regulator_request to succeed on all regulators in this binary which
> disqualifies this option for multiboard/SoC Kernels.
> A pin setup is board specific and not driver specific. There are only
An upside of making drivers pinctrl-aware is that it might solve the
hardware conflicts on development boards. And the way pinctrl works it's
still the board that sets up the connection between device and how which
pins are configured.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
