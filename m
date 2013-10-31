From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 31 Oct 2013 20:18:31 +0100
Subject: [PATCH v3 4/4] mvebu: Dove: Add clocks and DFS interrupt to cpu node
 in DT.
In-Reply-To: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
Message-ID: <1383247111-26834-4-git-send-email-andrew@lunn.ch>
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
index 1fd615d27532..e96d7a6a2fb8 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -19,6 +19,10 @@
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
1.8.4.rc3
