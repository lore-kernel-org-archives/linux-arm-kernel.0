From: Minghuan.Lian@freescale.com (Minghuan.Lian at freescale.com)
Date: Fri, 5 Sep 2014 07:40:39 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDIvMl0gUENJOiBMYXllcnNjYXBlOiBBZGQgTGF5ZXJz?=
 =?gb2312?Q?cape_PCIe_driver?=
In-Reply-To: <CAOMZO5BtOO42sde_Eco2=p06WQsJn3+1J44k6i+Dg7qxOK8qdw@mail.gmail.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
 <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>,
 <CAOMZO5BtOO42sde_Eco2=p06WQsJn3+1J44k6i+Dg7qxOK8qdw@mail.gmail.com>
Message-ID: <1409931678166.54274@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

There are no same parts between Layerscape and imx6 except the same PCIe IP.
I think it is better Layerscape uses a separate file. 

Yes, I retrieve base and size from dtsi file, and then use them and defined PCIE_LS1021A_BASE to calculate controller index. Our SoC contains two PCI controllers.
I can remove  PCIE_LS1021A_BASE, but I must find a way to get controller index.
Because SCFG(The supplemental configuration unit, provides SoC specific configuration and status
registers for the device.) includes several separate register for PEX1 and PEX2. 
and I do not want to add several 'reg' entry to describe the SCFG PEX registers.

Thanks,
Minghaun 
________________________________________
???: Fabio Estevam <festevam@gmail.com>
????: 2014?9?5? 4:21
???: Lian Minghuan-B31939
??: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Zang Roy-R61911; Hu Mingkai-B21284; Wood Scott-B07421
??: Re: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver

On Thu, Sep 4, 2014 at 3:45 PM, Minghuan Lian
<Minghuan.Lian@freescale.com> wrote:
> Add support for Freescale Layerscape PCIe controller. This driver
> re-uses the designware core code.

It seems that this is the same IP as on mx6, right?

Is it possible to adapt drivers/pci/host/pci-imx6.c to work on Layerscape?

> +#define PCIE_LS1021A_BASE      0x3400000
> +#define PCIE_LS1021A_REG_SIZE  0x0100000

You should retrieve base and reg size from the dtsi file.
