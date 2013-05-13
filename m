From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 May 2013 20:52:17 +0800
Subject: [PATCH 3/3] ARM: imx: create imx_arch_reset_init() for DT boot
In-Reply-To: <20130513082708.GN32299@pengutronix.de>
References: <1368408728-12264-1-git-send-email-shawn.guo@linaro.org>
 <1368408728-12264-4-git-send-email-shawn.guo@linaro.org>
 <20130513082708.GN32299@pengutronix.de>
Message-ID: <20130513125215.GC4440@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 10:27:08AM +0200, Sascha Hauer wrote:
> On Mon, May 13, 2013 at 09:32:08AM +0800, Shawn Guo wrote:
> > The mxc_arch_reset_init() uses static mapping and calls clk_get_sys() to
> > get clock.  It's suitable for non-DT boot but not for DT boot where
> > dynamic mapping and of_clk_get() should be used instead.  Create
> > imx_arch_reset_init() as the DT variant of mxc_arch_reset_init(),
> > and change DT platforms to use it.
> 
> Having mxc_arch_reset_init for !dt and the same functionality for dt
> named imx_arch_reset_init is a bit confusing. Maybe add _dt_ to the
> function name?

Ok, will change it to mxc_arch_reset_init_dt() avoid the confusion.

Shawn
