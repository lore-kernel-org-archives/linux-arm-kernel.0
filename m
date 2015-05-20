From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 20 May 2015 08:50:34 +0000
Subject: [PATCH 2/2 v4] ARM: dts: atlas7: add fixed frequency clocks in car
 node
In-Reply-To: <1432111834-21178-1-git-send-email-21cnbao@gmail.com>
References: <1432111834-21178-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1432111834-21178-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <Guo.Zeng@csr.com>

This patch adds the fixed clocks of external crystal oscillators.

Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v4: move the clocks to be global;

 arch/arm/boot/dts/atlas7.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index a753178..1760dac 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -38,6 +38,24 @@
 		};
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		xinw {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "xinw";
+		};
+		xin {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+			clock-output-names = "xin";
+		};
+	};
+
 	noc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.9.1
