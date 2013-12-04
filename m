From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  4 Dec 2013 15:17:21 +0100
Subject: [PATCH v4 4/4] mvebu: Dove: Add clocks and DFS interrupt to cpu node
 in DT.
In-Reply-To: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
Message-ID: <1386166641-7567-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dove-cpufreq driver needs access to the DDR and CPU clock.  There
is also an interrupt generated when the DFS hardware completes a
change of frequencey. Add these to the cpu node in DT.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/dove.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 4c8028513133..3842ba02dddf 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -22,6 +22,10 @@
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <0>;
+			clocks = <&core_clk 1>, <&core_clk 3>;
+			clock-names = "cpu_clk", "ddrclk";
+			interrupt-parent = <&pmu_intc>;
+			interrupts = <0>;
 		};
 	};
 
-- 
1.8.5
