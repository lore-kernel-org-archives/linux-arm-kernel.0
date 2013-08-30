From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 30 Aug 2013 15:59:56 -0700
Subject: [PATCH 3/4] ARM: KVM: Work around older compiler bug
In-Reply-To: <1377903597-18704-1-git-send-email-christoffer.dall@linaro.org>
References: <1377903597-18704-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1377903597-18704-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compilers before 4.6 do not behave well with unnamed fields in structure
initializers and therefore produces build errors:
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=10676

By refering to the unnamed union using braces, both older and newer
compilers produce the same result.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reported-by: Russell King <linux@arm.linux.org.uk>
Tested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/reset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index b7840e7..71e08ba 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -40,7 +40,7 @@ static struct kvm_regs a15_regs_reset = {
 };
 
 static const struct kvm_irq_level a15_vtimer_irq = {
-	.irq = 27,
+	{ .irq = 27 },
 	.level = 1,
 };
 
-- 
1.7.10.4
