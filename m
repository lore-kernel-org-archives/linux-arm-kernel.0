From: m.purski@samsung.com (Maciej Purski)
Date: Thu, 10 Aug 2017 15:25:30 +0200
Subject: [PATCH 2/2] arm64: dts: exynos: add extcon phandle
In-Reply-To: <1502371530-32260-1-git-send-email-m.purski@samsung.com>
References: <1502371530-32260-1-git-send-email-m.purski@samsung.com>
 <CGME20170810132610eucas1p2faf93c6d314ea49ccd8f541aeb07db18@eucas1p2.samsung.com>
Message-ID: <1502371530-32260-3-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sii8620 driver can now use extcon in order to switch on and off
the device.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 0943dec..ed991b3 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -784,6 +784,7 @@
 		reset-gpios = <&gpv7 0 GPIO_ACTIVE_LOW>;
 		clocks = <&pmu_system_controller 0>;
 		clock-names = "xtal";
+		extcon = <&muic>;
 
 		port {
 			mhl_to_hdmi: endpoint {
-- 
2.7.4
