From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:15 +0100
Subject: [PATCH 18/41] ARM: ux500: Supply the TWD Timer clock lookup to the
 DBX500 DT
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-19-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 9adc4e5..5c3ff94 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -71,6 +71,8 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xa0410600 0x20>;
 			interrupts = <1 13 0x304>; /* IRQ level high per-CPU */
+
+			clocks = <&smp_twd_clk>;
 		};
 
 		rtc at 80154000 {
-- 
1.8.1.2
