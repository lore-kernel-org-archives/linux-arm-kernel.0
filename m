From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Aug 2013 21:13:01 -0700
Subject: [PATCH 4/4] KVM: ARM: Squash len warning
In-Reply-To: <1376280781-6539-1-git-send-email-christoffer.dall@linaro.org>
References: <1376280781-6539-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1376280781-6539-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'len' variable was declared an unsigned and then checked for less
than 0, which results in warnings on some compilers.  Since len is
assigned an int, make it an int.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index b8e06b7..0c25d94 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -63,7 +63,8 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		      struct kvm_exit_mmio *mmio)
 {
-	unsigned long rt, len;
+	unsigned long rt;
+	int len;
 	bool is_write, sign_extend;
 
 	if (kvm_vcpu_dabt_isextabt(vcpu)) {
-- 
1.7.10.4
