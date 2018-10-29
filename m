From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 10:33:06 +0100
Subject: [PATCH v3 18/25] drm/panel: Add Bananapi S070WV20-CT16 ICN6211
 MIPI-DSI to RGB bridge
In-Reply-To: <20181026144344.27778-19-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-19-jagan@amarulasolutions.com>
Message-ID: <20181029093306.ysyfgnrozbo2ywcu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:13:37PM +0530, Jagan Teki wrote:
> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB bridge
> panel which can be used to connect via DSI port on BPI-M64 board,
> so add a driver for it.
> 
> The same panel PCB comes with parallel RBG which is supported via
> panel-simple driver with "bananapi,s070wv20-ct16" compatible.
> 
> BSP dclock of 30MHz is not working with existing sunxi-ng and sun4i
> sun4i_dclk_recalc, so updated to 55MHz can result proper working
> nkm dividers.
> 
> dclock, 30MHz => PLL_MIPI, 300MHz => set rate 440MHz with 1,2,1 nkm
> dclock, 55MHz => PLL_MIPI, 300MHz => set rate 330MHz with 5,2,9 nkm

That panel is generic, you don't need those details in your commit log.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/78392ef9/attachment.sig>
