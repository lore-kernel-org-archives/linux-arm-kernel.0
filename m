From: wolfgit@wiedmeyer.de (Wolfgang Wiedmeyer)
Date: Thu, 22 Sep 2016 18:48:35 +0200
Subject: [PATCH] ARM: dts: exynos: Add reboot reason support for Trats2
Message-ID: <1474562915-4319-1-git-send-email-wolfgit@wiedmeyer.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to reboot the device into recovery mode and into the download
mode of the bootloader.

Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 14 ++++++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi       |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 129e973..a38d1e3 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -1294,3 +1294,17 @@
 	vtmu-supply = <&ldo10_reg>;
 	status = "okay";
 };
+
+&pmu {
+	compatible = "syscon", "simple-mfd";
+
+	reboot-mode {
+		compatible = "syscon-reboot-mode";
+		offset = <0x80c>;
+
+		mode-normal	= <0x12345670>;
+		mode-bootloader	= <0x12345671>;
+		mode-download	= <0x12345671>;
+		mode-recovery	= <0x12345674>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c452499..b58c14e 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -179,7 +179,7 @@
 			ranges;
 			status = "disabled";
 
-			pmu at 10020000 {
+			pmu: pmu at 10020000 {
 				reg = <0x10020000 0x3000>;
 			};
 
-- 
Website: https://fossencdi.org
OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
Key download: https://wiedmeyer.de/keys/ww.asc
