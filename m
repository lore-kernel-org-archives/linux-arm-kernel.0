From: marex@denx.de (Marek Vasut)
Date: Tue, 23 Apr 2013 12:29:48 +0200
Subject: [RFC][PATCH] video: imx: Select VIDEOMODE_HELPERS
In-Reply-To: <20130423050745.GO32299@pengutronix.de>
References: <1366666110-9585-1-git-send-email-marex@denx.de>
 <201304230157.47992.marex@denx.de> <20130423050745.GO32299@pengutronix.de>
Message-ID: <201304231229.48511.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

> On Tue, Apr 23, 2013 at 01:57:47AM +0200, Marek Vasut wrote:
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
> No it's not. The parallel display driver needs it, not the i.MX drm
> support in general.

Yep, I expected this coming, thus RFC. I'll roll out new patch and move this to 
parallel display, ok?

Best regards,
Marek Vasut
