From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 19 Oct 2017 16:45:13 +0100
Subject: [PATCH 2/2] arm/arm64: kvm: Disable branch profiling in HYP code
In-Reply-To: <1508427913-34619-1-git-send-email-julien.thierry@arm.com>
References: <1508427913-34619-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1508427913-34619-3-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When HYP code runs into branch profiling code, it attempts to jump to
unmapped memory, causing a HYP Panic.

Disable the branch profiling for code designed to run at HYP mode.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: <stable@vger.kernel.org>
---
 arch/arm/kvm/hyp/Makefile   | 2 +-
 arch/arm64/kvm/hyp/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
index 8679405..92eab1d 100644
--- a/arch/arm/kvm/hyp/Makefile
+++ b/arch/arm/kvm/hyp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Kernel-based Virtual Machine module, HYP part
 #

-ccflags-y += -fno-stack-protector
+ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING

 KVM=../../../../virt/kvm

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 14c4e3b..48b0354 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Kernel-based Virtual Machine module, HYP part
 #

-ccflags-y += -fno-stack-protector
+ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING

 KVM=../../../../virt/kvm

--
1.9.1
