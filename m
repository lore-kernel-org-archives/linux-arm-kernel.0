From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 12 Dec 2015 08:16:47 +0100
Subject: [PATCH 2/2] arm64: dts: r8a7795: Add L2 cache-controller nodes
In-Reply-To: <1449904607-4060-1-git-send-email-dirk.behme@gmail.com>
References: <1449904607-4060-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <1449904607-4060-2-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add device nodes for the L2 caches, and link the CPU node to its L2
cache node.

The L2 cache for the Cortex-A57 CPU cores is 2 MiB large (organized as
128 KiB x 16 ways).

The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
32 KiB x 16 ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---
Note: Geert: I picked your patch from

http://www.spinics.net/lists/arm-kernel/msg466628.html

incoporated some review comments and rebased it against

https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/log/?h=next renesas-next-20151211v2-v4.4-rc1 

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 3633a2a..d63a70f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -39,6 +39,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x0>;
 			device_type = "cpu";
+			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
 
@@ -46,46 +47,61 @@
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x1>;
 			device_type = "cpu";
+			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
 		a57_2: cpu at 2 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x2>;
 			device_type = "cpu";
+			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
 		a57_3: cpu at 3 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x3>;
 			device_type = "cpu";
+			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
 		a53_0: cpu at 100 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x100>;
 			device_type = "cpu";
+			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 		};
 		a53_1: cpu at 101 {
 			compatible = "arm,cortex-a53","arm,armv8";
 			reg = <0x101>;
 			device_type = "cpu";
+			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 		};
 		a53_2: cpu at 102 {
 			compatible = "arm,cortex-a53","arm,armv8";
 			reg = <0x102>;
 			device_type = "cpu";
+			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 		};
 		a53_3: cpu at 103 {
 			compatible = "arm,cortex-a53","arm,armv8";
 			reg = <0x103>;
 			device_type = "cpu";
+			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 		};
 	};
 
+	L2_CA57: cache-controller at 0 {
+		compatible = "cache";
+	};
+
+	L2_CA53: cache-controller at 1 {
+		compatible = "cache";
+	};
+
 	extal_clk: extal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.6.4
