From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 6 Nov 2018 11:36:42 +0530
Subject: [PATCH 5/6] pci: layerscape: Add the EP mode support.
In-Reply-To: <HE1PR04MB1497DABC689F9A4A97FD4DF0F5CA0@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-5-xiaowei.bao@nxp.com>
 <d9d07e05-556b-a56d-bb7f-eaec9fb739b8@ti.com>
 <HE1PR04MB1497DF7D9428A5C791CB6A03F5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <HE1PR04MB14979058170FA16A7465FF9EF5CD0@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <a85a6900-2478-0750-6f33-2e787cf80d1d@ti.com>
 <HE1PR04MB1497DF7378927C9BB5DF3E15F5CD0@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <8ec7f502-e058-2c28-9140-5d125e4af6ff@ti.com>
 <HE1PR04MB1497DABC689F9A4A97FD4DF0F5CA0@HE1PR04MB1497.eurprd04.prod.outlook.com>
Message-ID: <dfedeaec-9a3b-632e-af37-cb1963dcae7c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Removed Niklas as mails to him is bouncing)

Hi,

Please fix your email client. Refer Documentation/process/email-clients.rst

On 05/11/18 2:45 PM, Xiaowei Bao wrote:
> 
> 
> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com> 
> Sent: 2018?11?5? 16:57
> To: Xiaowei Bao <xiaowei.bao@nxp.com>; bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org; Leo Li <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com; arnd at arndb.de; gregkh at linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; kstewart at linuxfoundation.org; cyrille.pitchen at free-electrons.com; pombredanne at nexb.com; shawn.lin at rock-chips.com; niklas.cassel at axis.com; linux-pci at vger.kernel.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org
> Cc: Jiafei Pan <jiafei.pan@nxp.com>
> Subject: Re: [PATCH 5/6] pci: layerscape: Add the EP mode support.
> 
> Hi,
> 
> On 31/10/18 4:08 PM, Xiaowei Bao wrote:
>>
>>
>> -----Original Message-----
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>> Sent: 2018?10?31? 12:15
>> To: Xiaowei Bao <xiaowei.bao@nxp.com>; bhelgaas at google.com; 
>> robh+dt at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org; Leo Li 
>> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com; arnd at arndb.de; 
>> gregkh at linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; Mingkai 
>> Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; 
>> kstewart at linuxfoundation.org; cyrille.pitchen at free-electrons.com; 
>> pombredanne at nexb.com; shawn.lin at rock-chips.com; 
>> niklas.cassel at axis.com; linux-pci at vger.kernel.org; 
>> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; 
>> linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org
>> Cc: Jiafei Pan <jiafei.pan@nxp.com>
>> Subject: Re: [PATCH 5/6] pci: layerscape: Add the EP mode support.
>>
>> Hi,
>>
>> On 31/10/18 8:03 AM, Xiaowei Bao wrote:
>>>
>>>
>>> -----Original Message-----
>>> From: Xiaowei Bao
>>> Sent: 2018?10?26? 17:19
>>> To: 'Kishon Vijay Abraham I' <kishon@ti.com>; bhelgaas at google.com;
>>> robh+dt at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org; Leo Li
>>> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com; arnd at arndb.de; 
>>> gregkh at linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; 
>>> Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; 
>>> kstewart at linuxfoundation.org; cyrille.pitchen at free-electrons.com;
>>> pombredanne at nexb.com; shawn.lin at rock-chips.com; 
>>> niklas.cassel at axis.com; linux-pci at vger.kernel.org; 
>>> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; 
>>> linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org
>>> Cc: Jiafei Pan <jiafei.pan@nxp.com>
>>> Subject: RE: [PATCH 5/6] pci: layerscape: Add the EP mode support.
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>> Sent: 2018?10?26? 13:29
>>> To: Xiaowei Bao <xiaowei.bao@nxp.com>; bhelgaas at google.com;
>>> robh+dt at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org; Leo Li
>>> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com; arnd at arndb.de; 
>>> gregkh at linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; 
>>> Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; 
>>> kstewart at linuxfoundation.org; cyrille.pitchen at free-electrons.com;
>>> pombredanne at nexb.com; shawn.lin at rock-chips.com; 
>>> niklas.cassel at axis.com; linux-pci at vger.kernel.org; 
>>> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; 
>>> linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org
>>> Subject: Re: [PATCH 5/6] pci: layerscape: Add the EP mode support.
>>>
>>> Hi,
>>>
>>> On Thursday 25 October 2018 04:39 PM, Xiaowei Bao wrote:
>>>> Add the PCIe EP mode support for layerscape platform.
>>>>
>>>> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
>>>> ---
>>>>  drivers/pci/controller/dwc/Makefile            |    2 +-
>>>>  drivers/pci/controller/dwc/pci-layerscape-ep.c |  161
>>>> ++++++++++++++++++++++++
>>>>  2 files changed, 162 insertions(+), 1 deletions(-)  create mode
>>>> 100644 drivers/pci/controller/dwc/pci-layerscape-ep.c
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/Makefile
>>>> b/drivers/pci/controller/dwc/Makefile
>>>> index 5d2ce72..b26d617 100644
>>>> --- a/drivers/pci/controller/dwc/Makefile
>>>> +++ b/drivers/pci/controller/dwc/Makefile
>>>> @@ -8,7 +8,7 @@ obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>>>>  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>>>>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>>>>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
>>>> -obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>>>> +obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o 
>>>> +pci-layerscape-ep.o
>>>>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>>>>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>>>>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o diff --git 
>>>> a/drivers/pci/controller/dwc/pci-layerscape-ep.c
>>>> b/drivers/pci/controller/dwc/pci-layerscape-ep.c
>>>> new file mode 100644
>>>> index 0000000..3b33bbc
>>>> --- /dev/null
>>>> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
>>>> @@ -0,0 +1,161 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * PCIe controller EP driver for Freescale Layerscape SoCs
>>>> + *
>>>> + * Copyright (C) 2018 NXP Semiconductor.
>>>> + *
>>>> + * Author: Xiaowei Bao <xiaowei.bao@nxp.com>  */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/of_pci.h>
>>>> +#include <linux/of_platform.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/pci.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/resource.h>
>>>> +
>>>> +#include "pcie-designware.h"
>>>> +
>>>> +#define PCIE_DBI2_OFFSET		0x1000	/* DBI2 base address*/
>>>
>>> The base address should come from dt.
>>>> +
>>>> +struct ls_pcie_ep {
>>>> +	struct dw_pcie		*pci;
>>>> +};
>>>> +
>>>> +#define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
>>>> +
>>>> +static bool ls_pcie_is_bridge(struct ls_pcie_ep *pcie) {
>>>> +	struct dw_pcie *pci = pcie->pci;
>>>> +	u32 header_type;
>>>> +
>>>> +	header_type = ioread8(pci->dbi_base + PCI_HEADER_TYPE);
>>>> +	header_type &= 0x7f;
>>>> +
>>>> +	return header_type == PCI_HEADER_TYPE_BRIDGE; }
>>>> +
>>>> +static int ls_pcie_establish_link(struct dw_pcie *pci) {
>>>> +	return 0;
>>>> +}
>>>
>>> There should be some way by which EP should tell RC that it is not configured yet. Are there no bits to control LTSSM state initialization or Configuration retry status enabling?
>>> [Xiaowei Bao] There have not bits to control LTSSM state to tell the RC it is configured. The start link is auto completed.
>>> [Xiaowei Bao] Hi Kishon, is there any advice?
>>
>> If there is no HW support, I don't think anything could be done here. This could result in RC reading configuration space even before EP is fully initialized.
>> [Xiaowei Bao] The bootloader have initialized the EP device and set the config ready bit, and the kernel don't need to do anything.
> 
> What does bootloader initalize? The EP driver here will reinitialize everything right?
> [Xiaowei Bao] The bootloader initialize BAR size, outbound window, inbound window and set the config ready bit.

How will bootloader know the BAR size? The BAR size is based on the function
driver. How does bootloader configure the OB window? The OB window is
configured based on the size and address given by the host dynamically at runtime.

Thanks
Kishon
