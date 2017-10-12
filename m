From: minghuan.lian@nxp.com (M.h. Lian)
Date: Thu, 12 Oct 2017 03:12:47 +0000
Subject: [PATCH 0/5] arm64: add ls1012a and ls1046a pcie support
In-Reply-To: <20171011185719.GL25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
 <20171011185719.GL25517@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <VI1PR04MB16157ABDE174A8DD1567173CE84B0@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

I greatly appreciate for your review and picking up them.

Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>


> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: Thursday, October 12, 2017 2:57 AM
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-
> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linuxppc-
> dev at lists.ozlabs.org; marc.zyngier at arm.com; robh+dt at kernel.org;
> mark.rutland at arm.com; bhelgaas at google.com; shawnguo at kernel.org;
> Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>; Roy
> Zang <roy.zang@nxp.com>; Thomas Gleixner <tglx@linutronix.de>; Jason
> Cooper <jason@lakedaemon.net>
> Subject: Re: [PATCH 0/5] arm64: add ls1012a and ls1046a pcie support
> 
> On Tue, Sep 19, 2017 at 05:26:53PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > This patch set adds ls1012a MSI and PCIe support, including driver and
> > device tree nodes. The ls1046a's MSI support patch and PCIe driver
> > patch has been applied, so only adds the PCIe device tree nodes.
> >
> > Hou Zhiqiang (5):
> >   irqchip/ls-scfg-msi: add LS1012a MSI support
> >   arm64: dts: ls1012a: Add MSI controller DT node
> >   PCI: layerscape: Add support for ls1012a
> >   arm64: dts: ls1012a: Add PCIe controller DT node
> >   arm64: dts: ls1046a: add PCIe controller DT nodes
> >
> >  .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
> >  .../devicetree/bindings/pci/layerscape-pci.txt     |  1 +
> >  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 31 +++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 75
> ++++++++++++++++++++++
> >  drivers/irqchip/irq-ls-scfg-msi.c                  |  1 +
> >  drivers/pci/dwc/pci-layerscape.c                   |  1 +
> >  6 files changed, 110 insertions(+)
> 
> I'm not 100% sure who should take these.  They trivially touch PCI and I haven't
> seen anybody else respond, so I put them on pci/host-layerscape with Rob's acks.
> 
> If somebody else wants to take them, just let me know and I'll drop them.
> 
> They really should be acked by Minghuan or Mingkai, who are listed as the
> maintainers of drivers/pci/dwc/pci-layerscape.c and are presumably responsible
> for the related dtsi files, too.
> 
> Thomas, Jason, and Marc are listed as maintainers of drivers/irqchip/irq-ls-scfg-
> msi.c.  It's a trivial change, but I added them to the cc list.
