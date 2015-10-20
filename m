From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 20 Oct 2015 18:19:03 +0200
Subject: [GIT PULL 2/6] KVM: arm/arm64: Fix memory leak if timer
 initialization fails
In-Reply-To: <1445357947-6022-1-git-send-email-christoffer.dall@linaro.org>
References: <1445357947-6022-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1445357947-6022-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pavel Fedin <p.fedin@samsung.com>

Jump to correct label and free kvm_host_cpu_state

Reviewed-by: Wei Huang <wei@redhat.com>
Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index dc017ad..78b2869 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1080,7 +1080,7 @@ static int init_hyp_mode(void)
 	 */
 	err = kvm_timer_hyp_init();
 	if (err)
-		goto out_free_mappings;
+		goto out_free_context;
 
 #ifndef CONFIG_HOTPLUG_CPU
 	free_boot_hyp_pgd();
-- 
2.1.2.330.g565301e.dirty
