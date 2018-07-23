From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 23 Jul 2018 14:10:18 +0800
Subject: [PATCH 3/5] arm64: dts: sprd: Add SC27XX eFuse device
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
Message-ID: <9cfac30ae483e1ee1d7e3519b542d50a583f0b8d.1531881619.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the eFuse device node for Spreadtrum SC27XX PMICs.
The SC27XX eFuse contains 32 blocks and each block's data width is
16 bits.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 650bd68..fc68076 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -57,6 +57,14 @@
 			#interrupt-cells = <2>;
 		};
 
+		efuse at 380 {
+			compatible = "sprd,sc27xx-efuse", "sprd,sc2731-efuse";
+			reg = <0x380>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			hwlocks = <&hwlock 12>;
+		};
+
 		vibrator at ec8 {
 			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
 			reg = <0xec8>;
-- 
1.7.9.5
