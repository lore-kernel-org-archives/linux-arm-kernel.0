From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Wed,  6 Jun 2018 11:34:41 +0200
Subject: [PATCH] ARM: dts: cygnus: Add HWRNG node
Message-ID: <20180606093441.16483-1-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cl?ment Peron <clement.peron@devialet.com>

There is a HWRNG in Broadcom Cygnus SoC, so enable it.

Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 1cee40ac4613..b7178e84d56d 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -452,6 +452,11 @@
 			status = "disabled";
 		};
 
+		hwrng: hwrng at 18032000 {
+			compatible = "brcm,iproc-rng200";
+			reg = <0x18032000 0x28>;
+		};
+
 		sdhci0: sdhci at 18041000 {
 			compatible = "brcm,sdhci-iproc-cygnus";
 			reg = <0x18041000 0x100>;
-- 
2.17.1
