From: anders.berg@avagotech.com (Anders Berg)
Date: Fri, 23 May 2014 11:08:39 +0200
Subject: [PATCH v4 5/5] ARM: dts: axxia: Add reset controller
In-Reply-To: <cover.1400834521.git.anders.berg@avagotech.com>
References: <cover.1400834521.git.anders.berg@avagotech.com>
Message-ID: <0f4c77059d58b463781a37d66a703f1cf2d7ed96.1400834521.git.anders.berg@avagotech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anders Berg <anders.berg@lsi.com>

Add the reset controller to the AXM5xx device tree.

Signed-off-by: Anders Berg <anders.berg@lsi.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/axm55xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
index 3fbd83c..ea288f0 100644
--- a/arch/arm/boot/dts/axm55xx.dtsi
+++ b/arch/arm/boot/dts/axm55xx.dtsi
@@ -101,6 +101,11 @@
 			reg = <0x20 0x10030000 0 0x2000>;
 		};
 
+		reset: reset at 2010031000 {
+			compatible = "lsi,axm55xx-reset";
+			syscon = <&syscon>;
+		};
+
 		amba {
 			compatible = "arm,amba-bus";
 			#address-cells = <2>;
-- 
1.8.3.2
