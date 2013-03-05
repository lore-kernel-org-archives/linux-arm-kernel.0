From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:21 +0000
Subject: [PATCH 27/29] ARM: KVM: move include of asm/idmap.h to kvm_mmu.h
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-28-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the arm64 code doesn't have a global asm/idmap.h file, move
the inclusion to asm/kvm_mmu.h.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h | 1 +
 arch/arm/kvm/mmu.c             | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 3c71a1d..970f3b5 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -21,6 +21,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/pgalloc.h>
+#include <asm/idmap.h>
 
 /*
  * We directly use the kernel VA for the HYP, as we can directly share
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index f601e6f..b694f58 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -20,7 +20,6 @@
 #include <linux/kvm_host.h>
 #include <linux/io.h>
 #include <trace/events/kvm.h>
-#include <asm/idmap.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/kvm_arm.h>
-- 
1.7.12.4
