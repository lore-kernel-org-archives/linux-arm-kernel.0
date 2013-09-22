From: cinifr@gmail.com (Fan Rong)
Date: Sun, 22 Sep 2013 20:21:28 +0800
Subject: [PATCH V3: Add Smp support for Allwinner A20. 3/3] add arch count
 timer node in dts for Allwinner A20(sunxi 7i).
In-Reply-To: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
Message-ID: <1379852488-32147-4-git-send-email-cinifr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fan Rong <cinifr@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index f745e0b..76b8c3f 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -312,5 +312,15 @@
 			#interrupt-cells = <3>;
 			interrupts = <1 9 0xf04>;
 		};
+
+		timer {
+			compatible ="arm,armv7-timer";
+			interrupts = <1 13 0x308>,
+				     <1 14 0x308>,
+				     <1 11 0x308>,
+				     <1 10 0x308>;
+			clock-frequency = <24000000>;
+		};
+
 	};
 };
-- 
1.8.1.2
