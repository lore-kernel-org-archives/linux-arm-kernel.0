From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 18 Oct 2016 20:31:43 +0100
Subject: [PATCH 3/3] ARM: wire up new pkey syscalls
Message-ID: <E1bwa6x-0004Ze-8l@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wire up the new pkey syscalls for ARM.  This illustrates the ease that
the generated/tabular approach gives us: adding new system calls
becomes much easier, and all the dependencies are automatically handled
for the update.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Of course, this is development, and there will be a patch for -rc2 to
wire these up in due course.  I'm using this as an illustration for
this approach - compared with f2335a2a0a59 ("ARM: wire up preadv2 and
pwritev2 syscalls") adding two syscalls, with a diffstat of:

 arch/arm/include/asm/unistd.h      | 2 +-
 arch/arm/include/uapi/asm/unistd.h | 2 ++
 arch/arm/kernel/calls.S            | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

vs this patch adding three plus reserving two, giving:

 arch/arm/tools/syscall.tbl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 62285cbd09c0..c2af3b281bcb 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -426,3 +426,8 @@
 391	common	copy_file_range		sys_copy_file_range
 392	common	preadv2			sys_preadv2
 393	common	pwritev2		sys_pwritev2
+394	common	pkey_mprotect		sys_pkey_mprotect
+395	common	pkey_alloc		sys_pkey_alloc
+396	common	pkey_free		sys_pkey_free
+# 397 for pkey_get
+# 398 for pkey_set
-- 
2.1.0
