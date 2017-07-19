From: yong.deng@magewell.com (Yong)
Date: Wed, 19 Jul 2017 09:22:49 +0800
Subject: [PATCH RFC 2/2] dt-bindings: add binding documentation for
 Allwinner CSI
In-Reply-To: <20170718115530.ssy7g5vv4siqnfpo@tarshish>
References: <1498561654-14658-1-git-send-email-yong.deng@magewell.com>
 <1498561654-14658-3-git-send-email-yong.deng@magewell.com>
 <20170718115530.ssy7g5vv4siqnfpo@tarshish>
Message-ID: <20170719092249.2fb6ec720ba1b194cea320c8@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jul 2017 14:55:30 +0300
Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Yong,
> 
> I am trying to get this driver working on the Olimex A33 OLinuXino. I didn't 
> get it working yet, but I had some progress. See the comment below on one 
> issue I encountered.
> 
> On Tue, Jun 27, 2017 at 07:07:34PM +0800, Yong Deng wrote:
> > Add binding documentation for Allwinner CSI.
> > 
> > Signed-off-by: Yong Deng <yong.deng@magewell.com>
> > ---
> >  .../devicetree/bindings/media/sunxi-csi.txt        | 51 ++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/sunxi-csi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/media/sunxi-csi.txt b/Documentation/devicetree/bindings/media/sunxi-csi.txt
> > new file mode 100644
> > index 0000000..770be0e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/sunxi-csi.txt
> > @@ -0,0 +1,51 @@
> > +Allwinner V3s Camera Sensor Interface
> > +------------------------------
> > +
> > +Required properties:
> > +  - compatible: value must be "allwinner,sun8i-v3s-csi"
> > +  - reg: base address and size of the memory-mapped region.
> > +  - interrupts: interrupt associated to this IP
> > +  - clocks: phandles to the clocks feeding the CSI
> > +    * ahb: the CSI interface clock
> > +    * mod: the CSI module clock
> > +    * ram: the CSI DRAM clock
> > +  - clock-names: the clock names mentioned above
> > +  - resets: phandles to the reset line driving the CSI
> > +
> > +- ports: A ports node with endpoint definitions as defined in
> > +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > +  first port should be the input endpoints, the second one the outputs
> > +
> > +Example:
> > +
> > +	csi1: csi at 01cb4000 {
> > +		compatible = "allwinner,sun8i-v3s-csi";
> > +		reg = <0x01cb4000 0x1000>;
> 
> You use platform_get_resource_byname() to get this IO resource. This requires 
> adding mandatory
> 
>   reg-names = "csi";
> 
> But is it actually needed? Wouldn't a simple platform_get_resource() be 
> enough?

You are right.
This will be fixed in the next version.
I am waiting for more comments for the sunxi-csi.h. It's pleasure if
you have any suggestions about it.
