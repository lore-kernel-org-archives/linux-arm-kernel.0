From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 23 Jul 2018 14:10:20 +0800
Subject: [PATCH 5/5] arm64: dts: sprd: Add one suspend timer
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
Message-ID: <daf81b1cc8dd6048a9fcb7682a5937b72eb46dfd.1531881619.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Spreadtrum platform, the current clocksource for timekeeping will be
stopped in suspend state, thus add one always-on timer to calculate the
suspend time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index e9db910..eb6be56 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -146,6 +146,12 @@
 				clocks = <&ext_32k>;
 			};
 
+			timer at 40050020 {
+				compatible = "sprd,sc9860-suspend-timer";
+				reg = <0 0x40050020 0 0x20>;
+				clocks = <&ext_32k>;
+			};
+
 			hwlock: hwspinlock at 40500000 {
 				compatible = "sprd,hwspinlock-r3p0";
 				reg = <0 0x40500000 0 0x1000>;
-- 
1.7.9.5
