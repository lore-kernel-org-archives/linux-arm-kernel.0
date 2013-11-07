From: andrew@lunn.ch (Andrew Lunn)
Date: Thu,  7 Nov 2013 11:35:30 +0100
Subject: [RESEND PATCH v2 2/3] ARM: Dove: Add DT node for PMU interrupt
 controller.
In-Reply-To: <1383820531-4387-1-git-send-email-andrew@lunn.ch>
References: <1383820531-4387-1-git-send-email-andrew@lunn.ch>
Message-ID: <1383820531-4387-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate the PMU interrupt controller which Dove has.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/dove.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index cc279166646f..52b992a5c120 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -66,6 +66,15 @@
 			marvell,#interrupts = <5>;
 		};
 
+		pmu_intc: pmu-interrupt-ctrl at d0050 {
+			compatible = "marvell,dove-pmu-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0xd0050 0x8>;
+			interrupts = <33>;
+			marvell,#interrupts = <7>;
+		};
+
 		core_clk: core-clocks at d0214 {
 			compatible = "marvell,dove-core-clock";
 			reg = <0xd0214 0x4>;
-- 
1.8.4.rc3
