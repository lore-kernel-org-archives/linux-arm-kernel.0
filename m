From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 26 Sep 2018 21:33:44 +0900
Subject: [PATCH v2 1/2] dt-bindings: PCI: add UniPhier PCIe host
 controller description
In-Reply-To: <20180925205502.GA12949@bogus>
References: <1536226832-5089-2-git-send-email-hayashi.kunihiko@socionext.com>
 <20180925205502.GA12949@bogus>
Message-ID: <20180926213343.A4B8.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, 25 Sep 2018 15:55:02 -0500 <robh@kernel.org> wrote:

> On Thu, Sep 06, 2018 at 06:40:31PM +0900, Kunihiko Hayashi wrote:
> > Add DT bindings for PCIe controller implemented in UniPhier SoCs when
> > configured in Root Complex (host) mode. This controller is based on
> > the DesignWare PCIe core.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../devicetree/bindings/pci/uniphier-pcie.txt      | 78 ++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > new file mode 100644
> > index 0000000..a34e167
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > @@ -0,0 +1,78 @@
> > +Socionext UniPhier PCIe host controller bindings
> > +
> > +This describes the devicetree bindings for PCIe host controller implemented
> > +on Socionext UniPhier SoCs.
> > +
> > +UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
> > +It shares common functions with the PCIe DesignWare core driver and inherits
> > +common properties defined in
> > +Documentation/devicetree/bindings/pci/designware-pcie.txt.
> > +
> > +Required properties:
> > +- compatible: Should be "socionext,uniphier-pcie".
> > +- reg: Specifies offset and length of the register set for the device.
> > +	According to the reg-names, appropriate register sets are required.
> > +- reg-names: Must include the following entries:
> > +    "dbi"    - controller configuration registers
> > +    "link"   - SoC-specific glue layer registers
> > +    "config" - PCIe configuration space
> > +- clocks: A phandle to the clock gate for PCIe glue layer including
> > +	the host controller.
> > +- resets: A phandle to the reset line for PCIe glue layer including
> > +	the host controller.
> > +- interrupts: A list of interrupt specifiers. According to the
> > +	interrupt-names, appropriate interrupts are required.
> > +- interrupt-names: Must include the following entries:
> > +    "dma"    - DMA interrupt
> > +    "msi"    - MSI interrupt
> > +    "intx"   - Legacy INTA/B/C/D interrupt
> > +
> > +Optional properties:
> > +- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
> > +	phys are required.
> > +- phy-names: Must be "pcie-phy".
> > +
> > +Required sub-node:
> > +- interrupt-controller: Specifies interrupt controller for legacy PCI
> > +	interrupts. The node name isn't important.
> 
> No, it is important.
> 
> With that sentence removed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I was wrong. the node name is important to express its role.
I'll remove that sentence in next.

Thank you,

---
Best Regards,
Kunihiko Hayashi
