From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 26 Sep 2014 15:16:41 +0200
Subject: [PATCH 08/27] KVM: vgic: declare probe function pointer as const
In-Reply-To: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
References: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1411737420-9063-9-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

We extract the vgic probe function from the of_device_id data pointer,
which is const. Kill the sparse warning by ensuring that the local
function pointer is also marked as const.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index d1cfe67..efe6eee 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1557,8 +1557,8 @@ static const struct of_device_id vgic_ids[] = {
 int kvm_vgic_hyp_init(void)
 {
 	const struct of_device_id *matched_id;
-	int (*vgic_probe)(struct device_node *,const struct vgic_ops **,
-			  const struct vgic_params **);
+	const int (*vgic_probe)(struct device_node *,const struct vgic_ops **,
+				const struct vgic_params **);
 	struct device_node *vgic_node;
 	int ret;
 
-- 
2.0.0
