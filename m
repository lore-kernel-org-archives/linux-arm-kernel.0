From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 18 Dec 2013 22:30:55 +0530
Subject: [PATCH 0/6] net: cpsw: Support for am335x chip MACIDs
In-Reply-To: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Message-ID: <52B1D4C7.6030004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 December 2013 10:17 PM, Markus Pargmann wrote:
> Hi,
>
> This series introduces a driver to read and use the MACIDs stored in the am335x
> control module. These are read-only registers for a unique MACID. At the moment
> the MACIDs are generated randomly or they are set by the bootloader.
>
> A device node is added in am33xx dtsi and used by the cpsw slaves in the bone
> board files.
>
> Regards,
>
> Markus
>
>
> Markus Pargmann (6):
>   DT doc: net: cpsw mac-address is optional
>   net: cpsw: header, Add missing include
>   net: cpsw: Add control-module macid driver
>   net: cpsw: Use cpsw-ctrl-macid driver
>   arm: dts: am33xx, Add device node for cpsw-ctrl-macid
>   arm: dts: am335x beagle bone use processor macids
>
>  .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  31 +++++
>  Documentation/devicetree/bindings/net/cpsw.txt     |   7 +-
>  arch/arm/boot/dts/am335x-bone.dts                  |   8 ++
>  arch/arm/boot/dts/am335x-boneblack.dts             |   8 ++
>  arch/arm/boot/dts/am33xx.dtsi                      |   7 ++
>  drivers/net/ethernet/ti/Kconfig                    |   8 ++
>  drivers/net/ethernet/ti/Makefile                   |   1 +
>  drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++++++++++++++
>  drivers/net/ethernet/ti/cpsw.c                     |  18 ++-
>  drivers/net/ethernet/ti/cpsw.h                     |   3 +
>  10 files changed, 224 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
>  create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c
>
Mac ID is to be filled by U-Boot and this kind of approach is already
rejected in linux-omap list.

If proper ethaddr/eth*addr is populated in U-boot environment variable
then mac-address dt property in ethernet* device nodes will be populated
before boot kernel in U-boot. So I don't think this patch series is
required.

Regards
Mugunthan V N
