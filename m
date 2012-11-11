From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 11 Nov 2012 10:09:28 +0530
Subject: [PATCH 06/14] ARM: SPEAr: DT: Modify DT bindings for STMMAC
In-Reply-To: <cover.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <ef582824e6b3453569ffa6951643fb159addec72.1352608333.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Deepak Sikri <deepak.sikri@st.com>

This patch modifies the DT bindings for the GMAC IP existings for the
SPEAr family. The DT bindings now additionally pass the phy mode as a
configuration parameter for the ethernet device.

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/spear1310-evb.dts | 1 +
 arch/arm/boot/dts/spear1310.dtsi    | 4 ++++
 arch/arm/boot/dts/spear1340-evb.dts | 1 +
 arch/arm/boot/dts/spear3xx.dtsi     | 1 +
 arch/arm/boot/dts/spear600.dtsi     | 1 +
 5 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index 79a1654..a4ff5cb 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -148,6 +148,7 @@
 		};
 
 		gmac0: eth at e2000000 {
+			phy-mode = "gmii";
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 1e18f31..bd6b64b 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -55,6 +55,7 @@
 			reg = <0x5c400000 0x8000>;
 			interrupts = <0 95 0x4>;
 			interrupt-names = "macirq";
+			phy-mode = "mii";
 			status = "disabled";
 		};
 
@@ -63,6 +64,7 @@
 			reg = <0x5c500000 0x8000>;
 			interrupts = <0 96 0x4>;
 			interrupt-names = "macirq";
+			phy-mode = "mii";
 			status = "disabled";
 		};
 
@@ -71,6 +73,7 @@
 			reg = <0x5c600000 0x8000>;
 			interrupts = <0 97 0x4>;
 			interrupt-names = "macirq";
+			phy-mode = "rmii";
 			status = "disabled";
 		};
 
@@ -79,6 +82,7 @@
 			reg = <0x5c700000 0x8000>;
 			interrupts = <0 98 0x4>;
 			interrupt-names = "macirq";
+			phy-mode = "rgmii";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index 4c5fa85..63c352f 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -156,6 +156,7 @@
 		};
 
 		gmac0: eth at e2000000 {
+			phy-mode = "rgmii";
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/spear3xx.dtsi b/arch/arm/boot/dts/spear3xx.dtsi
index b02721f..4946360 100644
--- a/arch/arm/boot/dts/spear3xx.dtsi
+++ b/arch/arm/boot/dts/spear3xx.dtsi
@@ -53,6 +53,7 @@
 			reg = <0xe0800000 0x8000>;
 			interrupts = <23 22>;
 			interrupt-names = "macirq", "eth_wake_irq";
+			phy-mode = "mii";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index a3c36e4..f74feea 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -59,6 +59,7 @@
 			interrupt-parent = <&vic1>;
 			interrupts = <24 23>;
 			interrupt-names = "macirq", "eth_wake_irq";
+			phy-mode = "gmii";
 			status = "disabled";
 		};
 
-- 
1.7.12.rc2.18.g61b472e
