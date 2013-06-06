From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:17:04 +0100
Subject: [PATCH 16/33] ARM: ux500: Supply the TWD Timer clock lookup to the
 DBX500 DT
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 2027929..ed5655d 100644
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
1.7.10.4
