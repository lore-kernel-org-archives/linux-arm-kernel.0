From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  8 Jan 2014 14:47:30 -0800
Subject: [PATCH 5/5] KVM: ARM: Remove duplicate include
In-Reply-To: <1389221250-30034-1-git-send-email-christoffer.dall@linaro.org>
References: <1389221250-30034-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1389221250-30034-6-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sachin Kamat <sachin.kamat@linaro.org>

trace.h was included twice. Remove duplicate inclusion.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/handle_exit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index a920790..0de91fc 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -26,8 +26,6 @@
 
 #include "trace.h"
 
-#include "trace.h"
-
 typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
 
 static int handle_svc_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
-- 
1.8.5.2
