From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 May 2014 21:33:16 +0200
Subject: [PATCH 2/2] ARM: sunxi: Add clocks node to the CPU nodes
In-Reply-To: <1400700796-5763-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1400700796-5763-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1400700796-5763-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the clock will make the topology code work, and will remove the
following error at boot

[    0.097194] /cpus/cpu at 0 missing clock-frequency property
[    0.103657] /cpus/cpu at 1 missing clock-frequency property
[    0.110698] /cpus/cpu at 2 missing clock-frequency property
[    0.117132] /cpus/cpu at 3 missing clock-frequency property

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 4 ++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 4155fc43ecff..6814a1c4759b 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -34,24 +34,28 @@
 		cpu at 0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&cpu>;
 			reg = <0>;
 		};
 
 		cpu at 1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&cpu>;
 			reg = <1>;
 		};
 
 		cpu at 2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&cpu>;
 			reg = <2>;
 		};
 
 		cpu at 3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&cpu>;
 			reg = <3>;
 		};
 	};
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 385933bac114..8402f33158bf 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -35,12 +35,14 @@
 		cpu at 0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&cpu>;
 			reg = <0>;
 		};
 
 		cpu at 1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&cpu>;
 			reg = <1>;
 		};
 	};
-- 
1.9.3
