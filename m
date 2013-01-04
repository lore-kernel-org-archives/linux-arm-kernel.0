From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Jan 2013 17:44:14 +0000
Subject: [PATCH 1/2] ARM: hyp: boot secondary CPUs through the right entry
 point
In-Reply-To: <1357321455-9264-1-git-send-email-marc.zyngier@arm.com>
References: <1357321455-9264-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1357321455-9264-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Secondary CPUs should use the __hyp_stub_install_secondary entry
point, so boot mode inconsistencies can be detected.

Reported-by: Ian Molton <ian.molton@collabora.co.uk>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 4eee351..16abc83 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -331,7 +331,7 @@ ENTRY(secondary_startup)
 	 * as it has already been validated by the primary processor.
 	 */
 #ifdef CONFIG_ARM_VIRT_EXT
-	bl	__hyp_stub_install
+	bl	__hyp_stub_install_secondary
 #endif
 	safe_svcmode_maskall r9
 
-- 
1.8.1
