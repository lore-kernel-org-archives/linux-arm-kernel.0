From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Mon,  7 Apr 2014 22:05:39 +0200
Subject: [PATCH] arm/omap4: add twd clock to DT
Message-ID: <1396901139-17268-1-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting Linux 3.14 on Pandaboard currently gets the following
message displayed:

smp_twd: clock not found -2

Define "mpu_periphclk" as the twd clock in omap4 dts to avoid this.

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/boot/dts/omap4.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..a7f1d3a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -62,6 +62,7 @@
 
 	local-timer at 48240600 {
 		compatible = "arm,cortex-a9-twd-timer";
+		clocks = <&mpu_periphclk>;
 		reg = <0x48240600 0x20>;
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
-- 
1.7.10.4
