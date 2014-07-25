From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 25 Jul 2014 14:31:27 +0800
Subject: [PATCH] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <1406194732.21800.1.camel@paszta.hi.pengutronix.de>
References: <1406193474-13695-1-git-send-email-shawn.guo@freescale.com>
 <1406194732.21800.1.camel@paszta.hi.pengutronix.de>
Message-ID: <20140725063126.GF8821@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 11:38:52AM +0200, Philipp Zabel wrote:
> Hi Shawn,
> 
> Am Donnerstag, den 24.07.2014, 17:17 +0800 schrieb Shawn Guo:
> > HDMI currently stops working after a system suspend/resume cycle.  It
> > turns out that the cause is the imx-hdmi encoder .dpms hook doesn't get
> > called from anywhere across suspend/resume cycle.
> > 
> > The patch follows what exynos drm driver does to walk the list of
> > connectors and call their .dpms function from suspend/resume hook.  And
> > the connectors' .dpms function will in turn filter down to the .dpms
> > hooks of encoders and CRTCs.
> > 
> > With this change, HDMI can continue working after a suspend/resume
> > cycle.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> > Tested with HDMI and LVDS.  It'd be great if someone can help test TVE
> > to ensure the patch doesn't break anything.
> 
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> on i.MX53-QSB with VGA via TVE.

Thanks much, Philipp.

Shawn
