From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 7 Dec 2009 21:03:26 +0100
Subject: [RFC][PATCH 03/10] arm: mxc: changes to common plat-mxc codeto
	add support for i.MX5
In-Reply-To: <DE2504B3A515524BBE6934369EFDC0DA08C2A879@az33exm20.fsl.freescale.net>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<58eb7d14c6cf56cbc874657dff5789c47116b49e.1259893118.git.amit.kucheria@canonical.com>
	<DE2504B3A515524BBE6934369EFDC0DA08C2A56C@az33exm20.fsl.freescale.net>
	<20091204105908.GJ15126@pengutronix.de>
	<DE2504B3A515524BBE6934369EFDC0DA08C2A879@az33exm20.fsl.freescale.net>
Message-ID: <20091207200326.GU22533@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Mon, Dec 07, 2009 at 10:17:52AM -0700, Herring Robert-RA7055 wrote:
> Sorry, my mistake. Sasha is correct that MX27 is v1 and MX25 is v2.
> 
> timer_is_v1 is just !timer_is_v2, so really only one is needed. I would
> define it like this to avoid having to change the timer code again for
> any new chips:
> 
> #define timer_is_v2()   (!(cpu_is_mx1() || cpu_is_mx21() ||
> cpu_is_mx27()))

Are you sure that FSL won't invent a v3 timer in the future?

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
