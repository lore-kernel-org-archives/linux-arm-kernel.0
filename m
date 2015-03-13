From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 13 Mar 2015 16:10:04 +0000
Subject: [PATCH 04/12] KVM: x86: remove now unneeded include directory from
 Makefile
In-Reply-To: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
References: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1426263012-22935-5-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virt/kvm was never really a good include directory for anything else
than locally included headers.
With the move of iodev.h there is no need anymore to add this
directory the compiler's include path, so remove it from the x86 kvm
Makefile.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/x86/kvm/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 08f790d..16e8f96 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -1,5 +1,5 @@
 
-ccflags-y += -Ivirt/kvm -Iarch/x86/kvm
+ccflags-y += -Iarch/x86/kvm
 
 CFLAGS_x86.o := -I.
 CFLAGS_svm.o := -I.
-- 
1.7.9.5
