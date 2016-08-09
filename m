From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  9 Aug 2016 10:56:15 +0900
Subject: [PATCH v24 8/9] arm64: kdump: update a kernel doc
In-Reply-To: <20160809015615.28527-1-takahiro.akashi@linaro.org>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015615.28527-1-takahiro.akashi@linaro.org>
Message-ID: <20160809015615.28527-6-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds arch specific descriptions about kdump usage on arm64
to kdump.txt.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Baoquan He <bhe@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
---
 Documentation/kdump/kdump.txt | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 88ff63d..c090531 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
 a remote system.
 
 Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
-s390x and arm architectures.
+s390x, arm and arm64 architectures.
 
 When the system kernel boots, it reserves a small section of memory for
 the dump-capture kernel. This ensures that ongoing Direct Memory Access
@@ -249,6 +249,13 @@ Dump-capture kernel config options (Arch Dependent, arm)
 
     AUTO_ZRELADDR=y
 
+Dump-capture kernel config options (Arch Dependent, arm64)
+----------------------------------------------------------
+
+- Please note that kvm of the dump-capture kernel will not be enabled
+  on non-VHE systems even if it is configured. This is because the CPU
+  cannot be reset to EL2 on panic.
+
 Extended crashkernel syntax
 ===========================
 
@@ -305,6 +312,8 @@ Boot into System Kernel
    kernel will automatically locate the crash kernel image within the
    first 512MB of RAM if X is not given.
 
+   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
+   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
 
 Load the Dump-capture Kernel
 ============================
@@ -327,6 +336,8 @@ For s390x:
 	- Use image or bzImage
 For arm:
 	- Use zImage
+For arm64:
+	- Use vmlinux or Image
 
 If you are using a uncompressed vmlinux image then use following command
 to load dump-capture kernel.
@@ -370,6 +381,9 @@ For s390x:
 For arm:
 	"1 maxcpus=1 reset_devices"
 
+For arm64:
+	"1 maxcpus=1 reset_devices"
+
 Notes on loading the dump-capture kernel:
 
 * By default, the ELF headers are stored in ELF64 format to support
-- 
2.9.0
