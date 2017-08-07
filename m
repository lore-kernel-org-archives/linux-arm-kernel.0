From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 16:13:25 +0800
Subject: [PATCH 7/7] arm64: dts: hi3660: Reset the mmc hosts
In-Reply-To: <20170807081325.11406-1-guodong.xu@linaro.org>
References: <20170807081325.11406-1-guodong.xu@linaro.org>
Message-ID: <20170807081325.11406-8-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset-names = "reset" into mmc nodes.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 5fd5686..41841f7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -909,6 +909,7 @@
 			clock-names = "ciu", "biu";
 			clock-frequency = <3200000>;
 			resets = <&crg_rst 0x94 18>;
+			reset-names = "reset";
 			cd-gpios = <&gpio25 3 0>;
 			hisilicon,peripheral-syscon = <&sctrl>;
 			pinctrl-names = "default";
@@ -938,6 +939,7 @@
 				 <&crg_ctrl HI3660_HCLK_GATE_SDIO0>;
 			clock-names = "ciu", "biu";
 			resets = <&crg_rst 0x94 20>;
+			reset-names = "reset";
 			card-detect-delay = <200>;
 			supports-highspeed;
 			keep-power-in-suspend;
-- 
2.10.2
