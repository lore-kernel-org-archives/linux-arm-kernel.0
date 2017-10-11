From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 11 Oct 2017 13:57:19 -0500
Subject: [PATCH 0/5] arm64: add ls1012a and ls1046a pcie support
In-Reply-To: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
References: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20171011185719.GL25517@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 05:26:53PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch set adds ls1012a MSI and PCIe support, including driver
> and device tree nodes. The ls1046a's MSI support patch and PCIe
> driver patch has been applied, so only adds the PCIe device tree
> nodes.
> 
> Hou Zhiqiang (5):
>   irqchip/ls-scfg-msi: add LS1012a MSI support
>   arm64: dts: ls1012a: Add MSI controller DT node
>   PCI: layerscape: Add support for ls1012a
>   arm64: dts: ls1012a: Add PCIe controller DT node
>   arm64: dts: ls1046a: add PCIe controller DT nodes
> 
>  .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
>  .../devicetree/bindings/pci/layerscape-pci.txt     |  1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 31 +++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 75 ++++++++++++++++++++++
>  drivers/irqchip/irq-ls-scfg-msi.c                  |  1 +
>  drivers/pci/dwc/pci-layerscape.c                   |  1 +
>  6 files changed, 110 insertions(+)

I'm not 100% sure who should take these.  They trivially touch PCI and
I haven't seen anybody else respond, so I put them on
pci/host-layerscape with Rob's acks.

If somebody else wants to take them, just let me know and I'll drop
them.

They really should be acked by Minghuan or Mingkai, who are listed as
the maintainers of drivers/pci/dwc/pci-layerscape.c and are presumably
responsible for the related dtsi files, too.

Thomas, Jason, and Marc are listed as maintainers of
drivers/irqchip/irq-ls-scfg-msi.c.  It's a trivial change, but I added
them to the cc list.
