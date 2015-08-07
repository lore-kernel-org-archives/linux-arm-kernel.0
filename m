From: Yuantian.Tang@freescale.com (Yuantian.Tang at freescale.com)
Date: Fri, 7 Aug 2015 15:38:31 +0800
Subject: [PATCH] arm: ls1021a: added SATA node in dts
Message-ID: <1438933111-39418-1-git-send-email-Yuantian.Tang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Added SATA device node and enabled AHCI config by default.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
depends on patch:
https://patchwork.kernel.org/patch/6851311/

 arch/arm/boot/dts/ls1021a.dtsi     | 7 +++++++
 arch/arm/configs/ls1021a_defconfig | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..1ee2a79 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -139,6 +139,13 @@
 			status = "disabled";
 		};
 
+		sata: sata at 3200000 {
+			compatible = "fsl,qoriq-ahci";
+			reg = <0x0 0x3200000 0x0 0x10000>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+		};
+
 		scfg: scfg at 1570000 {
 			compatible = "fsl,ls1021a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
diff --git a/arch/arm/configs/ls1021a_defconfig b/arch/arm/configs/ls1021a_defconfig
index 079c48f..f502910 100644
--- a/arch/arm/configs/ls1021a_defconfig
+++ b/arch/arm/configs/ls1021a_defconfig
@@ -70,6 +70,8 @@ CONFIG_BLK_DEV_RAM_SIZE=256000
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_VITESSE_PHY=y
-- 
2.1.0.27.g96db324
