From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Jul 2014 15:32:15 +0800
Subject: [PATCH 3/5] ARM: dts: sun6i: add rtc device node
In-Reply-To: <1405323137-24287-1-git-send-email-wens@csie.org>
References: <1405323137-24287-1-git-send-email-wens@csie.org>
Message-ID: <1405323137-24287-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a driver for sun6i's rtc hardware, add a device node
for it so we can use it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a9dfa12..de351e1 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -691,6 +691,12 @@
 			interrupts = <1 9 0xf04>;
 		};
 
+		rtc: rtc at 01f00000 {
+			compatible = "allwinner,sun6i-a31-rtc";
+			reg = <0x01f00000 0x54>;
+			interrupts = <0 40 4>;
+		};
+
 		nmi_intc: interrupt-controller at 01f00c0c {
 			compatible = "allwinner,sun6i-a31-sc-nmi";
 			interrupt-controller;
-- 
2.0.1
