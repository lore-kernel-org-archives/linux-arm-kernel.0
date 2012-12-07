From: monstr@monstr.eu (Michal Simek)
Date: Fri, 07 Dec 2012 19:52:15 +0100
Subject: Sharing PCIE driver between Microblaze and Arm zynq
In-Reply-To: <20121207131706.EC9273E0B87@localhost>
References: <CAHTX3dLxbVxn+D+AV7L0VsGYFOjas3AJ_3M_xncVfxp02FCy=Q@mail.gmail.com>
 <20121207131706.EC9273E0B87@localhost>
Message-ID: <50C23ADF.3060607@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2012 02:17 PM, Grant Likely wrote:
> On Thu, 6 Dec 2012 15:23:14 +0100, Michal Simek <michal.simek@xilinx.com> wrote:
>> Hi guys,
>>
>> I have a question regarding to sharing generic OF pcie driver between
>> two architectures MB and ARM Zynq.
>> Is drivers/pci/pcie location good for it?
>> Make no sense to have the same driver in two locations.
>> Is using readl/writel IO functions in this driver the best option
>> which we can have?
>> Or is there any other recommendation?

Grant: What do you think about readl/iowrite usage in connection to PCI?

>> Also just want to check if it is correct to use pcie device_type.
>> The rest should be the same with pci description:
>> (http://devicetree.org/MPC5200:PCI#PCI_Address_Translation).
>
> Yes. device_type may be deprecated, but the PCI binding predates that.

If it is deprecated, there could be probably problem with early_init_dt_scan_memory()
which is checking memory device_type (drivers/of/fdt.c).


> PowerPC uses pcie in the device type. arch/powerpc/kernel/of_platform.c

ok. I see.

> Some of that powerpc DT PCI support code really should be made generic.

yep.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
