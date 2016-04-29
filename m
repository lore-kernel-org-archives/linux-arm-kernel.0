From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 29 Apr 2016 14:06:34 +0530
Subject: [PATCH v2 0/5] Add SATA3 support for Broadcom NS2 SVK
In-Reply-To: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <57231D12.9080605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 28 March 2016 10:18 AM, Anup Patel wrote:
> The Broadcom NS2 SoC has a AHCI compliant SATA3 controller with
> two ports.
> 
> This patchset adds common Broadcom SATA3 PHY driver and related
> DT bindings document. It also adds appropriate DT nodes in NS2 DT.
> 
> The patchset is based on v4.6-rc1 tag and is available in branch
> ns2_sata3_v2 of https://github.com/Broadcom/arm64-linux.git
> 
> All patches have been tested on Broadcom NS2 SVK.

merged the first 3 patches to linux-phy tree.

Thanks
Kishon

> 
> Changes since v1:
>  - Added ACKed by Rob for DT bindings related patches
> 
> Anup Patel (5):
>   phy: Rename phy-brcmstb-sata driver to phy-brcm-sata driver
>   phy: Add support for NS2 SATA3 PHY in Broadcom SATA3 PHY driver
>   dt-bindings: phy: bindings document for common Broadcom SATA3 PHY
>     driver
>   dt-bindings: ata: add compatible string for iProc AHCI controller
>   arm64: dts: Add SATA3 AHCI and SATA3 PHY DT nodes for NS2
> 
>  .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
>  ...brcm,brcmstb-sata-phy.txt => brcm-sata-phy.txt} |  15 +-
>  arch/arm64/boot/dts/broadcom/ns2-svk.dts           |  12 +
>  arch/arm64/boot/dts/broadcom/ns2.dtsi              |  43 +++
>  drivers/phy/Kconfig                                |  18 +-
>  drivers/phy/Makefile                               |   2 +-
>  drivers/phy/phy-brcm-sata.c                        | 412 +++++++++++++++++++++
>  drivers/phy/phy-brcmstb-sata.c                     | 250 -------------
>  8 files changed, 487 insertions(+), 266 deletions(-)
>  rename Documentation/devicetree/bindings/phy/{brcm,brcmstb-sata-phy.txt => brcm-sata-phy.txt} (69%)
>  create mode 100644 drivers/phy/phy-brcm-sata.c
>  delete mode 100644 drivers/phy/phy-brcmstb-sata.c
> 
