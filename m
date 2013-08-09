From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  8 Aug 2013 20:41:26 -0700
Subject: [PATCH] ARM: KVM: Simplify tracepoint text
Message-ID: <1376019686-19301-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tracepoint for kvm_guest_fault was extremely long, make it a
slightly bit shorter.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/trace.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index a8e73ed..8cbaea2 100644
--- a/arch/arm/kvm/trace.h
+++ b/arch/arm/kvm/trace.h
@@ -59,10 +59,9 @@ TRACE_EVENT(kvm_guest_fault,
 		__entry->ipa			= ipa;
 	),
 
-	TP_printk("guest fault at PC %#08lx (hxfar %#08lx, "
-		  "ipa %#16llx, hsr %#08lx",
-		  __entry->vcpu_pc, __entry->hxfar,
-		  __entry->ipa, __entry->hsr)
+	TP_printk("ipa 0x%llx, hsr 0x%#08lx, hxfar 0x%#08lx, pc 0x%#08lx",
+		  __entry->ipa, __entry->hsr,
+		  __entry->hxfar, __entry->vcpu_pc)
 );
 
 TRACE_EVENT(kvm_irq_line,
-- 
1.7.10.4
