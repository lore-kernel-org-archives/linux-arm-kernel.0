From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 8 May 2017 18:55:36 +0100
Subject: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
In-Reply-To: <1494261248.2322.21.camel@pengutronix.de>
References: <20170508150224.GA7458@collabora.com>
 <1494261248.2322.21.camel@pengutronix.de>
Message-ID: <20170508175536.GA3305@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 08, 2017 at 06:34:08PM +0200, Lucas Stach wrote:
> Am Montag, den 08.05.2017, 17:02 +0200 schrieb Peter Senna Tschudin:
> > Hello Kishon,
> > 
> > Our iMX6 hardware (imx6q-b850v3.dts) is not booting with latest
> > linux-next and I could bisect until:
> > 
> > commit 442ec4c04d1235f8c664a74004dae54a7a574d18
> > Author: Kishon Vijay Abraham I <kishon@ti.com>
> > Date:   Wed Feb 15 18:48:14 2017 +0530
> > 
> >     PCI: dwc: all: Split struct pcie_port into host-only and core structures
> > 
> > Which seem to be causing our issues. Our device (imx6q-b850v3.dts) boots
> > fine with 4.10, and also boots if we disable pcie with:
> 
> Are you sure about this bisect? It seems more likely that the secondary
> bus scanning goes wrong. It seems Lorenzo Pieralisi's cfg space
> non-posting patches landed in next, so the root cause of this might just
> be the driver hooking the wrong fault code now.
> 
> Async and synchronous aborts are different fault codes on ARM. Can you
> see of removing the "16 +" in hook_fault_code() in
> drivers/pci/dwc/pci-imx6.c fixes this issue?

You can also s/pci_remap_cfgspace/ioremap in pcie-designware-host.c
to see if my patches are the issue, it is quite a mechanical change.

Thanks,
Lorenzo
