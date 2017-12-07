From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 07 Dec 2017 17:04:49 +0100
Subject: [PATCH net-next v2 7/8] net: phy: meson-gxl: add interrupt support
In-Reply-To: <20171207155421.GJ24750@lunn.ch>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
 <20171207142715.32578-8-jbrunet@baylibre.com>
 <20171207155421.GJ24750@lunn.ch>
Message-ID: <1512662689.7042.20.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-07 at 16:54 +0100, Andrew Lunn wrote:
> On Thu, Dec 07, 2017 at 03:27:14PM +0100, Jerome Brunet wrote:
> > Enable interrupt support in meson-gxl PHY driver
> 
> Hi Jerome
> 
> Is it possible to implement did_interrupt()? That allows for shared
> interrupts. It does however work fine without it, so long as the
> interrupt is not shared.

Hi Andrew,

It is always possible ;). The irq status registers gets reset on read.

In such case, ack_interrupt() and did_interrupt() would be more or less the same
function, except for the returned value, I guess ?

The phy being internal, I think it is unlikely to ever share its interrupt
though. If you prefer I implement this callback, I can certainly re-spin with it
?

Thanks for the lightning fast review by the way !

> 
> 	  Thanks
> 		Andrew
