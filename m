From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 15 May 2015 07:39:47 +0000
Subject: [PATCH 2/2 V3] ARM: dts: atlas7: add fixed frequency clocks in car
 node
In-Reply-To: <1431675587-8637-1-git-send-email-21cnbao@gmail.com>
References: <1431675587-8637-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1431675587-8637-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <Guo.Zeng@csr.com>

This patch adds the fixed clocks of external crystal oscillators.

Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index a753178..7dad617 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -183,6 +183,18 @@
 				reg = <0x18620000 0x1000>;
 				#clock-cells = <1>;
 				#reset-cells = <1>;
+				xinw {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <32768>;
+					clock-output-names = "xinw";
+				};
+				xin {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <26000000>;
+					clock-output-names = "xin";
+				};
 			};
 		};
 
-- 
2.3.5
