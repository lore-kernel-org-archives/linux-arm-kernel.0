From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:30 +0100
Subject: [GIT PULL 01/36] KVM: arm/arm64: vgic: vgic_init returns -ENODEV when
 no online vcpu
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@linaro.org>

To be more explicit on vgic initialization failure, -ENODEV is
returned by vgic_init when no online vcpus can be found at init.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 03affc7..b8d57e8 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1809,7 +1809,7 @@ static int vgic_init(struct kvm *kvm)
 
 	nr_cpus = dist->nr_cpus = atomic_read(&kvm->online_vcpus);
 	if (!nr_cpus)		/* No vcpus? Can't be good... */
-		return -EINVAL;
+		return -ENODEV;
 
 	/*
 	 * If nobody configured the number of interrupts, use the
-- 
2.1.2.330.g565301e.dirty
