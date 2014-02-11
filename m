From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 11 Feb 2014 07:55:52 +0100
Subject: [PATCH v2 09/11] watchdog: xilinx: Add missing binding
In-Reply-To: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
References: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
Message-ID: <85fbb492f75b17b916be694744bb053448e9db96.1392101734.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document current driver binding.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

Changes in v2: None

 .../devicetree/bindings/watchdog/of-xilinx-wdt.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
new file mode 100644
index 0000000..6d63782
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
@@ -0,0 +1,23 @@
+Xilinx AXI/PLB soft-core watchdog Device Tree Bindings
+---------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,xps-timebase-wdt-1.00.a" or
+			  "xlnx,xps-timebase-wdt-1.01.a".
+- reg			: Physical base address and size
+
+Optional properties:
+- clock-frequency	: Frequency of clock in Hz
+- xlnx,wdt-enable-once	: 0 - Watchdog can be restarted
+			  1 - Watchdog can be enabled just once
+- xlnx,wdt-interval	: Watchdog timeout interval in 2^<val> clock cycles,
+			  <val> is integer from 8 to 31.
+
+Example:
+axi-timebase-wdt at 40100000 {
+	clock-frequency = <50000000>;
+	compatible = "xlnx,xps-timebase-wdt-1.00.a";
+	reg = <0x40100000 0x10000>;
+	xlnx,wdt-enable-once = <0x0>;
+	xlnx,wdt-interval = <0x1b>;
+} ;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140211/1e73fb3e/attachment.sig>
