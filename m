From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 02 Apr 2015 17:34:32 +0900
Subject: [PATCH 1/6] arm64: dts: exynos: Add EHCI and OHCI dt node for
 Exynos5433
In-Reply-To: <1427963677-32661-1-git-send-email-cw00.choi@samsung.com>
References: <1427963677-32661-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1427963677-32661-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaewon Kim <jaewon02.kim@samsung.com>

This patch adds EHCI and OHCI device tree node
to usb USB2.0 Host and HSCI(High Speed Inter-Chip) function.

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index faea1c6..8a1875d 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -916,6 +916,49 @@
 			io-channel-ranges;
 			status = "disabled";
 		};
+
+		ehci: usb at 15510000 {
+			compatible = "samsung,exynos4210-ehci";
+			reg = <0x15510000 0x1000>;
+			interrupts = <0 230 0>;
+			clocks = <&cmu_fsys CLK_ACLK_USBHOST20>;
+			clock-names = "usbhost";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			port at 0 {
+				reg = <0>;
+				phys = <&usb2_phy 0>;
+				status = "disabled";
+			};
+			port at 1 {
+				reg = <1>;
+				phys = <&usb2_phy 1>;
+				status = "disabled";
+			};
+		};
+
+		ohci: usb at 15520000 {
+			compatible = "samsung,exynos4210-ohci";
+			reg = <0x15520000 0x1000>;
+			interrupts = <0 230 0>;
+			clocks = <&cmu_fsys CLK_ACLK_USBHOST20>;
+			clock-names = "usbhost";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2_phy: usb2phy at 15530000 {
+			compatible = "samsung,exynos5433-usb2-phy";
+			reg = <0x15530000 0x100>;
+			samsung,pmureg-phandle = <&pmu_system_controller>;
+			clocks = <&cmu_fsys CLK_ACLK_USBHOST20>, <&xxti>;
+			clock-names = "phy", "ref";
+			#phy-cells = <1>;
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
1.8.5.5
