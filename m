From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat,  8 Oct 2016 22:20:11 +0200
Subject: [PATCH] KVM: arm64: Correct trace exception name after SError handling
Message-ID: <20161008202011.30835-1-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit 9aecafc8 introduced ARM_EXCEPTION_EL1_SERROR we should
adjust the description of the exception type for trace events.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_arm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 4b5c977..b942ce4 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -207,7 +207,8 @@
 
 #define kvm_arm_exception_type	\
 	{0, "IRQ" }, 		\
-	{1, "TRAP" }
+	{1, "SError" }, 	\
+	{2, "TRAP" }
 
 #define ECN(x) { ESR_ELx_EC_##x, #x }
 
-- 
2.9.0
