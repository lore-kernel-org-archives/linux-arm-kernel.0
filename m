From: wcohen@redhat.com (William Cohen)
Date: Tue, 29 May 2012 10:45:59 -0400
Subject: [PATCH] Avoid needing export of include/asm-generic/kvm_para.h
In-Reply-To: <1338302759-12364-1-git-send-email-wcohen@redhat.com>
References: <1338302759-12364-1-git-send-email-wcohen@redhat.com>
Message-ID: <1338302759-12364-2-git-send-email-wcohen@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The include/asm-generic/kvm_para.h is not normally an exported file.
If it is used in $(srctree)/arch/$(SRCARCH)/include/asm/kvm_para.h,
later checks will flag that as an error because the
asm-generic/kvm_para.h head is not installed.  The
asm-generic/kvm_para.h has information that is only used during the
build of the kernel and should not be exported. The
arch/arm/include/asm/kvm_para.h should be a generic generated file
instead.

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 arch/arm/include/asm/Kbuild     |    1 +
 arch/arm/include/asm/kvm_para.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 arch/arm/include/asm/kvm_para.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 960abce..3f45eb9 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -10,6 +10,7 @@ generic-y += errno.h
 generic-y += ioctl.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += percpu.h
diff --git a/arch/arm/include/asm/kvm_para.h b/arch/arm/include/asm/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/arch/arm/include/asm/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
-- 
1.7.10.1
