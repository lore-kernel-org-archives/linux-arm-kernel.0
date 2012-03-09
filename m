From: rusty@rustcorp.com.au (Rusty Russell)
Date: Fri, 09 Mar 2012 14:56:52 +1030
Subject: [PATCH 1/8] ARM: KVM: Fix missing clobber (causes host oops on UP)
Message-ID: <1331267212.8104.rusty@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Rusty Russell <rusty@rustcorp.com.au>

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/arm/kvm/arm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3772847..f27a96b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -585,7 +585,7 @@ static void cpu_set_vector(void *vector)
 		"smc	#0\n\t" : :
 		[vector_ptr] "r" (vector_ptr),
 		[smc_hyp_nr] "r" (smc_hyp_nr) :
-		"r0", "r1");
+		"r0", "r1", "r7");
 }
 
 static void cpu_init_hyp_mode(void *vector)
