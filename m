From: marex@denx.de (Marek Vasut)
Date: Wed, 24 Apr 2013 02:31:49 +0200
Subject: [RFC][PATCH] video: imx: Select VIDEOMODE_HELPERS
In-Reply-To: <1366702862.4365.2.camel@pizza.hi.pengutronix.de>
References: <1366666110-9585-1-git-send-email-marex@denx.de>
 <201304230157.47992.marex@denx.de>
 <1366702862.4365.2.camel@pizza.hi.pengutronix.de>
Message-ID: <201304240231.49579.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

> Hi Marek,
> 
> Am Dienstag, den 23.04.2013, 01:57 +0200 schrieb Marek Vasut:
> > Dear Fabio Estevam,
> > 
> > > Hi Marek,
> > > 
> > > On Mon, Apr 22, 2013 at 6:28 PM, Marek Vasut <marex@denx.de> wrote:
> > > > Without this, I get the following problem when building kernel:
> > > > 
> > > > drivers/built-in.o: In function `imx_pd_connector_get_modes':
> > > > /linux-2.6/drivers/staging/imx-drm/parallel-display.c:78: undefined
> > > > reference to `of_get_drm_display_mode' make: *** [vmlinux] Error 1
> > > > 
> > > > NOTE: I think this patch is almost absolutely not correct.
> > > > 
> > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > > 
> > > Patch looks good, but you should have copied Greg Kroah-Hartman, as he
> > > is the one who takes patches into staging.
> > 
> > I'm not sure if the select is at correct symbol, I dont think it is.
> 
> OF_VIDEOMODE is the correct one. The implementation of
> of_get_drm_display_mode in drivers/gpu/drm/drm_modes.c depends on it.

I really need VIDEOMODE_HELPERS, not OF_VIDEOMODE. If I select only 
OF_VIDEOMODE, I still get the issue above.

Check drivers/gpu/drm/drm_modes.c , it's protected by CONFIG_VIDEOMODE_HELPERS

Best regards,
Marek Vasut
