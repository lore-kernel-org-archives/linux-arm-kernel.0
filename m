From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jun 2018 13:49:53 +0100
Subject: [PATCH 8/8] KVM: arm64: Prevent KVM_COMPAT from being selected
In-Reply-To: <20180622124953.12355-1-marc.zyngier@arm.com>
References: <20180622124953.12355-1-marc.zyngier@arm.com>
Message-ID: <20180622124953.12355-9-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is very little point in trying to support the 32bit KVM/arm API
on arm64, and this was never an anticipated use case.

Let's make it clear by not selecting KVM_COMPAT.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 72143cfaf6ec..ea434ddc8499 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -47,7 +47,7 @@ config KVM_GENERIC_DIRTYLOG_READ_PROTECT
 
 config KVM_COMPAT
        def_bool y
-       depends on KVM && COMPAT && !S390
+       depends on KVM && COMPAT && !(S390 || ARM64)
 
 config HAVE_KVM_IRQ_BYPASS
        bool
-- 
2.17.1
