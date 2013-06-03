From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  3 Jun 2013 14:42:25 +0100
Subject: [PATCH 01/21] ARM: ux500: Supply the PRCMU Clock node
In-Reply-To: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370266965-7901-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index fd5794a..6c445d5 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -243,7 +243,13 @@
 				interrupts = <21 0x4>, <22 0x4>;
 				interrupt-names = "IRQ_HOTMON_LOW", "IRQ_HOTMON_HIGH";
 				status = "disabled";
-			 };
+			};
+
+			clk: prcmu-clock {
+				compatible = "stericsson,u8500-clk";
+
+				#clock-cells = <1>;
+			};
 
 			db8500-prcmu-regulators {
 				compatible = "stericsson,db8500-prcmu-regulator";
-- 
1.7.10.4
