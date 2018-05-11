From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 11 May 2018 16:47:10 +0800
Subject: [PATCH] arm: dts: imx53: Fix LDB OF graph warning
In-Reply-To: <1525788997.18091.5.camel@pengutronix.de>
References: <20180508135930.5768-1-robh@kernel.org>
 <20180508135930.5768-3-robh@kernel.org>
 <1525788997.18091.5.camel@pengutronix.de>
Message-ID: <20180511084708.GG26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2018 at 04:16:37PM +0200, Philipp Zabel wrote:
> On Tue, 2018-05-08 at 08:59 -0500, Rob Herring wrote:
> > Single child nodes in OF graph don't need an address and now dtc will
> > warn about this:
> > 
> > Warning (graph_child_address): /soc/aips at 50000000/ldb at 53fa8008/lvds-channel at 0: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
> > 
> > Since the LDB should always have an output port, fix the warning by
> > adding the output port, 2, to the DT.
> > 
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  arch/arm/boot/dts/imx53.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> > index 7d647d043f52..1cf2fc9d0a58 100644
> > --- a/arch/arm/boot/dts/imx53.dtsi
> > +++ b/arch/arm/boot/dts/imx53.dtsi
> > @@ -488,6 +488,10 @@
> >  							remote-endpoint = <&ipu_di0_lvds0>;
> >  						};
> >  					};
> > +
> > +					port at 2 {
> > +						reg = <2>;
> > +					};
> 
> Now that the reg property of port at 2 is added in the .dtsi, it could be
> removed from the one .dts files that use it:
> 
> ----------8<----------
> --- a/arch/arm/boot/dts/imx53-ppd.dts
> +++ b/arch/arm/boot/dts/imx53-ppd.dts
> @@ -559,8 +559,6 @@
>                 status = "okay";
>  
>                 port at 2 {
> -                       reg = <2>;
> -
>                         lvds0_out: endpoint {
>                                 remote-endpoint = <&panel_in_lvds0>;
>                         };

I incorporate the change and applied patch.  Thanks.

Shawn
