From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 26 Apr 2014 08:52:12 +0400
Subject: [PATCH 7/8] ARM: dts: imx27: Trim node name for FEC
In-Reply-To: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
Message-ID: <1398487933-5683-7-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reduce node name for FEC. Otherwise, the name for PHY
is composed incorrectly.

Before:
fec 1002b000.ethernet eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=1002b000.etherne:00, irq=-1)

After:
fec 1002b000.fec eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=1002b000.fec-1:00, irq=-1)

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index a75555c..377339e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -497,7 +497,7 @@
 				clocks = <&clks 38>;
 			};
 
-			fec: ethernet at 1002b000 {
+			fec: fec at 1002b000 {
 				compatible = "fsl,imx27-fec";
 				reg = <0x1002b000 0x4000>;
 				interrupts = <50>;
-- 
1.8.3.2
