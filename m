From: baolin.wang@linaro.org (Baolin Wang)
Date: Wed, 28 Feb 2018 18:47:07 +0800
Subject: [RESEND PATCH 4/7] arm64: dts: Add timer node for Spreadtrum SC9860
In-Reply-To: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
References: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
Message-ID: <d885b062dc077ca315d894a748d21cc977b4fee1.1519814593.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will use one always-on timer to be the broadcast device, thus add
the timer device node for Spreadtrum SC9860 platform.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 23cedbd..3dc6389 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -122,6 +122,13 @@
 				#size-cells = <0>;
 			};
 
+			timer at 40050000 {
+				compatible = "sprd,sc9860-timer";
+				reg = <0 0x40050000 0 0x20>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_32k>;
+			};
+
 			hwlock: hwspinlock at 40500000 {
 				compatible = "sprd,hwspinlock-r3p0";
 				reg = <0 0x40500000 0 0x1000>;
-- 
1.7.9.5
