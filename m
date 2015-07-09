From: eric.auger@linaro.org (Eric Auger)
Date: Thu,  9 Jul 2015 10:22:12 +0200
Subject: [PATCH v2 2/7] KVM: kvm_host: add devid in
 kvm_kernel_irq_routing_entry
In-Reply-To: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1436430137-24205-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend kvm_kernel_irq_routing_entry to transport devid. This is
needed for ARM. Its validity depends on the routing type entry.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v1 -> v2:
replace msi_msg field by a struct composed of msi_msg and devid

RFC -> PATCH:
- reword the commit message after change in first patch (uapi)
---
 include/linux/kvm_host.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9564fd7..cac0fe4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -321,7 +321,10 @@ struct kvm_kernel_irq_routing_entry {
 			unsigned irqchip;
 			unsigned pin;
 		} irqchip;
-		struct msi_msg msi;
+		struct {
+			struct msi_msg msi;
+			u32 devid;
+		};
 		struct kvm_s390_adapter_int adapter;
 	};
 	struct hlist_node link;
-- 
1.9.1
