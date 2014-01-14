From: marc.ceeeee@gmail.com (Marc Carino)
Date: Tue, 14 Jan 2014 15:48:51 -0800
Subject: [PATCH v3 5/7] ARM: brcmstb: add misc. DT bindings for brcm, brcmstb-*
In-Reply-To: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
References: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1389743333-16741-6-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the bindings that the Broadcom STB platform needs
for proper bootup.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/brcm-brcmstb.txt       |   43 ++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt

diff --git a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
new file mode 100644
index 0000000..5f1aba7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
@@ -0,0 +1,43 @@
+Broadcom STB platforms Device Tree Bindings
+-------------------------------------------
+Boards with Broadcom Brahma15 ARM-based BCM7xxx SoC shall have the following
+properties.
+
+Required root node properties:
+
+    - compatible = "brcm,brcmstb-<chip_id>";
+
+Further, a node with the following compatible string shall be defined:
+
+    - compatible: "brcm,brcmstb-gen-ctrl-v1"
+
+brcmstb-gen-ctrl
+----------------
+This node describes the registers needed for reset and CPU power control.
+
+    - compatible: "brcm,brcmstb-gen-ctrl-v1"
+    - properties:
+        o reg = <rst-src-en-reg-base len
+                 sw-mstr-rst-reg-base len
+                 cpu-rst-cfg-reg-base len
+                 cpu-pwr-zone-ctrl-reg-base len
+                 stb-boot-hi-addr0-reg len>;
+
+example:
+/ {
+    model = "Broadcom STB";
+    compatible =  "brcm,brcmstb-7445";
+
+    /* snip */
+
+    gen-ctrl {
+        compatible = "brcm,brcmstb-gen-ctrl-v1";
+        reg = <0xf0404304 0x4
+               0xf0404308 0x4
+               0xf03e2578 0x4
+               0xf03e2488 0x10
+               0xf0452000 0x20>;
+    };
+
+    /* snip */
+};
-- 
1.7.1
