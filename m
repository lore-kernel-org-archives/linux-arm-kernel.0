From: pekon@ti.com (Gupta, Pekon)
Date: Thu, 2 May 2013 15:13:21 +0530
Subject: [PATCH v3,1/3] ARM: dts: AM33XX: Add ELM node
Message-ID: <7fa7438c9a7c5da575d762423815625d523c4689.1359007746.git.avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Philip, Avinash" <avinashphilip@ti.com>

Add ELM data node to AM33XX device tree file.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
Signed-off-by: Pekon Gupta <pekon@ti.com>

---
Changes in v2:
	- Replace <xx> literals to 52
	- remove tab

 arch/arm/boot/dts/am33xx.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0957645..24fc835 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -399,5 +399,13 @@
 			       0x44d80000 0x2000>;	/* M3 DMEM */
 			ti,hwmods = "wkup_m3";
 		};
+
+		elm: elm at 48080000 {
+			compatible = "ti,am3352-elm";
+			reg = <0x48080000 0x2000>;
+			interrupts = <4>;
+			ti,hwmods = "elm";
+			status = "disabled";
+		};
 	};
 };
