From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 22 Jun 2011 00:57:58 +0200
Subject: [PATCH 6/6] ARM: mxc: clean up imx-dma device registration
In-Reply-To: <20110620145054.GA24184@S2100-06.ap.freescale.net>
References: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
	<1307950645-26529-7-git-send-email-shawn.guo@linaro.org>
	<20110620145054.GA24184@S2100-06.ap.freescale.net>
Message-ID: <20110621225758.GG6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 10:50:55PM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> Any comment on this one?
>

Please respin this series on the for-next branch. Fabio has
added i.MX53 support in the meantime and this does not apply anymore.

Sascha
 
> Regards,
> Shawn
> 
> On Mon, Jun 13, 2011 at 03:37:25PM +0800, Shawn Guo wrote:
> > The patch follows the implementation of gpio-mxc device registration
> > to break the concentrated imx-dma device registration into soc
> > specific setup function.  Then we can avoid the churn of "#ifdef"
> > and the cpu_is_mx checking on such a long list, which makes no sense,
> > considering more soc supports need to be added and we need to support
> > single image for multiple socs in the long run.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-imx/mm-imx21.c                    |    3 +
> >  arch/arm/mach-imx/mm-imx25.c                    |   26 +++
> >  arch/arm/mach-imx/mm-imx27.c                    |    3 +
> >  arch/arm/mach-imx/mm-imx31.c                    |   24 +++
> >  arch/arm/mach-imx/mm-imx35.c                    |   44 +++++
> >  arch/arm/mach-mx5/mm.c                          |   23 +++
> >  arch/arm/plat-mxc/devices.c                     |   16 ++-
> >  arch/arm/plat-mxc/devices/platform-imx-dma.c    |  202 ++---------------------
> >  arch/arm/plat-mxc/include/mach/devices-common.h |    6 +
> >  9 files changed, 157 insertions(+), 190 deletions(-)
> > 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
