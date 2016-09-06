From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Sep 2016 11:57:58 +0100
Subject: [PATCH 1/3] arm64: dts: berlin4ct: add missing unit name to /soc
 node
In-Reply-To: <20160906182048.222cec2f@xhacker>
References: <20160906085557.4019-1-jszhang@marvell.com>
 <20160906085557.4019-2-jszhang@marvell.com>
 <20160906102208.GB1425@leverpostej>
 <20160906182048.222cec2f@xhacker>
Message-ID: <20160906105758.GD1425@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 06:20:48PM +0800, Jisheng Zhang wrote:
> Hi Mark,
> 
> On Tue, 6 Sep 2016 11:22:08 +0100 Mark Rutland wrote:
> 
> > On Tue, Sep 06, 2016 at 04:55:55PM +0800, Jisheng Zhang wrote:
> > > This patch fixes the following DTC warning with W=1:
> > > 
> > > "Node /soc has a reg or ranges property, but no unit name"
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>  
> > 
> > The node is only compatible with simple-bus, and so shouldn't have a
> > reg.
> 
> IIUC, the warning is caused by "ranges = <0 0 0xf7000000 0x1000000>;"

Hmm.. I've rather confused by that warning. Per ePAPR and the
devicetree.org spec, the unit-addresss is meant to match the reg
property, and no mention is made of the ranges property. So I do not
think that it is necessary to require this.

That warning seems to have gone into DTC in commit c9d9121683b35281
("Warn on node name unit-address presence/absence mismatch").

Rob, Stephen, was there some discussion that prompted ranges requiring
a matching unit-address?

Thanks,
Mark.

> > Why not remove the reg?
> > 
> > Mark
> > 
> > > ---
> > >  arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > > index 099ad93..2d6f91f 100644
> > > --- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > > +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > > @@ -134,7 +134,7 @@
> > >  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> > >  	};
> > >  
> > > -	soc {
> > > +	soc at f7000000 {
> > >  		compatible = "simple-bus";
> > >  		#address-cells = <1>;
> > >  		#size-cells = <1>;
> > > -- 
> > > 2.9.3
> > >   
> 
