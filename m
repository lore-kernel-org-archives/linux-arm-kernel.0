From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 14 Mar 2017 15:18:40 +0100
Subject: [PATCH v2 04/20] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner syscon
In-Reply-To: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
References: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
Message-ID: <20170314141856.24560-5-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 .../devicetree/bindings/misc/allwinner,syscon.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/allwinner,syscon.txt

diff --git a/Documentation/devicetree/bindings/misc/allwinner,syscon.txt b/Documentation/devicetree/bindings/misc/allwinner,syscon.txt
new file mode 100644
index 0000000..9f5f1f5
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
+		"allwinner,sun8i-a64-system-controller"
+		"allwinner,sun8i-a83t-system-controller"
+
+Example:
+syscon: syscon at 01c00000 {
+	compatible = "syscon", "allwinner,sun8i-h3-system-controller";
+	reg = <0x01c00000 0x1000>;
+};
-- 
2.10.2
