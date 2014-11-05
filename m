From: monstr@monstr.eu (Michal Simek)
Date: Wed, 05 Nov 2014 09:36:28 +0100
Subject: [PATCH v3 1/2] ARM: zynq: Add OCM controller driver
In-Reply-To: <e65e39088e0f571ee4905172f2f6c84dbc037805.1412599051.git.michal.simek@xilinx.com>
References: <e65e39088e0f571ee4905172f2f6c84dbc037805.1412599051.git.michal.simek@xilinx.com>
Message-ID: <5459E18C.1030502@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

On 10/06/2014 02:38 PM, Michal Simek wrote:
> The driver provide memory allocator which can
> be used by others drivers to allocate memory inside OCM.
> All location for 64kB blocks are supported
> and driver is trying to allocate the largest continuous
> block of memory.
> 
> Checking mpcore addressing filterring is not done here
> but could be added in future.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v3:
> - Move OCM to drivers/soc
> - Update year
> - Extract DTS node to be able to apply it out of driver
> - Remove generic allocator enabling
> - Extract SLCR part
> - Use const in of_device_id
> - OCM->OCMC
> - Use ocmc-1.0 compatible string
> 
> Changes in v2:
> - Change compatibility string to be in xilinx format
> - Fix kernel-doc format
> 
> For everybody on-chip SRAM driver "mmio-sram"
> is missing parity IRQ handling not sure how to write
> in generic way and also the memory layout
> can be changed at run time (not currently supported by this driver)
> 
> smp-sram trampoline allocation can be used from mmio-sram
> and size allocated via DT but currently no reason for using
> it.
> 
> Creating mmio-sram node with setting at run time based on current setting
> is possible but it won't look good.
> One way how to do it is here
> "ARM: mvebu: Add quirk for i2c for the OpenBlocks AX3-4 board"
> (sha1: 85e618a1be2b2092318178d1d66bdad49cbbeeeb)
> but creating nodes at run-time or changing compact strings
> will be just more hacky code.
> 
> ---
>  .../bindings/arm/zynq/xlnx,zynq-ocmc.txt           |  17 ++
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/zynq/Makefile                          |   1 +
>  drivers/soc/zynq/zynq_ocmc.c                       | 246 +++++++++++++++++++++
>  4 files changed, 265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocmc.txt
>  create mode 100644 drivers/soc/zynq/Makefile
>  create mode 100644 drivers/soc/zynq/zynq_ocmc.c
> 

Can you please review this OCM patch?
I would like to move it when I know how I should handle that slcr connection
and reserving trampoline size.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/c1ea3b22/attachment.sig>
