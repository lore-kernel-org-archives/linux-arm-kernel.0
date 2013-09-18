From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:13 +0100
Subject: [PATCH 16/41] ARM: ux500: Supply the RTC clock lookup to the DBX500 DT
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 77ea36f..81cdfcf 100644
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
1.8.1.2
