From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jun 2018 15:24:19 +0200
Subject: [PATCH] arm64: dts: rockchip: generalize rk3399 #sound-dai-cells
Message-ID: <20180617132419.30688-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The soc spdif and i2s controllers always only have one compontent, so
always require #sound-dai-cells to be 0. Therefore there is no need to
duplicate this property in individual boards.

So move them to rk3399.dtsi.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts            | 3 ---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi              | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts | 2 --
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi          | 1 -
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                   | 3 +++
 5 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index d8a2f0ba4b2b..918944aafe83 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -492,19 +492,16 @@
 &i2s0 {
 	rockchip,playback-channels = <8>;
 	rockchip,capture-channels = <8>;
-	#sound-dai-cells = <0>;
 	status = "okay";
 };
 
 &i2s1 {
 	rockchip,playback-channels = <2>;
 	rockchip,capture-channels = <2>;
-	#sound-dai-cells = <0>;
 	status = "okay";
 };
 
 &i2s2 {
-	#sound-dai-cells = <0>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 111839a18465..0130b9f98c9d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -402,7 +402,6 @@
 	pinctrl-0 = <&i2s0_2ch_bus>;
 	rockchip,playback-channels = <2>;
 	rockchip,capture-channels = <2>;
-	#sound-dai-cells = <0>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
index 3768e1623e4f..fef2c0608999 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
@@ -149,7 +149,6 @@
 &i2s0 {
 	rockchip,playback-channels = <8>;
 	rockchip,capture-channels = <8>;
-	#sound-dai-cells = <0>;
 	status = "okay";
 };
 
@@ -198,6 +197,5 @@
 &spdif {
 	i2c-scl-rising-time-ns = <450>;
 	i2c-scl-falling-time-ns = <15>;
-	#sound-dai-cells = <0>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index 5dada565429c..36b60791c156 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -425,7 +425,6 @@
 };
 
 &i2s2 {
-	#sound-dai-cells = <0>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index ff63d9e93b4a..adb037cd80fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1483,6 +1483,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdif_bus>;
 		power-domains = <&power RK3399_PD_SDIOAUDIO>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -1498,6 +1499,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_8ch_bus>;
 		power-domains = <&power RK3399_PD_SDIOAUDIO>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -1512,6 +1514,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_2ch_bus>;
 		power-domains = <&power RK3399_PD_SDIOAUDIO>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
-- 
2.17.0
