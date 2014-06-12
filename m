From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 12 Jun 2014 17:38:40 +0800
Subject: [PATCH] ARM: dts: berlin2q.dtsi: set L2CC tag and data latency as 2
 cycles
Message-ID: <1402565920-5636-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all BG2Q SoCs, 2 cycles is the best/correct value

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 635a16a..3f95dc5 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -90,6 +90,8 @@
 			compatible = "arm,pl310-cache";
 			reg = <0xac0000 0x1000>;
 			cache-level = <2>;
+			arm,data-latency = <2 2 2>;
+			arm,tag-latency = <2 2 2>;
 		};
 
 		scu: snoop-control-unit at ad0000 {
-- 
2.0.0
