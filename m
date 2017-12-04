From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon,  4 Dec 2017 11:57:58 +0900
Subject: [PATCH v7 08/11] arm64: kexec_file: enable KEXEC_FILE config
In-Reply-To: <20171204025801.12161-1-takahiro.akashi@linaro.org>
References: <20171204025801.12161-1-takahiro.akashi@linaro.org>
Message-ID: <20171204025801.12161-9-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify arm64/Kconfig and Makefile to enable kexec_file_load support.
File-format specific hook functions to load a kernel image will
follow this patch.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a93339f5178f..865d110809f9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -794,6 +794,19 @@ config KEXEC
 	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
+config KEXEC_FILE
+	bool "kexec file based system call"
+	select KEXEC_CORE
+	select BUILD_BIN2C
+	---help---
+	  This is new version of kexec system call. This system call is
+	  file based and takes file descriptors as system call argument
+	  for kernel and initramfs as opposed to list of segments as
+	  accepted by previous system call.
+
+	  In addition to this option, you need to enable a specific type
+	  of image support.
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
-- 
2.14.1
