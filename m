From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Jul 2014 15:32:16 +0800
Subject: [PATCH 4/5] ARM: dts: sun8i: add rtc device node
In-Reply-To: <1405323137-24287-1-git-send-email-wens@csie.org>
References: <1405323137-24287-1-git-send-email-wens@csie.org>
Message-ID: <1405323137-24287-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun8i shares the same rtc hardware as sun6i. Now that we have a driver
for it, add a device node to the DTSI for it so we can use it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 54ac0787..e0d1048 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -285,6 +285,12 @@
 			interrupts = <1 9 0xf04>;
 		};
 
+		rtc: rtc at 01f00000 {
+			compatible = "allwinner,sun6i-a31-rtc";
+			reg = <0x01f00000 0x54>;
+			interrupts = <0 40 4>;
+		};
+
 		prcm at 01f01400 {
 			compatible = "allwinner,sun8i-a23-prcm";
 			reg = <0x01f01400 0x200>;
-- 
2.0.1
