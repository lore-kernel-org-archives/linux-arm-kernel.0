From: stigge@antcom.de (Roland Stigge)
Date: Sat,  5 May 2012 13:38:06 +0200
Subject: [PATCH RESEND] Documentation: devicetree: Fix value format description
Message-ID: <1336217886-27224-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Numeric values in dts files can be specified in decimal and hex (the latter
prefixed 0x). The current documentation is updated with this patch to prevent
confusion about what is meant with values without "0x" (previously hex, now
dec).

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
Applies to v3.4-rc5

 Documentation/devicetree/booting-without-of.txt |   55 ++++++++++++------------
 1 file changed, 28 insertions(+), 27 deletions(-)

--- linux-2.6.orig/Documentation/devicetree/booting-without-of.txt
+++ linux-2.6/Documentation/devicetree/booting-without-of.txt
@@ -551,12 +551,13 @@ Here is an example of a simple device-tr
 designates a node followed by the node unit name. Properties are
 presented with their name followed by their content. "content"
 represents an ASCII string (zero terminated) value, while <content>
-represents a 32-bit hexadecimal value. The various nodes in this
-example will be discussed in a later chapter. At this point, it is
-only meant to give you a idea of what a device-tree looks like. I have
-purposefully kept the "name" and "linux,phandle" properties which
-aren't necessary in order to give you a better idea of what the tree
-looks like in practice.
+represents a 32-bit value, specified in decimal or hexadecimal (the
+latter prefixed 0x). The various nodes in this example will be
+discussed in a later chapter. At this point, it is only meant to give
+you a idea of what a device-tree looks like. I have purposefully kept
+the "name" and "linux,phandle" properties which aren't necessary in
+order to give you a better idea of what the tree looks like in
+practice.
 
   / o device-tree
       |- name = "device-tree"
@@ -576,14 +577,14 @@ looks like in practice.
       |   |- name = "PowerPC,970"
       |   |- device_type = "cpu"
       |   |- reg = <0>
-      |   |- clock-frequency = <5f5e1000>
+      |   |- clock-frequency = <0x5f5e1000>
       |   |- 64-bit
       |   |- linux,phandle = <2>
       |
       o memory at 0
       | |- name = "memory"
       | |- device_type = "memory"
-      | |- reg = <00000000 00000000 00000000 20000000>
+      | |- reg = <0x00000000 0x00000000 0x00000000 0x20000000>
       | |- linux,phandle = <3>
       |
       o chosen
@@ -1010,8 +1011,8 @@ compatibility.
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
 		device_type = "soc";
-		ranges = <00000000 e0000000 00100000>
-		reg = <e0000000 00003000>;
+		ranges = <0x00000000 0xe0000000 0x00100000>
+		reg = <0xe0000000 0x00003000>;
 		bus-frequency = <0>;
 	}
 
@@ -1085,16 +1086,16 @@ supported currently at the toplevel.
                                  * terminated string
 				 */
 
-  property2 = <1234abcd>;	/* define a property containing a
+  property2 = <0x1234abcd>;	/* define a property containing a
                                  * numerical 32-bit value (hexadecimal)
 				 */
 
-  property3 = <12345678 12345678 deadbeef>;
+  property3 = <0x12345678 0x12345678 0xdeadbeef>;
                                 /* define a property containing 3
                                  * numerical 32-bit values (cells) in
                                  * hexadecimal
 				 */
-  property4 = [0a 0b 0c 0d de ea ad be ef];
+  property4 = [0x0a 0x0b 0x0c 0x0d 0xde 0xea 0xad 0xbe 0xef];
                                 /* define a property whose content is
                                  * an arbitrary array of bytes
                                  */
@@ -1350,10 +1351,10 @@ Appendix A - Sample SOC node for MPC8540
 			model = "TSEC";
 			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
-			local-mac-address = [ 00 E0 0C 00 73 00 ];
-			interrupts = <29 2 30 2 34 2>;
+			local-mac-address = [ 0x00 0xE0 0x0C 0x00 0x73 0x00 ];
+			interrupts = <0x29 2 0x30 2 0x34 2>;
 			phy-handle = <&phy0>;
-			sleep = <&pmc 00000080>;
+			sleep = <&pmc 0x00000080>;
 			ranges;
 
 			mdio at 24520 {
@@ -1385,10 +1386,10 @@ Appendix A - Sample SOC node for MPC8540
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
-			local-mac-address = [ 00 E0 0C 00 73 01 ];
-			interrupts = <13 2 14 2 18 2>;
+			local-mac-address = [ 0x00 0xE0 0x0C 0x00 0x73 0x01 ];
+			interrupts = <0x13 2 0x14 2 0x18 2>;
 			phy-handle = <&phy1>;
-			sleep = <&pmc 00000040>;
+			sleep = <&pmc 0x00000040>;
 		};
 
 		ethernet at 26000 {
@@ -1396,17 +1397,17 @@ Appendix A - Sample SOC node for MPC8540
 			model = "FEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
-			local-mac-address = [ 00 E0 0C 00 73 02 ];
-			interrupts = <41 2>;
+			local-mac-address = [ 0x00 0xE0 0x0C 0x00 0x73 0x02 ];
+			interrupts = <0x41 2>;
 			phy-handle = <&phy3>;
-			sleep = <&pmc 00000020>;
+			sleep = <&pmc 0x00000020>;
 		};
 
 		serial at 4500 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "fsl,mpc8540-duart", "simple-bus";
-			sleep = <&pmc 00000002>;
+			sleep = <&pmc 0x00000002>;
 			ranges;
 
 			serial at 4500 {
@@ -1414,7 +1415,7 @@ Appendix A - Sample SOC node for MPC8540
 				compatible = "ns16550";
 				reg = <0x4500 0x100>;
 				clock-frequency = <0>;
-				interrupts = <42 2>;
+				interrupts = <0x42 2>;
 			};
 
 			serial at 4600 {
@@ -1422,7 +1423,7 @@ Appendix A - Sample SOC node for MPC8540
 				compatible = "ns16550";
 				reg = <0x4600 0x100>;
 				clock-frequency = <0>;
-				interrupts = <42 2>;
+				interrupts = <0x42 2>;
 			};
 		};
 
@@ -1436,11 +1437,11 @@ Appendix A - Sample SOC node for MPC8540
 		};
 
 		i2c at 3000 {
-			interrupts = <43 2>;
+			interrupts = <0x43 2>;
 			reg = <0x3000 0x100>;
 			compatible  = "fsl-i2c";
 			dfsrr;
-			sleep = <&pmc 00000004>;
+			sleep = <&pmc 0x00000004>;
 		};
 
 		pmc: power at e0070 {
