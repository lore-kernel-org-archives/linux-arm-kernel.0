From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 23 Oct 2015 10:39:19 +0900
Subject: [PATCH v3 1/3] dt-bindings: Consolidate SRAM bindings from all vendors
Message-ID: <1445564361-16974-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SRAM bindings for various SoCs, using the mmio-sram genalloc
API, are spread over different places - per SoC vendor. Since all of
these are quite similar (they depend on mmio-sram) move them to a common
place.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Kukjin Kim <kgene@kernel.org>
Suggested-by: Rob Herring <robh+dt@kernel.org>

---

Changes since v2:
1. Update paths to sram.txt.

Changes since v1:
1. New patch. Extended suggestion from Rob.
---
 Documentation/devicetree/bindings/arm/arm,scpi.txt                      | 2 +-
 .../bindings/{arm/rockchip/pmu-sram.txt => sram/rockchip-pmu-sram.txt}  | 0
 .../bindings/{arm/rockchip/smp-sram.txt => sram/rockchip-smp-sram.txt}  | 2 +-
 .../bindings/{arm/exynos/smp-sysram.txt => sram/samsung-sram.txt}       | 2 +-
 Documentation/devicetree/bindings/{misc => sram}/sram.txt               | 0
 .../devicetree/bindings/{soc/sunxi/sram.txt => sram/sunxi-sram.txt}     | 2 +-
 6 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/{arm/rockchip/pmu-sram.txt => sram/rockchip-pmu-sram.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/rockchip/smp-sram.txt => sram/rockchip-smp-sram.txt} (92%)
 rename Documentation/devicetree/bindings/{arm/exynos/smp-sysram.txt => sram/samsung-sram.txt} (95%)
 rename Documentation/devicetree/bindings/{misc => sram}/sram.txt (100%)
 rename Documentation/devicetree/bindings/{soc/sunxi/sram.txt => sram/sunxi-sram.txt} (97%)

diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
index 86302de67c2c..313dabdc14f9 100644
--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -63,7 +63,7 @@ Required properties:
 - compatible : should be "arm,juno-sram-ns" for Non-secure SRAM on Juno
 
 The rest of the properties should follow the generic mmio-sram description
-found in ../../misc/sysram.txt
+found in ../../sram/sram.txt
 
 Each sub-node represents the reserved area for SCPI.
 
diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt
rename to Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
diff --git a/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
similarity index 92%
rename from Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
rename to Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
index d9416fb8db6f..800701ecffca 100644
--- a/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
+++ b/Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
@@ -12,7 +12,7 @@ Required sub-node properties:
 - compatible : should be "rockchip,rk3066-smp-sram"
 
 The rest of the properties should follow the generic mmio-sram discription
-found in ../../misc/sram.txt
+found in Documentation/devicetree/bindings/sram/sram.txt
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/arm/exynos/smp-sysram.txt b/Documentation/devicetree/bindings/sram/samsung-sram.txt
similarity index 95%
rename from Documentation/devicetree/bindings/arm/exynos/smp-sysram.txt
rename to Documentation/devicetree/bindings/sram/samsung-sram.txt
index 4a0a4f70a0ce..6bc474b2b885 100644
--- a/Documentation/devicetree/bindings/arm/exynos/smp-sysram.txt
+++ b/Documentation/devicetree/bindings/sram/samsung-sram.txt
@@ -15,7 +15,7 @@ Required sub-node properties:
 		"samsung,exynos4210-sysram-ns" : for Non-secure SYSRAM
 
 The rest of the properties should follow the generic mmio-sram discription
-found in ../../misc/sysram.txt
+found in Documentation/devicetree/bindings/sram/sram.txt
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
similarity index 100%
rename from Documentation/devicetree/bindings/misc/sram.txt
rename to Documentation/devicetree/bindings/sram/sram.txt
diff --git a/Documentation/devicetree/bindings/soc/sunxi/sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
similarity index 97%
rename from Documentation/devicetree/bindings/soc/sunxi/sram.txt
rename to Documentation/devicetree/bindings/sram/sunxi-sram.txt
index 067698112f5f..8d5665468fe7 100644
--- a/Documentation/devicetree/bindings/soc/sunxi/sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -16,7 +16,7 @@ SRAM nodes
 ----------
 
 Each SRAM is described using the mmio-sram bindings documented in
-Documentation/devicetree/bindings/misc/sram.txt
+Documentation/devicetree/bindings/sram/sram.txt
 
 Each SRAM will have SRAM sections that are going to be handled by the
 SRAM controller as subnodes. These sections are represented following
-- 
1.9.1
