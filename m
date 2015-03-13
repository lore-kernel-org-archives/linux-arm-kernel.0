From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 13 Mar 2015 16:10:03 +0000
Subject: [PATCH 03/12] KVM: arm/arm64: remove now unneeded include directory
 from Makefile
In-Reply-To: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
References: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1426263012-22935-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virt/kvm was never really a good include directory for anything else
than locally included headers.
With the move of iodev.h there is no need anymore to add this
directory the compiler's include path, so remove it from the arm and
arm64 kvm Makefile.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/kvm/Makefile   |    2 +-
 arch/arm64/kvm/Makefile |    2 +-
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
1.7.9.5
