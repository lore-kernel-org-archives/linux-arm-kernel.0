From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 28 Oct 2015 10:57:35 +0300
Subject: [PATCH v3 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <cover.1446018918.git.p.fedin@samsung.com>
References: <cover.1446018918.git.p.fedin@samsung.com>
Message-ID: <046d990092dc85cf50db9082fc894d93a3ece7c0.1446018918.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for new properties, allowing bank configuration.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 .../bindings/arm/samsung/exynos-srom.txt           | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
index 33886d5..9e4a40b 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
@@ -5,8 +5,30 @@ Required properties:
 
 - reg: offset and length of the register set
 
-Example:
+Bank configurations can be defined in optional subnodes. Each subnode
+describes one bank and contains the following:
+
+Required properties:
+- bank : bank number (0 - 3)
+
+- srom-timing : array of 7 integers: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs
+
+Optional properties:
+- width : data width in bytes (1 or 2). If omitted, default of 1 is used.
+
+Example: basic definition, no banks are configured
+	sromc at 12570000 {
+		compatible = "samsung,exynos-srom";
+		reg = <0x12570000 0x10>;
+	};
+
+Example: SROMc with bank3 configuration
 	sromc at 12570000 {
 		compatible = "samsung,exynos-srom";
 		reg = <0x12570000 0x10>;
+		bank at 3 {
+			bank = <3>;
+			width = <2>;
+			srom-timing = <1 9 12 1 9 1 1>;
+		};
 	};
-- 
2.4.4
