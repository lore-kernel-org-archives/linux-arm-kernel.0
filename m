From: cinifr@gmail.com (Fan Rong)
Date: Tue,  1 Oct 2013 23:42:24 +0800
Subject: [Add SMP support for Allwinner A20: PATCH V4 2/3] Add cpuconfig nodes
 in dts for smp configure.
In-Reply-To: <1380642145-17295-1-git-send-email-cinifr@gmail.com>
References: <1380642145-17295-1-git-send-email-cinifr@gmail.com>
Message-ID: <1380642145-17295-3-git-send-email-cinifr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fan Rong <cinifr@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 999ff45..e1bff17 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -167,6 +167,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		cpuconfig: cpuconfig at 01c25c00 {
+			compatible = "allwinner,sun7i-a20-cpuconfig";
+			reg = <0x01c25c00 0x400>;
+		};
+
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
-- 
1.8.1.2
