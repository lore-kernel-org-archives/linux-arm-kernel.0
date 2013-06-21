From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Jun 2013 13:40:08 +0800
Subject: [PATCH 2/3] ARM: i.MX6: add ethernet phy fixup for AR8031
In-Reply-To: <4263249.CSIcTzoYtY@kerker>
References: <1371742473-28026-1-git-send-email-s.hauer@pengutronix.de>
 <1371742473-28026-3-git-send-email-s.hauer@pengutronix.de>
 <4263249.CSIcTzoYtY@kerker>
Message-ID: <20130621054006.GB25633@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 07:13:41PM +0200, Michael Heimpold wrote:
> Hi,
> 
> Am Donnerstag, 20. Juni 2013, 17:34:32 schrieb Sascha Hauer:
> > The AR8031 is used on the i.MX6 based sabreSD, sabreauto and wandboard.
> > All need the same fixup, so add it for all i.MX6.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/mach-imx/mach-imx6q.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> > index e5f4a5b..69fae87 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -113,6 +113,29 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
> >  	return 0;
> >  }
> >  
> > +static int ar8031_phy_fixup(struct phy_device *dev)
> > +{
> > +	u16 val;
> > +
> > +	/* To enable AR8031 ouput a 125MHz clk from CLK_25M */
> 
> Typo? "ouput" -> "output"
> 
I fixed it up and applied the series.

Shawn
