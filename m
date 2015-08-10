From: zhichao.huang@linaro.org (Zhichao Huang)
Date: Mon, 10 Aug 2015 21:26:07 +0800
Subject: [PATCH v4 15/15] KVM: arm: enable trapping of all debug registers
In-Reply-To: <1439213167-8988-1-git-send-email-zhichao.huang@linaro.org>
References: <1439213167-8988-1-git-send-email-zhichao.huang@linaro.org>
Message-ID: <1439213167-8988-16-git-send-email-zhichao.huang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable trapping of the debug registers unconditionally, allowing guests to
use the debug infrastructure.

Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/interrupts_head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 7ad0adf..494991d 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -792,7 +792,7 @@ ARM_BE8(rev	r6, r6  )
  * (hardware reset value is 0) */
 .macro set_hdcr operation
 	mrc	p15, 4, r2, c1, c1, 1
-	ldr	r3, =(HDCR_TPM|HDCR_TPMCR)
+	ldr	r3, =(HDCR_TPM|HDCR_TPMCR|HDCR_TDRA|HDCR_TDOSA|HDCR_TDA)
 	.if \operation == vmentry
 	orr	r2, r2, r3		@ Trap some perfmon accesses
 	.else
-- 
1.7.12.4
