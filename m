From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 27 Aug 2016 15:55:41 +0800
Subject: [PATCH v2 5/8] ARM: dts: sun9i: cubieboard4: Declare AXP809 SW
 regulator as unused
In-Reply-To: <20160827075544.26316-1-wens@csie.org>
References: <20160827075544.26316-1-wens@csie.org>
Message-ID: <20160827075544.26316-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP809's SW (switch) regulator is unused on the Cubieboard 4.
Add an empty node for it so that the OS can generate constraints.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1: none
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 04b014603659..910b29f0f0b5 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -253,6 +253,10 @@
 			reg_rtc_ldo: rtc_ldo {
 				regulator-name = "vcc-rtc-vdd1v8-io";
 			};
+
+			sw {
+				/* unused */
+			};
 		};
 	};
 
-- 
2.9.3
