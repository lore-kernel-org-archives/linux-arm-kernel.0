From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 15 Dec 2014 18:43:32 +0100
Subject: [PATCH v3 1/2] KVM: arm/arm64: vgic: vgic_init returns -ENODEV when
 no online vcpu
In-Reply-To: <1418665413-31521-1-git-send-email-eric.auger@linaro.org>
References: <1418665413-31521-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1418665413-31521-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be more explicit on vgic initialization failure, -ENODEV is
returned by vgic_init when no online vcpus can be found at init.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v2 -> v3: vgic_init_maps was renamed into vgic_init
---
 virt/kvm/arm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index e373b76..d61a61f 100644
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
1.9.1
