From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:17:02 +0100
Subject: [PATCH 14/33] ARM: ux500: Supply the RTC clock lookup to the DBX500 DT
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index a677521..edb53c63 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -73,6 +73,9 @@
 			compatible = "arm,rtc-pl031", "arm,primecell";
 			reg = <0x80154000 0x1000>;
 			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&rtc_clk>;
+			clock-names = "apb_pclk";
 		};
 
 		gpio0: gpio at 8012e000 {
-- 
1.7.10.4
