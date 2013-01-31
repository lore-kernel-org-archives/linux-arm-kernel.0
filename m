From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:38 +0000
Subject: [PATCHv5 15/16] ARM: hyp: initialize CNTVOFF to zero
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1359634539-9580-16-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <Marc.Zyngier@arm.com>

In order to be able to use the virtual counter in a safe way,
make sure it is initialized to zero before dropping to SVC.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
---
 arch/arm/kernel/hyp-stub.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 65b2417..455603a 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -152,6 +152,9 @@ THUMB(	orr	r7, #(1 << 30)	)	@ HSCTLR.TE
 	mrc	p15, 4, r7, c14, c1, 0	@ CNTHCTL
 	orr	r7, r7, #3		@ PL1PCEN | PL1PCTEN
 	mcr	p15, 4, r7, c14, c1, 0	@ CNTHCTL
+	mov	r6, #0
+	mov	r7, #0
+	mcrr	p15, 4, r6, r7, c14	@ CNTVOFF
 1:
 #endif
 
-- 
1.8.1.1
