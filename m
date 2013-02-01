From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 1 Feb 2013 12:18:37 +0200
Subject: [PATCH v5 08/10] ARM: dt: Add references to tegra_car clocks
In-Reply-To: <1359713962-16822-1-git-send-email-pdeschrijver@nvidia.com>
References: <1359713962-16822-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1359713962-16822-9-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add references to tegra_car clocks for the basic device nodes.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 96a8235..1dec620 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -27,7 +27,7 @@
 	};
 
 	tegra_car: clock {
-		compatible = "nvidia,tegra114-car, nvidia,tegra30-car";
+		compatible = "nvidia,tegra114-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
 	};
@@ -43,6 +43,7 @@
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 6>;
 	};
 
 	serial at 70006040 {
@@ -51,6 +52,7 @@
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 192>;
 	};
 
 	serial at 70006200 {
@@ -59,6 +61,7 @@
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 55>;
 	};
 
 	serial at 70006300 {
@@ -67,12 +70,14 @@
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
