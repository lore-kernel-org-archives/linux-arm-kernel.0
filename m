From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 16 Apr 2018 10:40:04 +0800
Subject: [PATCH 2/2] arm64: dts: Add the rtc enable clock for watchdog
In-Reply-To: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
References: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
Message-ID: <bc450ea82fe7fbec7e7f74c5cdc8a37d202fe526.1523846102.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the rtc enable clock for watchdog controller to make it work well.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index bf7e70c..e9db910 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -214,8 +214,9 @@
 				reg = <0 0x40310000 0 0x1000>;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 				timeout-sec = <12>;
-				clock-names = "enable";
-				clocks = <&aon_gate CLK_APCPU_WDG_EB>;
+				clock-names = "enable", "rtc_enable";
+				clocks = <&aon_gate CLK_APCPU_WDG_EB>,
+				       <&aon_gate CLK_AP_WDG_RTC_EB>;
 			};
 		};
 
-- 
1.7.9.5
