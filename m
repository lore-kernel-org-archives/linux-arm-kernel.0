From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 May 2013 10:27:08 +0200
Subject: [PATCH 3/3] ARM: imx: create imx_arch_reset_init() for DT boot
In-Reply-To: <1368408728-12264-4-git-send-email-shawn.guo@linaro.org>
References: <1368408728-12264-1-git-send-email-shawn.guo@linaro.org>
 <1368408728-12264-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130513082708.GN32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 09:32:08AM +0800, Shawn Guo wrote:
> The mxc_arch_reset_init() uses static mapping and calls clk_get_sys() to
> get clock.  It's suitable for non-DT boot but not for DT boot where
> dynamic mapping and of_clk_get() should be used instead.  Create
> imx_arch_reset_init() as the DT variant of mxc_arch_reset_init(),
> and change DT platforms to use it.

Having mxc_arch_reset_init for !dt and the same functionality for dt
named imx_arch_reset_init is a bit confusing. Maybe add _dt_ to the
function name?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
