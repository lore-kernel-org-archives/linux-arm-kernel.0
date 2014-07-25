From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Jul 2014 17:13:25 +0800
Subject: [PATCH v3 3/6] ARM: dts: sun6i: add rtc device node
In-Reply-To: <1406279608-489-1-git-send-email-wens@csie.org>
References: <1406279608-489-1-git-send-email-wens@csie.org>
Message-ID: <1406279608-489-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a driver for sun6i's rtc hardware, add a device node
for it so we can use it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 44b07e5..6a16019 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -779,6 +779,12 @@
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
