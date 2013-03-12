From: mporter@ti.com (Matt Porter)
Date: Tue, 12 Mar 2013 12:23:10 -0400
Subject: [PATCH v9 5/9] dmaengine: edma: Add TI EDMA device tree binding
In-Reply-To: <1ced8cac7b9b41f596f0385e1f4f1f40@DFLE72.ent.ti.com>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
 <1362586540-10393-6-git-send-email-mporter@ti.com>
 <1ced8cac7b9b41f596f0385e1f4f1f40@DFLE72.ent.ti.com>
Message-ID: <20130312162310.GZ6209@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 06:53:03AM +0000, Sekhar Nori wrote:
> On 3/6/2013 9:45 PM, Matt Porter wrote:
> > The binding definition is based on the generic DMA controller
> > binding.
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> 
> Okay the bindings the documented after they are used leading to some
> confusion. This patch should be moved up the series. As I noted in my
> other e-mail, some of these bindings are not really hardware description
> and need to be re-looked.

Sure, I'll reorder it.

-Matt

> > ---
> >  Documentation/devicetree/bindings/dma/ti-edma.txt |   49 +++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> > new file mode 100644
> > index 0000000..075a60e3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> > @@ -0,0 +1,49 @@
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
> > 
