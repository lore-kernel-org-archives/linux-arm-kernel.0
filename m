From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Dec 2012 17:42:47 -0700
Subject: [PATCH 2/2] arm64: dts: prevent *.dtb from always being rebuilt
In-Reply-To: <1356741767-29292-1-git-send-email-swarren@wwwdotorg.org>
References: <1356741767-29292-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1356741767-29292-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

if_changed (used by the *.dts->*.dtc rule) rebuilds files if they aren't
contained in $(targets). (make V=2 indicates this). Add $(dtb-y) to
$(targets) to prevent *.dtb from always being rebuilt. Note

This fixes a regression introduced by the .dtb rule rework in da4cbc6
"arm64: use new common dtc rule", although since arm64 doesn't actually
have any *.dts yet, this isn't a critical issue.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm64/boot/dts/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 801e2d7..32ac0ae 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,4 +1,5 @@
 targets += dtbs
+targets += $(dtb-y)
 
 dtbs: $(addprefix $(obj)/, $(dtb-y))
 
-- 
1.7.10.4
