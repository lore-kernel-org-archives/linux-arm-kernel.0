From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 30 Aug 2013 15:59:57 -0700
Subject: [PATCH 4/4] ARM: KVM: Add newlines to panic strings
In-Reply-To: <1377903597-18704-1-git-send-email-christoffer.dall@linaro.org>
References: <1377903597-18704-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1377903597-18704-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The panic strings are hard to read and on narrow terminals some
characters are simply truncated off the panic message.

Make is slightly prettier with a newline in the Hyp panic strings.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/interrupts.S |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 16cd4ba..85dd84b 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -492,10 +492,10 @@ __kvm_hyp_code_end:
 	.section ".rodata"
 
 und_die_str:
-	.ascii	"unexpected undefined exception in Hyp mode at: %#08x"
+	.ascii	"unexpected undefined exception in Hyp mode at: %#08x\n"
 pabt_die_str:
-	.ascii	"unexpected prefetch abort in Hyp mode at: %#08x"
+	.ascii	"unexpected prefetch abort in Hyp mode at: %#08x\n"
 dabt_die_str:
-	.ascii	"unexpected data abort in Hyp mode at: %#08x"
+	.ascii	"unexpected data abort in Hyp mode at: %#08x\n"
 svc_die_str:
-	.ascii	"unexpected HVC/SVC trap in Hyp mode at: %#08x"
+	.ascii	"unexpected HVC/SVC trap in Hyp mode at: %#08x\n"
-- 
1.7.10.4
