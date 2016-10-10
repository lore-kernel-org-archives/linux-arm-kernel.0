From: atull@opensource.altera.com (atull)
Date: Mon, 10 Oct 2016 13:45:26 -0500
Subject: [PATCH v19 03/12] add bindings document for altera freeze bridge
In-Reply-To: <20161008204946.GC11595@rob-hp-laptop>
References: <20160928182200.15800-1-atull@opensource.altera.com>
 <20160928182200.15800-4-atull@opensource.altera.com>
 <20161008204946.GC11595@rob-hp-laptop>
Message-ID: <alpine.DEB.2.02.1610101340230.28839@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 8 Oct 2016, Rob Herring wrote:

> On Wed, Sep 28, 2016 at 01:21:51PM -0500, Alan Tull wrote:
> > Add bindings document for the Altera Freeze Bridge.  A Freeze
> > Bridge is used to gate traffic to/from a region of a FPGA
> > such that that region can be reprogrammed.  The Freeze Bridge
> > exist in FPGA fabric that is not currently being reconfigured.
> > 
> > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> > Signed-off-by: Matthew Gerlach <mgerlach@opensource.altera.com>
> > ---
> > v19: Added in v19 of patchset, uses fpga image info struct
> > ---
> >  .../bindings/fpga/altera-freeze-bridge.txt         | 23 ++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> > new file mode 100644
> > index 0000000..97ecc11
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> > @@ -0,0 +1,23 @@
> > +Altera Freeze Bridge Controller Driver
> > +
> > +The Altera Freeze Bridge Controller manages one or more freeze bridges.
> > +The controller can freeze/disable the bridges which prevents signal
> > +changes from passing through the bridge.  The controller can also
> > +unfreeze/enable the bridges which allows traffic to pass through the
> > +bridge normally.
> > +
> > +Required properties:
> > +- compatible		: Should contain "altr,freeze-bridge-controller"
> 
> Only one version of the h/w?

The h/w has a version register.  Currently the driver reads
the reg and exits if rev != 2.  Future version support can be
keyed off this register.

> 
> > +- regs			: base address and size for freeze bridge module
> > +
> > +Optional properties:
> > +- bridge-enable		: 0 if driver should disable bridge at startup
> > +			  1 if driver should enable bridge at startup
> > +			  Default is to leave bridge in current state.
> > +
> > +Example:
> > +	freeze_controller at 100000450 {
> 
> Underscore...

Yes.

> 
> > +		compatible = "altr,freeze-bridge-controller";
> > +		regs = <0x1000 0x10>;
> > +		bridge-enable = <0>;
> > +	};
> > -- 
> > 2.9.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
