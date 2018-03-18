From: stefan@agner.ch (Stefan Agner)
Date: Sun, 18 Mar 2018 21:34:36 +0100
Subject: [PATCH 1/7] ARM: multi_v7_defconfig: add OCOTP driver for NXP SoCs
Message-ID: <20180318203442.19759-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable on-chip OTP NVMEM support for NXP i.MX and VF610 SoCs.
Since OTP values might be required by drivers required during
boot, make sure the driver is built-in (e.g. i.MX thermal
driver).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index da7387689b88..6395425854cc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -917,7 +917,9 @@ CONFIG_PHY_SAMSUNG_USB2=m
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_BRCM_SATA=y
 CONFIG_NVMEM=y
+CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_SUNXI_SID=y
+CONFIG_NVMEM_VF610_OCOTP=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_EFI_VARS=m
-- 
2.16.2
