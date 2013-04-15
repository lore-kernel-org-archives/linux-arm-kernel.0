From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Apr 2013 11:49:40 -0400
Subject: [PATCHv3 01/10] pci: mvebu: enable driver usage on Kirkwood
In-Reply-To: <CAErSpo5unBoJG=TEPjwHsiXPD_1T-QPDwLznUq_8sRSudQQqEA@mail.gmail.com>
References: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365865005-26653-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo5unBoJG=TEPjwHsiXPD_1T-QPDwLznUq_8sRSudQQqEA@mail.gmail.com>
Message-ID: <20130415154940.GG28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 09:11:02AM -0600, Bjorn Helgaas wrote:
> On Sat, Apr 13, 2013 at 8:56 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > We allow the pci-mvebu driver to be compiled on the Kirkwood platform,
> > and add the 'marvell,kirkwood-pcie' as a compatible string supported
> > by the driver.
> >
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I assume you'll merge this via some tree other than mine.

If you don't mind, it'll prevent us from having a nasty cross-tree
dependency and merge-ordering.  Any conflicts should be trivial.

thx,

Jason.

> > ---
> >  .../devicetree/bindings/pci/mvebu-pci.txt          |    1 +
> >  drivers/pci/host/Kconfig                           |    2 +-
> >  drivers/pci/host/pci-mvebu.c                       |    1 +
> >  3 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> > index eb69d92..f8d4058 100644
> > --- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> > @@ -4,6 +4,7 @@ Mandatory properties:
> >  - compatible: one of the following values:
> >      marvell,armada-370-pcie
> >      marvell,armada-xp-pcie
> > +    marvell,kirkwood-pcie
> >  - #address-cells, set to <3>
> >  - #size-cells, set to <2>
> >  - #interrupt-cells, set to <1>
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index 6918fbc..1f1d67f 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -3,6 +3,6 @@ menu "PCI host controller drivers"
> >
> >  config PCI_MVEBU
> >         bool "Marvell EBU PCIe controller"
> > -       depends on ARCH_MVEBU
> > +       depends on ARCH_MVEBU || ARCH_KIRKWOOD
> >
> >  endmenu
> > diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> > index 9c15a25..a083d19 100644
> > --- a/drivers/pci/host/pci-mvebu.c
> > +++ b/drivers/pci/host/pci-mvebu.c
> > @@ -853,6 +853,7 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
> >  static const struct of_device_id mvebu_pcie_of_match_table[] = {
> >         { .compatible = "marvell,armada-xp-pcie", },
> >         { .compatible = "marvell,armada-370-pcie", },
> > +       { .compatible = "marvell,kirkwood-pcie", },
> >         {},
> >  };
> >  MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
> > --
> > 1.7.9.5
> >
