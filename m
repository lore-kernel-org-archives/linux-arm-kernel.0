From: monstr@monstr.eu (Michal Simek)
Date: Wed, 30 Apr 2014 16:19:10 +0200
Subject: [PATCH v3] pcie: Add Xilinx PCIe Host Bridge IP driver
In-Reply-To: <1397561911-11647-1-git-send-email-sthokal@xilinx.com>
References: <1397561911-11647-1-git-send-email-sthokal@xilinx.com>
Message-ID: <5361065E.80304@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 04/15/2014 01:38 PM, Srikanth Thokala wrote:
> This is the driver for Xilinx AXI PCIe Host Bridge Soft IP
> 
> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
> ---
> Changes in v3:
> - Rebased on v3.15.0-rc1
> - Added support for interrupt-map DT functionality.
> - Removed map_irq() wrapper, instead using of_irq_parse_and_map_pci().
> - Modified resource mapping logic as per the series
>   "PCI: ARM: add support for generic PCI host controller"
> - Modified devicetree binding documentation to update with interrupt-
>   map properties.
> - Use devm calls wherever applicable.
> - Fixed minor comments from Jason
> - Thanks Jason for the review and suggestions.
> 
> Changes in v2:
> - Rebased on v3.14.0-rc8
> - Removed IP specific DT properties like include-rc, axibar-num etc.,
>   as suggested by Jason and Bjorn, Thanks
> ---
>  .../devicetree/bindings/pci/xilinx-pcie.txt        |   62 ++
>  drivers/pci/host/Kconfig                           |    7 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-xilinx.c                      |  999 ++++++++++++++++++++
>  4 files changed, 1069 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.txt
>  create mode 100644 drivers/pci/host/pci-xilinx.c

Any comment on this patch?

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/308d0c3a/attachment.sig>
