From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 May 2013 12:36:06 +0100
Subject: [PATCHv3 1/5] ARM: hyp: initialize CNTVOFF to zero
In-Reply-To: <1369395370-21358-1-git-send-email-mark.rutland@arm.com>
References: <1369395370-21358-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1369395370-21358-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <Marc.Zyngier@arm.com>

In order to be able to use the virtual counter in a safe way,
make sure it is initialized to zero before dropping to SVC.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/hyp-stub.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 1315c4c..dbe2110 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -153,6 +153,8 @@ THUMB(	orr	r7, #(1 << 30)	)	@ HSCTLR.TE
 	mrc	p15, 4, r7, c14, c1, 0	@ CNTHCTL
 	orr	r7, r7, #3		@ PL1PCEN | PL1PCTEN
 	mcr	p15, 4, r7, c14, c1, 0	@ CNTHCTL
+	mov	r7, #0
+	mcrr	p15, 4, r7, r7, c14	@ CNTVOFF
 1:
 #endif
 
-- 
1.8.1.1
