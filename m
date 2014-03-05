From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 05 Mar 2014 10:37:24 +0100
Subject: [PATCH v5 4/5] ARM: dts: imx6sl: Add power-domain information
 to gpc node
In-Reply-To: <20140305070009.GK8784@S2101-09.ap.freescale.net>
References: <1393603427-6199-1-git-send-email-p.zabel@pengutronix.de>
 <1393603427-6199-5-git-send-email-p.zabel@pengutronix.de>
 <20140305070009.GK8784@S2101-09.ap.freescale.net>
Message-ID: <1394012244.16929.2.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 05.03.2014, 15:00 +0800 schrieb Shawn Guo:
> On Fri, Feb 28, 2014 at 05:03:46PM +0100, Philipp Zabel wrote:
> > The PGC that is part of GPC controls isolation and power sequencing of the
> > power domains. The PU power domain will be handled by the generic pm domain
> > framework. It needs a phandle to the PU regulator to turn off power when
> > the domain is disabled and a list of clocks to be enabled during powerup
> > for reset propagation.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > Changes since v4:
> >  - Use OF power domain bindings
> >  - Added reset clocks
> > ---
> >  arch/arm/boot/dts/imx6sl.dtsi | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> > index 28558f1..0e61262 100644
> > --- a/arch/arm/boot/dts/imx6sl.dtsi
> > +++ b/arch/arm/boot/dts/imx6sl.dtsi
> > @@ -529,9 +529,13 @@
> >  			};
> >  
> >  			gpc: gpc at 020dc000 {
> > -				compatible = "fsl,imx6sl-gpc", "fsl,imx6q-gpc";
> > +				compatible = "fsl,imx6sl-gpc";
> 
> This change will break function imx_gpc_init(), which looks up
> "fsl,imx6q-gpc" even on imx6sl.

Sorry, I'll drop this change.

regards
Philipp
