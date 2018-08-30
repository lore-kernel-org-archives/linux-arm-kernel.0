From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 30 Aug 2018 20:02:05 +0200
Subject: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC as
 unstable
Message-ID: <20180830180205.18121-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung Exynos SoCs and boards related bindings evolved since the initial
introduction, but initially the bindings were minimal and a bit incomplete
(they never described all the hardware modules available in the SoCs).
Since then some significant (not fully compatible) changes have been
already committed a few times (like gpio replaced by pinctrl, display ddc,
mfc reserved memory, some core clocks added to various hardware modules,
added more required nodes).

On the other side there are no boards which have device tree embedded in
the bootloader. Device tree blob is always compiled from the kernel tree
and updated together with the kernel image.

Thus to avoid further adding a bunch of workarounds for old/missing
bindings, make development of new platforms easier and allow to make
cleanup of the existing code and device tree files, lets mark some
Samsung Exynos SoC platform bindings as unstable. This means that
bindings can may change at any time and users should use the dtb file
compiled from the same kernel source tree as the kernel image.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
[krzk: Explicitly list unstable bindings instead of marking entire
Exynos]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

---

Changes since v2:
1. Add tags.

Changes since v1:
1. Rebase
2. Add specific compatibles to mark unstable.

v1 is here:
https://patchwork.kernel.org/patch/9477963/

Previous tags (not applying due to change in contents):
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 .../devicetree/bindings/arm/samsung/exynos.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos.txt b/Documentation/devicetree/bindings/arm/samsung/exynos.txt
new file mode 100644
index 000000000000..7410cb79e4b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos.txt
@@ -0,0 +1,26 @@
+Samsung Exynos SoC Family Device Tree Bindings
+---------------------------------------------------------------
+
+Work in progress statement:
+
+Following Device Tree files and bindings applying to Samsung Exynos SoCs and
+boards are considered "unstable":
+
+ - samsung,exynos5433* (all compatibles related to Exynos5433)
+ - samsung,exynos7* (all compatibles related to Exynos7)
+ - samsung,tm2-audio
+ - samsung,mfc-v10
+ - samsung,exynos*-mipi-dsi
+ - samsung,exynos5-dp
+ - samsung,exynos*-hdmi
+ - samsung,exynos*-hdmiddc
+ - samsung,exynos*-hdmiphy
+ - samsung,exynos*-mixer
+ - samsung,exynos*-fimd
+
+Any Samsung Exynos device tree binding mentioned may change at any time. Be
+sure to use a device tree binary and a kernel image generated from the same
+source tree.
+
+Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
+stable binding/ABI.
-- 
2.14.1
