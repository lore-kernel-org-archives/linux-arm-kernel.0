From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Feb 2015 16:55:40 +0000
Subject: [PATCH 3/3] arm64: KVM: Fix outdated comment about VTCR_EL2.PS
In-Reply-To: <1424883340-29940-1-git-send-email-marc.zyngier@arm.com>
References: <1424883340-29940-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1424883340-29940-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 87366d8cf7b3 ("arm64: Add boot time configuration of
Intermediate Physical Address size") removed the hardcoded setting
of VTCR_EL2.PS to use ID_AA64MMFR0_EL1.PARange instead, but didn't
remove the (now rather misleading) comment.

Fix the comments to match reality (at least for the next few minutes).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 94674eb..54bb4ba 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -129,6 +129,9 @@
  * 40 bits wide (T0SZ = 24).  Systems with a PARange smaller than 40 bits are
  * not known to exist and will break with this configuration.
  *
+ * VTCR_EL2.PS is extracted from ID_AA64MMFR0_EL1.PARange at boot time
+ * (see hyp-init.S).
+ *
  * Note that when using 4K pages, we concatenate two first level page tables
  * together.
  *
@@ -138,7 +141,6 @@
 #ifdef CONFIG_ARM64_64K_PAGES
 /*
  * Stage2 translation configuration:
- * 40bits output (PS = 2)
  * 40bits input  (T0SZ = 24)
  * 64kB pages (TG0 = 1)
  * 2 level page tables (SL = 1)
@@ -150,7 +152,6 @@
 #else
 /*
  * Stage2 translation configuration:
- * 40bits output (PS = 2)
  * 40bits input  (T0SZ = 24)
  * 4kB pages (TG0 = 0)
  * 3 level page tables (SL = 1)
-- 
2.1.4
