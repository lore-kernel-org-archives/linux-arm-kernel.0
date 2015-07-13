From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Jul 2015 21:31:38 +0800
Subject: [PATCH] dts: ls1021a: Add dts nodes for eTSEC0, eTSEC1 and eTSEC2
In-Reply-To: <DM2PR03MB414BBD64BBDEB22DB0981619C9C0@DM2PR03MB414.namprd03.prod.outlook.com>
References: <1435213498-21025-1-git-send-email-b18965@freescale.com>
 <20150712065101.GA14354@localhost>
 <DM2PR03MB414BBD64BBDEB22DB0981619C9C0@DM2PR03MB414.namprd03.prod.outlook.com>
Message-ID: <20150713133138.GO23464@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 10:47:49AM +0000, Manoil Claudiu wrote:
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > Sent: Sunday, July 12, 2015 9:51 AM
> > To: Wang Huan-B18965
> > Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> > kernel at vger.kernel.org; shawn.guo at linaro.org; Manoil Claudiu-B08782;
> > Wang Huan-B18965
> > Subject: Re: [PATCH] dts: ls1021a: Add dts nodes for eTSEC0, eTSEC1 and
> > eTSEC2
> > 
> > On Thu, Jun 25, 2015 at 02:24:58PM +0800, Alison Wang wrote:
> > > @@ -391,6 +394,85 @@
> > >  			reg = <0x0 0x2d24000 0x0 0x4000>;
> > >  		};
> > >
> > > +		enet0: ethernet at 2d10000 {
> > 
> > Most of the vendor specific properties below are undocumented bindings.
> > 
> > Shawn
> > 
> 
> Hi Shawn,
> 
> Please note that these properties (with only one exception) were accepted long time ago
> and are in use for the upstream powerpc platforms, eg:
> $ git grep fsl,num_rx_queues
> arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi:    fsl,num_rx_queues = <0x8>;
> arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi:    fsl,num_rx_queues = <0x8>;
> arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi:    fsl,num_rx_queues = <0x8>;
> drivers/net/ethernet/freescale/gianfar.c:                       ret = of_property_read_u32(np, "fsl,num_rx_queues",
> 
> So, I think the bindings documentation could be added in a separate, follow-up, patch.

I would like to see patch for bindings documentation before I apply this
one.

Shawn
