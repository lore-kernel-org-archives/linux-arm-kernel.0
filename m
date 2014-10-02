From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  2 Oct 2014 15:11:27 +0200
Subject: [PATCH] ARM: zynq: DT: Add cadence watchdog node
Message-ID: <2079bb5b538a78c720cc7a1517c227376da1a3ba.1412255481.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the cadence watchdog node to the Zynq devicetree.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 2690e6d01f71..ea2651cd92ec 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -314,5 +314,16 @@
 			reg = <0xf8f00600 0x20>;
 			clocks = <&clkc 4>;
 		};
+
+		watchdog0: watchdog at f8005000 {
+			clocks = <&clkc 45>;
+			compatible = "xlnx,zynq-wdt-r1p2";
+			device_type = "watchdog";
+			interrupt-parent = <&intc>;
+			interrupts = <0 9 1>;
+			reg = <0xf8005000 0x1000>;
+			reset = <0>;
+			timeout-sec = <10>;
+		};
 	};
 };
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141002/51417370/attachment.sig>
