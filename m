From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Tue, 5 Aug 2014 22:58:10 +0800
Subject: [PATCH 3/3] dt-bindings: add bindings for mediatek intpol
In-Reply-To: <1407250690-2858-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1407250690-2858-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <1407250690-2858-4-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Add binding documentation for Mediatek SoC GIC interrupt polarity extension.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 .../bindings/interrupt-controller/mediatek,intpol.txt    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt
new file mode 100644
index 0000000..16ea372
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt
@@ -0,0 +1,16 @@
+Mediatek 65xx/81xx GIC interrupt polarity extension
+
+Mediatek SOCs contain controllable inverter for each GIC SPI interrupt,
+these can be used as GIC interrupt polarity extension.
+
+Required properties:
+- compatible: Compatible property value should be "mediatek,mt6577-intpol"
+
+- reg: Physical base address of the int pol registers and length of memory
+  mapped region.
+
+Example:
+       intpol: intpol at 10200100 {
+               compatible = "mediatek,mt6577-intpol";
+               reg = <0x10200100 0x1c>;
+       };
-- 
1.8.1.1.dirty
