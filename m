From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 21 Jun 2013 13:22:10 +0900
Subject: [PATCH V9 1/4] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <CAK9yfHxCy0JcvsFHo8gERefdiZhxi1J8MNALe5-g6ooTGR-QjA@mail.gmail.com>
References: <002001ce6e2e$623d7970$26b86c50$@samsung.com>
 <CAK9yfHxCy0JcvsFHo8gERefdiZhxi1J8MNALe5-g6ooTGR-QjA@mail.gmail.com>
Message-ID: <002f01ce6e36$e61cf5b0$b256e110$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 21, 2013 1:11 PM, Sachin Kamat wrote:
> 
> Hi Jingoo,
> 
> Some small corrections inline.
> 
> On 21 June 2013 08:51, Jingoo Han <jg1.han@samsung.com> wrote:
> > Exynos5440 has a PCIe controller which can be used as Root Complex.
> > This driver supports a PCIe controller as Root Complex mode.
> >
> > Signed-off-by: Surendranath Gurivireddy Balla <suren.reddy@samsung.com>
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  .../devicetree/bindings/pci/designware-pcie.txt    |   73 ++
> >  drivers/pci/host/Kconfig                           |    9 +
> >  drivers/pci/host/Makefile                          |    1 +
> >  drivers/pci/host/pci-designware.c                  | 1057 ++++++++++++++++++++
> >  4 files changed, 1140 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
> >  create mode 100644 drivers/pci/host/pci-designware.c
> >
> > diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > new file mode 100644
> > index 0000000..e4681e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > @@ -0,0 +1,73 @@
> > +* Synopsis Designware PCIe interface
> > +
> > +Required properties:
> > +-compatible: should contain "snps,dw-pcie" to identify the
> > +       core, plus an identifier for the specific instance, such
> > +       as "samsung,exynos5440-pcie".
> > +-reg: base addresses and lengths of the pcie conteroller,
> 
> s/conteroller/controller

OK, I will fix it.

> 
> > +       the phy controller, additional register for the phy controller.
> > +- interrupts: interrupt values for level interrupt,
> > +       pulse interrupt, special interrupt.
> > +- clocks: from common clock binding: handle to pci clock.
> > +- clock-names: from common clock binding: Shall be "pcie", "pcie_bus".
> 
> s/Shall be .../should be "pcie" and "pcie_bus".

OK, I will fix it.

> 
> [snip]
> 
> > +
> > +MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
> > +MODULE_DESCRIPTION("Samsung PCIe host controller driver");
> > +MODULE_LICENSE("GPLv2");
> 
> I think this should be "GPL v2"  (with a space between GPL and v2).

OK, I will fix it.

Thank you for your caring and comment. :)
I will fix the typo and send PATCH v10 soon.


Best regards,
Jingoo Han

> 
> 
> --
> With warm regards,
> Sachin
