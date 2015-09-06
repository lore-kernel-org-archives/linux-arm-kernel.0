From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 21:11:13 +0800
Subject: [PATCH v2 0/5] Add fec1 and fec2 support for i.MX7d sdb board
In-Reply-To: <1440386992-6775-1-git-send-email-b38611@freescale.com>
References: <1440386992-6775-1-git-send-email-b38611@freescale.com>
Message-ID: <20150906131113.GY30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 11:29:47AM +0800, Fugang Duan wrote:
> The patch series is to add fec support for i.MX7d sdb board. Since i.MX7d fec ip is
> the same as i.MX6SX, so there have no change for driver itself.
> 
> Patch#1: add bcm54220 PHY ID entry into brcmphy.h file.
> Patch#2: add new iomux-gpr file to define iomux-gpr register and field for i.MX7d.
> Patch#3: i.MX7d sdb board install bcm54220 phy, i.MX7d arm2 board install AR8031 phy.
>          For the two phys, there needs extra phy setting, so package the setting to fixup.
> Patch#4~6: Add fec dts node and pinmux setting in dts file.
> 
> Change:
> V2:
> 	* Remove patch#1 in V1 patch series. Move the sigle BCM54220 PHY ID define to machine file.
> 	* The current BCM54220 switch phy still use generic phy driver since broadcom phy driver don't
> 	  support the switch phy, there need effort to add the switch phy support. Once broadcom phy driver
> 	  will support the bcm54220 switch phy, we can add the special config to imx_v6_v7_defconfig.
> 
> 
> Fugang Duan (5):
>   ARM: imx7d: add imx7d iomux-gpr field define
>   ARM: imx: add enet init for i.MX7D platform
>   ARM: dts: imx: pinfunc: add GPIO1 pin define for i.MX7d
>   ARM: dts: imx7d: add fec1 and fec2 support for i.MX7d soc
>   ARM: dts: imx7d-sdb: add fec1 and fec2 support

When you submit i.MX platform patches, please remember to copy
kernel at pengutronix.de, which is listed in MAINTAINERS.

Shawn

> 
>  arch/arm/boot/dts/imx7d-pinfunc.h          | 115 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx7d-sdb.dts            |  76 ++++++++++++++++++-
>  arch/arm/boot/dts/imx7d.dtsi               |  36 +++++++++
>  arch/arm/mach-imx/mach-imx7d.c             |  76 ++++++++++++++++++-
>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h |  49 ++++++++++++
>  5 files changed, 349 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/mfd/syscon/imx7-iomuxc-gpr.h
> 
> -- 
> 1.9.1
> 
