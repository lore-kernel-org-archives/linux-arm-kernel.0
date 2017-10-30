From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 30 Oct 2017 03:55:59 +0100
Subject: [PULL 4/8] arm/arm64: kvm: Disable branch profiling in HYP code
In-Reply-To: <20171030025603.23550-1-christoffer.dall@linaro.org>
References: <20171030025603.23550-1-christoffer.dall@linaro.org>
Message-ID: <20171030025603.23550-5-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Thierry <julien.thierry@arm.com>

When HYP code runs into branch profiling code, it attempts to jump to
unmapped memory, causing a HYP Panic.

Disable the branch profiling for code designed to run at HYP mode.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/hyp/Makefile   | 2 +-
 arch/arm64/kvm/hyp/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
index 8679405b0b2b..92eab1d51785 100644
--- a/arch/arm/kvm/hyp/Makefile
+++ b/arch/arm/kvm/hyp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Kernel-based Virtual Machine module, HYP part
 #
 
-ccflags-y += -fno-stack-protector
+ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING
 
 KVM=../../../../virt/kvm
 
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 14c4e3b14bcb..48b03547a969 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Kernel-based Virtual Machine module, HYP part
 #
 
-ccflags-y += -fno-stack-protector
+ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING
 
 KVM=../../../../virt/kvm
 
-- 
2.14.2
