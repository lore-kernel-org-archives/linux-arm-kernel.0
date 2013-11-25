From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Nov 2013 18:15:49 +0100
Subject: [PATCH 0/2] can + ARM i.MX53: use 24 MHz clock parent on i.MX53
Message-ID: <1385399751-19109-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series first fixes a bug in the flexcan driver, using the wrong clock for
the bit rate calculcation. The next patch switches the peripheral clock on
i.MX53 to lp_apm, which has a rate of 24 MHz. This is optimal for the CIA
recommended bit rates.

Tested on TQ's mba53 and mba6x [1].

Who is taking the series? Due to Lucas' patch:

    0a5b8df clk: imx5: introduce DT includes for clock provider

this series does not yet apply to my upstream (net-next/mastet).

Marc

[1] On i.MX6 the following patch is needed (which is already in Shawn's
    for-next):

    9b3d423 ARM: i.MX6q: fix the wrong parent of can_root clock
