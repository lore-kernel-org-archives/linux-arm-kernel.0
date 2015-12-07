From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon,  7 Dec 2015 10:57:27 +0000
Subject: [PATCH 1/4] DT: nvmem: Add NXP LPC18xx EEPROM memory binding
 documentation
In-Reply-To: <1449485763-391-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1449485763-391-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1449485847-437-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Add the devicetree binding document for NXP LPC18xx EEPROM memory.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/lpc1857-eeprom.txt   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt

diff --git a/Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt b/Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
new file mode 100644
index 0000000..809df68
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
@@ -0,0 +1,28 @@
+* NXP LPC18xx EEPROM memory NVMEM driver
+
+Required properties:
+  - compatible: Should be "nxp,lpc1857-eeprom"
+  - reg: Must contain an entry with the physical base address and length
+    for each entry in reg-names.
+  - reg-names: Must include the following entries.
+    - reg: EEPROM registers.
+    - mem: EEPROM address space.
+  - clocks: Must contain an entry for each entry in clock-names.
+  - clock-names: Must include the following entries.
+    - eeprom: EEPROM operating clock.
+  - resets: Should contain a reference to the reset controller asserting
+    the EEPROM in reset.
+  - interrupts: Should contain EEPROM interrupt.
+
+Example:
+
+  eeprom: eeprom at 4000e000 {
+    compatible = "nxp,lpc1857-eeprom";
+    reg = <0x4000e000 0x1000>,
+          <0x20040000 0x4000>;
+    reg-names = "reg", "mem";
+    clocks = <&ccu1 CLK_CPU_EEPROM>;
+    clock-names = "eeprom";
+    resets = <&rgu 27>;
+    interrupts = <4>;
+  };
-- 
1.9.1
