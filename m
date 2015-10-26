From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 26 Oct 2015 14:47:44 +0300
Subject: [PATCH 4/4] Documentation: dt-bindings: Describe SROMc configuration
In-Reply-To: <cover.1445859834.git.p.fedin@samsung.com>
References: <cover.1445859834.git.p.fedin@samsung.com>
Message-ID: <7ac097efc649bac4e9f2b991baaa969ce4cbc3ef.1445859834.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for new properties, allowing bank configuration.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 .../devicetree/bindings/arm/samsung/exynos-srom.txt   | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
index 33886d5..73750da 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
@@ -5,8 +5,25 @@ Required properties:
 
 - reg: offset and length of the register set
 
-Example:
+Bank configurations can be defined as an optional subnodes. They can have the
+following properties:
+- bank : bank number (0 - 3)
+- width : data width in bytes (1 or 2). If omitted, default of 1 is used.
+- srom-timing : array of 7 integers: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs
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
