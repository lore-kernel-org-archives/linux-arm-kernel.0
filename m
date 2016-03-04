From: geoff@infradead.org (Geoff Levand)
Date: Fri, 04 Mar 2016 23:51:15 +0000
Subject: [PATCH v14 20/20] arm64: kdump: update a kernel doc
In-Reply-To: <cover.1457135058.git.geoff@infradead.org>
References: <cover.1457135058.git.geoff@infradead.org>
Message-ID: <b434c117ad29c98c7a3b9b36a52dc2f93f6aab99.1457135058.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This patch adds arch specific descriptions about kdump usage on arm64
to kdump.txt.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 Documentation/kdump/kdump.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index bc4bd5a..acc4d98 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
 a remote system.
 
 Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
-s390x and arm architectures.
+s390x, arm and arm64 architectures.
 
 When the system kernel boots, it reserves a small section of memory for
 the dump-capture kernel. This ensures that ongoing Direct Memory Access
@@ -249,6 +249,12 @@ Dump-capture kernel config options (Arch Dependent, arm)
 
     AUTO_ZRELADDR=y
 
+Dump-capture kernel config options (Arch Dependent, arm64)
+----------------------------------------------------------
+
+1) Currently, kvm will not be enabled on the dump-capture kernel even
+   if it is configured.
+
 Extended crashkernel syntax
 ===========================
 
@@ -312,6 +318,8 @@ Boot into System Kernel
    any space below the alignment point may be overwritten by the dump-capture kernel,
    which means it is possible that the vmcore is not that precise as expected.
 
+   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
+   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
 
 Load the Dump-capture Kernel
 ============================
@@ -334,6 +342,8 @@ For s390x:
 	- Use image or bzImage
 For arm:
 	- Use zImage
+For arm64:
+	- Use vmlinux or Image
 
 If you are using a uncompressed vmlinux image then use following command
 to load dump-capture kernel.
@@ -377,6 +387,9 @@ For s390x:
 For arm:
 	"1 maxcpus=1 reset_devices"
 
+For arm64:
+	"1 maxcpus=1 reset_devices"
+
 Notes on loading the dump-capture kernel:
 
 * By default, the ELF headers are stored in ELF64 format to support
-- 
2.5.0
