From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  2 Apr 2015 11:05:22 +0100
Subject: [PATCH 18/27] KVM: arm/arm64: remove now unneeded include directory
 from Makefile
In-Reply-To: <1427969131-8445-1-git-send-email-marc.zyngier@arm.com>
References: <1427969131-8445-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1427969131-8445-19-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

virt/kvm was never really a good include directory for anything else
than locally included headers.
With the move of iodev.h there is no need anymore to add this
directory the compiler's include path, so remove it from the arm and
arm64 kvm Makefile.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/Makefile   | 2 +-
 arch/arm64/kvm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index a093bf1..139e46c 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -7,7 +7,7 @@ ifeq ($(plus_virt),+virt)
 	plus_virt_def := -DREQUIRES_VIRT=1
 endif
 
-ccflags-y += -Ivirt/kvm -Iarch/arm/kvm
+ccflags-y += -Iarch/arm/kvm
 CFLAGS_arm.o := -I. $(plus_virt_def)
 CFLAGS_mmu.o := -I.
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index b22c636..d5904f8 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Kernel-based Virtual Machine module
 #
 
-ccflags-y += -Ivirt/kvm -Iarch/arm64/kvm
+ccflags-y += -Iarch/arm64/kvm
 CFLAGS_arm.o := -I.
 CFLAGS_mmu.o := -I.
 
-- 
2.1.4
