From: mporter@ti.com (Matt Porter)
Date: Wed, 6 Mar 2013 09:01:30 -0500
Subject: [PATCH v8 6/9] ARM: dts: add AM33XX EDMA support
In-Reply-To: <a02b3a2e7dff42b0814bb6fa603068ba@DFLE73.ent.ti.com>
References: <1362516795-6346-1-git-send-email-mporter@ti.com>
 <1362516795-6346-7-git-send-email-mporter@ti.com>
 <a02b3a2e7dff42b0814bb6fa603068ba@DFLE73.ent.ti.com>
Message-ID: <20130306140130.GL6209@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 04:19:58AM +0000, Kumar, Anil wrote:
> Hi,
> 
> On Wed, Mar 06, 2013 at 02:23:12, Porter, Matt wrote:
> > Adds AM33XX EDMA support to the am33xx.dtsi as documented in
> > Documentation/devicetree/bindings/dma/ti-edma.txt
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> > ---
> >  arch/arm/boot/dts/am33xx.dtsi |   20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index 0957645..aaf44122 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -87,6 +87,26 @@
> >  			reg = <0x48200000 0x1000>;
> >  		};
> >  
> > +		edma: edma at 49000000 {
> > +			compatible = "ti,edma3";
> > +			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > +			reg =	<0x49000000 0x10000>,
> > +				<0x44e10f90 0x10>;
> > +			interrupt-parent = <&intc>;
> 
> Is it really need of "interrupt-parent = <&intc>" here ?
> as this property is already with root node.  
> I am taking reference of 3.9-rc1

You're correct. It's inherited from the parent node so I'll drop it out.
I also noted that the cpsw node has this wrong so I'll send a patch to
address that separately.

-Matt
