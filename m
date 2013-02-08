From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 8 Feb 2013 15:36:40 +0200
Subject: [PATCH v6 08/10] ARM: dt: Add references to tegra_car clocks
In-Reply-To: <1360330602-30472-1-git-send-email-pdeschrijver@nvidia.com>
References: <1360330602-30472-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1360330602-30472-9-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add references to tegra_car clocks for the basic device nodes.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 96a8235..6b0a01e 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -24,10 +24,11 @@
 			      0 42 0x04
 			      0 121 0x04
 			      0 122 0x04>;
+		clocks = <&tegra_car 5>;
 	};
 
 	tegra_car: clock {
-		compatible = "nvidia,tegra114-car, nvidia,tegra30-car";
+		compatible = "nvidia,tegra114-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
 	};
@@ -43,6 +44,7 @@
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 6>;
 	};
 
 	serial at 70006040 {
@@ -51,6 +53,7 @@
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 192>;
 	};
 
 	serial at 70006200 {
@@ -59,6 +62,7 @@
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 55>;
 	};
 
 	serial at 70006300 {
@@ -67,12 +71,14 @@
 		reg-shift = <2>;
 		interrupts = <0 90 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 65>;
 	};
 
 	rtc {
 		compatible = "nvidia,tegra114-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <0 2 0x04>;
+		clocks = <&tegra_car 4>;
 	};
 
 	pmc {
-- 
1.7.1
