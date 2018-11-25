From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 19:19:01 -0200
Subject: [PATCH 07/13] ARM: dts: rv1108: Fix the timer mask
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
Message-ID: <20181125211907.9895-7-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As done in the Rockchip vendor tree and also on other
"arm,armv7-timer" instances, the correct GIC_CPU_MASK_SIMPLE mask
is 4 instead of 1.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index c7a26f82655b..7b331766120d 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -71,8 +71,8 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		clock-frequency = <24000000>;
 	};
 
-- 
2.19.1
