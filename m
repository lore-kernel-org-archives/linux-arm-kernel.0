From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  9 Dec 2014 12:26:03 +0100
Subject: [GIT PULL 4/9] kvm: add a memslot flag for incoherent memory regions
In-Reply-To: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418124368-28418-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Memory regions may be incoherent with the caches, typically when the
guest has mapped a host system RAM backed memory region as uncached.
Add a flag KVM_MEMSLOT_INCOHERENT so that we can tag these memslots
and handle them appropriately when mapping them.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a6059bd..e4d8f70 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -43,6 +43,7 @@
  * include/linux/kvm_h.
  */
 #define KVM_MEMSLOT_INVALID	(1UL << 16)
+#define KVM_MEMSLOT_INCOHERENT	(1UL << 17)
 
 /* Two fragments for cross MMIO pages. */
 #define KVM_MAX_MMIO_FRAGMENTS	2
-- 
2.1.2.330.g565301e.dirty
