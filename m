From: joelagnel@ti.com (Joel A Fernandes)
Date: Tue, 25 Jun 2013 20:25:01 -0500
Subject: [PATCH 5/5] mmc: omap_hsmmc: Add reg-offset to bindings documentation
Message-ID: <1372209901-6715-1-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joel A Fernandes <agnel.joel@gmail.com>

A new reg-offset property was added to account for register offsets
in some omap-hsmmc's. Document the new property.

Signed-off-by: Joel A Fernandes <agnel.joel@gmail.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 8c8908a..33f4b1e 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -20,6 +20,9 @@ ti,dual-volt: boolean, supports dual voltage cards
 ti,non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
 ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
+reg-offset: Supplementing the common reg property (described in bindings/mmc/mmc.txt),
+some omap-hsmmc's can start an offset from reg but are otherwise identical to others.
+The registers between start to offset are considered reserved.
 dmas: List of DMA specifiers with the controller specific format
 as described in the generic DMA client binding. A tx and rx
 specifier is required.
-- 
1.7.9.5
