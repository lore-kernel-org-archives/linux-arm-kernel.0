From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Mar 2018 15:06:16 +0100
Subject: [PATCH 3/3] arm64: dts: armada-3720-espressobin: wire up LED2
In-Reply-To: <20180321131930.GD11206@lunn.ch>
References: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
 <20180321105005.18426-3-u.kleine-koenig@pengutronix.de>
 <20180321131930.GD11206@lunn.ch>
Message-ID: <20180321140616.6maci3xdiwkz2wma@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 02:19:30PM +0100, Andrew Lunn wrote:
> On Wed, Mar 21, 2018 at 11:50:05AM +0100, Uwe Kleine-K?nig wrote:
> > The led is connected to MPP1_2.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Note the LED doesn't work for me on two different boards.
> 
> Do you have a board it does work with?

No, it doesn't work anywhere.
> 
> > But the voltage levels on one side of the LED changes from 1.76V to
> > 0V when enabling the LED. So there is probably something fishy,
> > don't know if it is hardware or software related.
> 
> I think we should not apply this patch until we get a better idea why
> it does not work.

Ack. I hoped to get some feedback about this issue.

> Is 1.76V not enough? Is the LED mounted the wrong way around? Not
> enough current?

There is another LED on the board called LED3 that is connected between
12V and ground with a R1k that is very bright. It looks identical to the
non-working LED2 which is connected between 1.8V and MPP1_2 with R100.
But there is no BOM available that would tell if the led parts are
different.

With no PSU connected I can make LED1 and LED3 light up with my
multimeter, but not LED2.

I'll try to contact globalscale and ask there.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
