From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 31 May 2017 09:18:35 +0200
Subject: [PATCH v6 04/21] dt-bindings: syscon: Add DT bindings documentation
 for Allwinner syscon
In-Reply-To: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
References: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
Message-ID: <20170531071852.12422-5-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for Device-Tree bindings for the
syscon present in allwinner devices.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/misc/allwinner,syscon.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/allwinner,syscon.txt

diff --git a/Documentation/devicetree/bindings/misc/allwinner,syscon.txt b/Documentation/devicetree/bindings/misc/allwinner,syscon.txt
new file mode 100644
index 000000000000..cb5769137c6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/allwinner,syscon.txt
@@ -0,0 +1,19 @@
+* Allwinner sun8i system controller
+
+This file describes the bindings for the system controller present in
+Allwinner SoC H3, A83T and A64.
+The principal function of this syscon is to control EMAC PHY choice and
+config.
+
+Required properties for the system controller:
+- reg: address and length of the register for the device.
+- compatible: should be "syscon" and one of the following string:
+		"allwinner,sun8i-h3-system-controller"
+		"allwinner,sun50i-a64-system-controller"
+		"allwinner,sun8i-a83t-system-controller"
+
+Example:
+syscon: syscon at 1c00000 {
+	compatible = "allwinner,sun8i-h3-system-controller", "syscon";
+	reg = <0x01c00000 0x1000>;
+};
-- 
2.13.0
