From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 29 May 2015 08:35:38 +0200
Subject: [PATCH 0/3] clk: Add regmap support for clk mulitplexer
In-Reply-To: <1432838508-5184-1-git-send-email-matthias.bgg@gmail.com>
References: <1432838508-5184-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <20150529063538.GZ6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 08:41:45PM +0200, Matthias Brugger wrote:
> This patch set adds regmap support for the simple clock multiplexer.
> Regmap use, apart from a pointer to the regmap struct needs an
> offset value to know where in the regmap it has to read/write.
> We add both fields to struct clk_mux.
> 
> The driver will distinguish between a clock which is based on regmap or not
> through a flag specified for the mux.
> The approach does not break the existing clock framework API but adds two
> new functions for registering regmap clocks. Unregistering the clocks is
> independent of the use of regmap or not, so that no new function was
> implemented.
> 
> As an example user of the regmap clock multiplexer, it was implemented on
> the mt8135. When accepted it will also be applied to the other Mediatek SoCs.
> Other possible user are Qualcomm SoCs which up to now implement their own
> regmap based clock multiplexer.

I'm all in for providing regmap support for the basic clk providers.
>From digging through the archives I found out that the last try failed,
so I hesitated to implement this for Mediatek. I hope it's time to
revisit this. Using regmap would make the basic clock providers much
more versatilely usable.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
