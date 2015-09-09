From: tushar.jagad@linaro.org (Tushar Jagad)
Date: Wed,  9 Sep 2015 14:08:34 +0530
Subject: [PATCH RFC 4/4] arm/arm64: kvm: Disable comparision of cpu and vcpu
 target
In-Reply-To: <1441787914-3191-1-git-send-email-tushar.jagad@linaro.org>
References: <1441787914-3191-1-git-send-email-tushar.jagad@linaro.org>
Message-ID: <1441787914-3191-5-git-send-email-tushar.jagad@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch disables comparison of physical cpu and vcpu for supporting
cross cpu guests.

Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
---
 arch/arm/kvm/arm.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 8907d37..b3214b2 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -698,11 +698,6 @@ static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 	unsigned int i;
 	u64 aa64dfr;
 
-	int phys_target = kvm_target_cpu();
-
-	if (init->target != phys_target)
-		return -EINVAL;
-
 	/*
 	 * Secondary and subsequent calls to KVM_ARM_VCPU_INIT must
 	 * use the same target.
-- 
1.7.9.5
