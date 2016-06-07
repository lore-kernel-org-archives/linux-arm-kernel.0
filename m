From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Jun 2016 18:25:45 +0200
Subject: shared resources in AMP between Cortex-A9 and Cortex-M4
Message-ID: <20160607162545.GX26768@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

I'm currently trying to get Linux running on the M4 of an i.MX6 Solo X
and found you describing doing this on the Vybrid already[1].

I see the problem that clk and pinmux must be used by both cores. Did
you solve this for your Vybrid experiments? And if so, how did it work?

Having two drivers on the same IP is racy at best and using some kind of
inter cpu communication to let (say) the A9 enable the clks for the M4
sounds like overkill.

Best regards
Uwe

[1] https://falstaff.agner.ch/2015/05/17/u-boot-command-to-boot-vybrids-cortex-m4-core/
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
