From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 13 Jul 2015 08:58:51 +0200
Subject: [PATCH] PM / devfreq: event: Remove incorrect property in exynos-ppmu
 DT binding
Message-ID: <1436770732-9430-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos-ppmu driver is only a clock consumer and not a clock provider
but its Device Tree binding listed #clock-cells as an optional property.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
index b54bf3a2ff57..aed486692880 100644
--- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
+++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
@@ -17,7 +17,6 @@ Required properties:
 Optional properties:
 - clock-names : the name of clock used by the PPMU, "ppmu"
 - clocks : phandles for clock specified in "clock-names" property
-- #clock-cells: should be 1.
 
 Example1 : PPMU nodes in exynos3250.dtsi are listed below.
 
-- 
2.4.3
