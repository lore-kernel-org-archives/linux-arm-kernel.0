From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 11 Sep 2014 15:18:45 +0200
Subject: [PATCH v4 9/9] mfd: syscon: add Atmel GPBR DT bindings documention
In-Reply-To: <1410441525-25258-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1410441525-25258-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1410441525-25258-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPBR block provides a set of battery-backed registers that can be used
to save data which need to be kept when the system is powered down and
VDD-core is maintained by an external battery.

A typical usage is the RTT block (when used as an RTC) which needs one of
those registers to save the current time.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/mfd/atmel,gpbr.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,gpbr.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel,gpbr.txt b/Documentation/devicetree/bindings/mfd/atmel,gpbr.txt
new file mode 100644
index 0000000..a285695
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel,gpbr.txt
@@ -0,0 +1,15 @@
+* Device tree bindings for Atmel GPBR (General Purpose Backup Registers)
+
+The GPBR are a set of battery-backed registers.
+
+Required properties:
+- compatible:		"atmel,at91sam9260-gpbr", "syscon"
+- reg:			contains offset/length value of the GPBR memory
+			region.
+
+Example:
+
+gpbr: gpbr at fffffd50 {
+	compatible = "atmel,at91sam9260-gpbr", "syscon";
+	reg = <0xfffffd50 0x10>;
+};
-- 
1.9.1
