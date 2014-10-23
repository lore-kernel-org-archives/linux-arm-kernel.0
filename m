From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 Oct 2014 20:14:29 +0200
Subject: [PATCH 3/4] ARM: mvebu: Fix secondary startup for Cortex A9 SoC
In-Reply-To: <1414088070-12510-1-git-send-email-gregory.clement@free-electrons.com>
References: <1414088070-12510-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1414088070-12510-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the secondary startup the SCU was assumed to be in normal
mode. It is not always the case, and especially after a kexec. This
commit adds the needed sequence to put the SCU in normal mode.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/headsmp-a9.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
index be51c998c0cd..2a756ef5c4ba 100644
--- a/arch/arm/mach-mvebu/headsmp-a9.S
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@ -22,5 +22,6 @@
 ENTRY(mvebu_cortex_a9_secondary_startup)
 ARM_BE8(setend	be)
 	bl      v7_invalidate_l1
+	bl	power_up_scu
 	b	secondary_startup
 ENDPROC(mvebu_cortex_a9_secondary_startup)
-- 
1.9.1
