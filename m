From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:03:04 +0100
Subject: [GIT PULL 35/36] arm/arm64: KVM: Fixup incorrect config symbol in
 comment
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-36-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A comment in the dirty page logging patch series mentioned incorrectly
spelled config symbols, just fix them up to match the real thing.

Reported-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index eb94597..74aeaba 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1042,8 +1042,8 @@ static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
 		/*
 		 * Release kvm_mmu_lock periodically if the memory region is
 		 * large. Otherwise, we may see kernel panics with
-		 * CONFIG_DETECT_HUNG_TASK, CONFIG_LOCK_DETECTOR,
-		 * CONFIG_LOCK_DEP. Additionally, holding the lock too long
+		 * CONFIG_DETECT_HUNG_TASK, CONFIG_LOCKUP_DETECTOR,
+		 * CONFIG_LOCKDEP. Additionally, holding the lock too long
 		 * will also starve other vCPUs.
 		 */
 		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
-- 
2.1.2.330.g565301e.dirty
