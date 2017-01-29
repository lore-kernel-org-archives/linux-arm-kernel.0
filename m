From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Sun, 29 Jan 2017 15:07:33 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb: set reset for ethernet
Message-ID: <ec31eddc-d286-d0bc-0bdb-ae9d5014d82e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset control for ethernet.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 39a774ad..753fddf6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -113,6 +113,8 @@
 		 <&clkc CLKID_FCLK_DIV2>,
 		 <&clkc CLKID_MPLL2>;
 	clock-names = "stmmaceth", "clkin0", "clkin1";
+	resets = <&reset RESET_ETHERNET>;
+	reset-names = "stmmaceth";
 };
 
 &aobus {
-- 
2.11.0
