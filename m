From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 23 Apr 2013 07:07:45 +0200
Subject: [RFC][PATCH] video: imx: Select VIDEOMODE_HELPERS
In-Reply-To: <201304230157.47992.marex@denx.de>
References: <1366666110-9585-1-git-send-email-marex@denx.de>
 <CAOMZO5Av8RyptoxAQ13Psxjjd4nhHVbEJoVm6SqyLr55bPmSng@mail.gmail.com>
 <201304230157.47992.marex@denx.de>
Message-ID: <20130423050745.GO32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 01:57:47AM +0200, Marek Vasut wrote:
> Dear Fabio Estevam,
> 
> > Hi Marek,
> > 
> > On Mon, Apr 22, 2013 at 6:28 PM, Marek Vasut <marex@denx.de> wrote:
> > > Without this, I get the following problem when building kernel:
> > > 
> > > drivers/built-in.o: In function `imx_pd_connector_get_modes':
> > > /linux-2.6/drivers/staging/imx-drm/parallel-display.c:78: undefined
> > > reference to `of_get_drm_display_mode' make: *** [vmlinux] Error 1
> > > 
> > > NOTE: I think this patch is almost absolutely not correct.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Patch looks good, but you should have copied Greg Kroah-Hartman, as he
> > is the one who takes patches into staging.
> 
> I'm not sure if the select is at correct symbol, I dont think it is.

No it's not. The parallel display driver needs it, not the i.MX drm
support in general.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
