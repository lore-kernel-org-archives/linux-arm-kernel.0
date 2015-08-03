From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  3 Aug 2015 19:20:40 +0200
Subject: [PATCH v4 1/5] KVM: x86: select IRQ_BYPASS_MANAGER
In-Reply-To: <1438622444-25444-1-git-send-email-eric.auger@linaro.org>
References: <1438622444-25444-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1438622444-25444-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Feng Wu <feng.wu@intel.com>

Select IRQ_BYPASS_MANAGER for x86 when CONFIG_KVM is set

Signed-off-by: Feng Wu <feng.wu@intel.com>
---
 arch/x86/kvm/Kconfig  | 2 ++
 arch/x86/kvm/Makefile | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index d8a1d56..c951d44 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -3,6 +3,7 @@
 #
 
 source "virt/kvm/Kconfig"
+source "virt/lib/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
@@ -28,6 +29,7 @@ config KVM
 	select ANON_INODES
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
+	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_EVENTFD
 	select KVM_APIC_ARCHITECTURE
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 67d215c..05cc2d7 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -6,6 +6,9 @@ CFLAGS_svm.o := -I.
 CFLAGS_vmx.o := -I.
 
 KVM := ../../../virt/kvm
+LIB := ../../../virt/lib
+
+obj-$(CONFIG_IRQ_BYPASS_MANAGER)	+= $(LIB)/
 
 kvm-y			+= $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
 				$(KVM)/eventfd.o $(KVM)/irqchip.o $(KVM)/vfio.o
-- 
1.9.1
