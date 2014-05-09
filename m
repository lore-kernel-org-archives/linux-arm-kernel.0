From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Fri, 9 May 2014 10:04:32 +0800
Subject: [PATCHv4 1/2] dt/bindings: Add the DT binding documentation for
 endianness
In-Reply-To: <1399601073-19278-1-git-send-email-Li.Xiubo@freescale.com>
References: <1399601073-19278-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1399601073-19278-2-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device-Tree binding for device endianness

The endianness mode of CPU & Device scenarios:
Index    CPU       Device     Endianness properties
------------------------------------------------------------
1        LE        LE         -
2        LE        BE         'big-endian{,-*}'
3        BE        BE         -
4        BE        LE         'little-endian{,-*}'

{big,little}-endian{,-*}: these are boolean properties, if absent
meaning that the CPU and the Device are in the same endianness mode.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../devicetree/bindings/endianness/endianness.txt  | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/endianness/endianness.txt

diff --git a/Documentation/devicetree/bindings/endianness/endianness.txt b/Documentation/devicetree/bindings/endianness/endianness.txt
new file mode 100644
index 0000000..cc5f7f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/endianness/endianness.txt
@@ -0,0 +1,48 @@
+Device-Tree binding for device endianness
+
+The endianness mode of CPU & Device scenarios:
+Index    CPU       Device     Endianness properties
+------------------------------------------------------------
+1        LE        LE         -
+2        LE        BE         'big-endian{,-*}'
+3        BE        BE         -
+4        BE        LE         'little-endian{,-*}'
+
+For one device driver, which will run in different scenarios above
+on different SoCs using the devicetree, we need one way to simplify
+this.
+
+Required properties:
+- {big,little}-endian{,-*}: these are boolean properties, if absent
+  meaning that the CPU and the Device are in the same endianness mode.
+
+Examples:
+Scenario 1 : CPU in LE mode & device in LE mode.
+dev: dev at 40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+};
+
+Scenario 2 : CPU in LE mode & device in BE mode.
+dev: dev at 40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+	      big-endian{,-*};
+};
+
+Scenario 3 : CPU in BE mode & device in BE mode.
+dev: dev at 40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+};
+
+Scenario 4 : CPU in BE mode & device in LE mode.
+dev: dev at 40031000 {
+	      compatible = "name";
+	      reg = <0x40031000 0x1000>;
+	      ...
+	      little-endian{,-*};
+};
-- 
1.8.4
