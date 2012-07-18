From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Jul 2012 10:49:44 +0200
Subject: [PATCH] can: flexcan: add 2nd clock to support imx53 and newer
In-Reply-To: <500675C2.9090303@pengutronix.de>
References: <1342562748-24701-1-git-send-email-mkl@pengutronix.de>
 <50061B86.7080200@gmail.com> <500675C2.9090303@pengutronix.de>
Message-ID: <20120718084944.GD30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 10:37:22AM +0200, Marc Kleine-Budde wrote:
> 
> Yes, good catch.
> 
> Is it allowed to call clk_put with a NULL pointer?

As NULL is a valid clock by definition it is allowed to do this.
However, calling clk_put with a NULL pointer when a corresponding
call to clk_get never returned NULL is probably not a good idea.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
