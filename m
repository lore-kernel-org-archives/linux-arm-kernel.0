From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 22 Oct 2015 10:25:28 +0900
Subject: [PATCH v2 1/3] dt-bindings: Consolidate SRAM bindings from all vendors
Message-ID: <1445477130-407-1-git-send-email-k.kozlowski@samsung.com>
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

Changes since v1:
1. New patch. Extended suggestion from Rob.
---
 .../bindings/{arm/rockchip/pmu-sram.txt => sram/rockchip-pmu-sram.txt}    | 0
 .../bindings/{arm/rockchip/smp-sram.txt => sram/rockchip-smp-sram.txt}    | 0
 .../bindings/{arm/exynos/smp-sysram.txt => sram/samsung-sram.txt}         | 0
 Documentation/devicetree/bindings/{misc => sram}/sram.txt                 | 0
 .../devicetree/bindings/{soc/sunxi/sram.txt => sram/sunxi-sram.txt}       | 0
 5 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{arm/rockchip/pmu-sram.txt => sram/rockchip-pmu-sram.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/rockchip/smp-sram.txt => sram/rockchip-smp-sram.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/exynos/smp-sysram.txt => sram/samsung-sram.txt} (100%)
 rename Documentation/devicetree/bindings/{misc => sram}/sram.txt (100%)
 rename Documentation/devicetree/bindings/{soc/sunxi/sram.txt => sram/sunxi-sram.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt
rename to Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
diff --git a/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
rename to Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
diff --git a/Documentation/devicetree/bindings/arm/exynos/smp-sysram.txt b/Documentation/devicetree/bindings/sram/samsung-sram.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/exynos/smp-sysram.txt
rename to Documentation/devicetree/bindings/sram/samsung-sram.txt
diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
similarity index 100%
rename from Documentation/devicetree/bindings/misc/sram.txt
rename to Documentation/devicetree/bindings/sram/sram.txt
diff --git a/Documentation/devicetree/bindings/soc/sunxi/sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
similarity index 100%
rename from Documentation/devicetree/bindings/soc/sunxi/sram.txt
rename to Documentation/devicetree/bindings/sram/sunxi-sram.txt
-- 
1.9.1
