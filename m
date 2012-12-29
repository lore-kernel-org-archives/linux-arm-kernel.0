From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Dec 2012 17:42:46 -0700
Subject: [PATCH 1/2] ARM: dts: prevent *.dtb from always being rebuilt
Message-ID: <1356741767-29292-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

if_changed (used by the *.dts->*.dtc rule) rebuilds files if they aren't
contained in $(targets). (make V=2 indicates this). Add $(dtb-y) to
$(targets) to prevent *.dtb from always being rebuilt.

This fixes a regression introduced by the .dtb rule rework in 499cd82
"ARM: dt: change .dtb build rules to build in dts directory".

Reported-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e44da40..5ebb44f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -155,6 +155,7 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
 dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb
 
 targets += dtbs
+targets += $(dtb-y)
 endif
 
 # *.dtb used to be generated in the directory above. Clean out the
-- 
1.7.10.4
