From: labbott@redhat.com (Laura Abbott)
Date: Thu,  5 Jul 2018 17:49:39 -0700
Subject: [PATCHv6 3/4] powerpc: Add build salt to the vDSO
In-Reply-To: <20180706004940.32587-1-labbott@redhat.com>
References: <20180706004940.32587-1-labbott@redhat.com>
Message-ID: <20180706004940.32587-4-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vDSO needs to have a unique build id in a similar manner
to the kernel and modules. Use the build salt macro.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v6: Remove semi-colon
---
 arch/powerpc/kernel/vdso32/note.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/vdso32/note.S b/arch/powerpc/kernel/vdso32/note.S
index d4b5be4f3d5f..227a7327399e 100644
--- a/arch/powerpc/kernel/vdso32/note.S
+++ b/arch/powerpc/kernel/vdso32/note.S
@@ -5,6 +5,7 @@
 
 #include <linux/uts.h>
 #include <linux/version.h>
+#include <linux/build-salt.h>
 
 #define ASM_ELF_NOTE_BEGIN(name, flags, vendor, type)			      \
 	.section name, flags;						      \
@@ -23,3 +24,5 @@
 	ASM_ELF_NOTE_BEGIN(".note.kernel-version", "a", UTS_SYSNAME, 0)
 	.long LINUX_VERSION_CODE
 	ASM_ELF_NOTE_END
+
+BUILD_SALT
-- 
2.17.1
