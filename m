From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 07 Dec 2012 13:17:06 +0000
Subject: Sharing PCIE driver between Microblaze and Arm zynq
In-Reply-To: <CAHTX3dLxbVxn+D+AV7L0VsGYFOjas3AJ_3M_xncVfxp02FCy=Q@mail.gmail.com>
References: <CAHTX3dLxbVxn+D+AV7L0VsGYFOjas3AJ_3M_xncVfxp02FCy=Q@mail.gmail.com>
Message-ID: <20121207131706.EC9273E0B87@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Dec 2012 15:23:14 +0100, Michal Simek <michal.simek@xilinx.com> wrote:
> Hi guys,
> 
> I have a question regarding to sharing generic OF pcie driver between
> two architectures MB and ARM Zynq.
> Is drivers/pci/pcie location good for it?
> Make no sense to have the same driver in two locations.
> Is using readl/writel IO functions in this driver the best option
> which we can have?
> Or is there any other recommendation?
> 
> Also just want to check if it is correct to use pcie device_type.
> The rest should be the same with pci description:
> (http://devicetree.org/MPC5200:PCI#PCI_Address_Translation).

Yes. device_type may be deprecated, but the PCI binding predates that.
PowerPC uses pcie in the device type. arch/powerpc/kernel/of_platform.c

Some of that powerpc DT PCI support code really should be made generic.

g.
