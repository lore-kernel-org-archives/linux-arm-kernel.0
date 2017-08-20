From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 20 Aug 2017 03:36:29 +0200
Subject: [RFC 1/3] dt-bindings: rtc: Add Realtek RTD1295
In-Reply-To: <20170820013632.18375-1-afaerber@suse.de>
References: <20170820013632.18375-1-afaerber@suse.de>
Message-ID: <20170820013632.18375-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding for the RTC on the Realtek RTD119x/RTD129x SoC families.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 .../devicetree/bindings/rtc/realtek,rtd119x.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt

diff --git a/Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt b/Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
new file mode 100644
index 000000000000..bbf1ccb5df31
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
@@ -0,0 +1,16 @@
+Realtek RTD129x Real-Time Clock
+===============================
+
+Required properties:
+- compatible :  Should be "realtek,rtd1295-rtc"
+- reg        :  Specifies the physical base address and size
+- clocks     :  Specifies the clock gate
+
+
+Example:
+
+	rtc at 9801b600 {
+		compatible = "realtek,rtd1295-clk";
+		reg = <0x9801b600 0x100>;
+		clocks = <&clkc RTD1295_CLK_EN_MISC_RTC>;
+	};
-- 
2.12.3
