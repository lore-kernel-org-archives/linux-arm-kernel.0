From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 15 Jun 2017 12:59:03 -0700
Subject: [PATCH 1/2] dt-bindings: Document the Broadcom STB wake-up timer node
In-Reply-To: <20170615195904.12653-1-f.fainelli@gmail.com>
References: <20170615195904.12653-1-f.fainelli@gmail.com>
Message-ID: <20170615195904.12653-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the binding for the Broadcom STB SoCs wake-up timer node
allowing the system to generate alarms and exit low power states.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/rtc/brcm,brcmstb-waketimer.txt        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt

diff --git a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
new file mode 100644
index 000000000000..1d990bcc0baf
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
@@ -0,0 +1,22 @@
+Broadcom STB wake-up Timer
+
+The Broadcom STB wake-up timer provides a 27Mhz resolution timer, with the
+ability to wake up the system from low-power suspend/standby modes.
+
+Required properties:
+- compatible     : should contain "brcm,brcmstb-waketimer"
+- reg            : the register start and length for the WKTMR block
+- interrupts     : The TIMER interrupt
+- interrupt-parent: The phandle to the Always-On (AON) Power Management (PM) L2
+                    interrupt controller node
+- clocks	 : The phandle to the UPG fixed clock (27Mhz domain)
+
+Example:
+
+waketimer at f0411580 {
+	compatible = "brcm,brcmstb-waketimer";
+	reg = <0xf0411580 0x14>;
+	interrupts = <0x3>;
+	interrupt-parent = <&aon_pm_l2_intc>;
+	clocks = <&upg_fixed>;
+};
-- 
2.9.3
