From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:16 +0100
Subject: [PATCH 19/41] ARM: ux500: Add a DT node for the Nomadik System Timer
 (MTU0)
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-20-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MTU0 is required for full booting of the system. The driver has
been previously DT:ed and is in use on the Nomadik platform, but we
also need to enable it on ux500 based systems.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 5c3ff94..0d2d5d0 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -43,6 +43,7 @@
 			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+
 		clocks {
 			compatible = "stericsson,u8500-clks";
 
@@ -67,6 +68,16 @@
 			};
 		};
 
+		mtu at a03c6000 {
+			/* Nomadik System Timer */
+			compatible = "st,nomadik-mtu";
+			reg = <0xa03c6000 0x1000>;
+			interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&prcmu_clk PRCMU_TIMCLK>, <&prcc_pclk 6 6>;
+			clock-names = "timclk", "apb_pclk";
+		};
+
 		timer at a0410600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xa0410600 0x20>;
-- 
1.8.1.2
