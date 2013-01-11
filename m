From: mporter@ti.com (Matt Porter)
Date: Fri, 11 Jan 2013 09:30:07 -0500
Subject: [PATCH v4 05/14] dmaengine: edma: Add TI EDMA device tree binding
In-Reply-To: <06e6ba0bd8984e1797c84d2926584909@DFLE72.ent.ti.com>
References: <1357883330-5364-1-git-send-email-mporter@ti.com>
 <1357883330-5364-6-git-send-email-mporter@ti.com>
 <06e6ba0bd8984e1797c84d2926584909@DFLE72.ent.ti.com>
Message-ID: <20130111143007.GX14660@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 07:54:05AM +0000, Hebbar, Gururaja wrote:
> On Fri, Jan 11, 2013 at 11:18:41, Porter, Matt wrote:
> > The binding definition is based on the generic DMA controller
> > binding.
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> > ---
> >  Documentation/devicetree/bindings/dma/ti-edma.txt |   51 +++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> > new file mode 100644
> > index 0000000..3344345
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> > @@ -0,0 +1,51 @@
> > +TI EDMA
> > +
> > +Required properties:
> > +- compatible : "ti,edma3"
> > +- ti,hwmods: Name of the hwmods associated to the EDMA
> > +- ti,edma-regions: Number of regions
> > +- ti,edma-slots: Number of slots
> > +- ti,edma-queue-tc-map: List of transfer control to queue mappings
> > +- ti,edma-queue-priority-map: List of queue priority mappings
> > +- ti,edma-default-queue: Default queue value
> > +
> > +Optional properties:
> > +- ti,edma-reserved-channels: List of reserved channel regions
> > +- ti,edma-reserved-slots: List of reserved slot regions
> > +- ti,edma-xbar-event-map: Crossbar event to channel map
> > +
> > +Example:
> > +
> > +edma: edma at 49000000 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> 
> address-cells & size-cells are only required when current node is a parent 
> node & it has sibling/child nodes (that too if the child node uses "reg" 
> property).

Yes, agreed. I addressed this in the actual dts but failed to update the
binding itself. Will update.

> 
> > +	reg = <0x49000000 0x10000>;
> > +	interrupt-parent = <&intc>;
> > +	interrupts = <12 13 14>;
> > +	compatible = "ti,edma3";
> > +	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > +	#dma-cells = <1>;
> > +	dma-channels = <64>;
> > +	ti,edma-regions = <4>;
> > +	ti,edma-slots = <256>;
> > +	ti,edma-reserved-channels = <0  2
> > +				     14 2
> > +				     26 6
> > +				     48 4
> > +				     56 8>;
> > +	ti,edma-reserved-slots = <0  2
> > +				  14 2
> > +				  26 6
> > +				  48 4
> > +				  56 8
> > +				  64 127>;
> > +	ti,edma-queue-tc-map = <0 0
> > +				1 1
> > +				2 2>;
> > +	ti,edma-queue-priority-map = <0 0
> > +				      1 1
> > +				      2 2>;
> > +	ti,edma-default-queue = <0>;
> > +	ti,edma-xbar-event-map = <1 12
> > +				  2 13>;
> > +};
> > -- 
> > 1.7.9.5
> > 
> > _______________________________________________
> > Davinci-linux-open-source mailing list
> > Davinci-linux-open-source at linux.davincidsp.com
> > http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> > 
> 
> 
> Regards, 
> Gururaja
