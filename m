From: roy.franz@linaro.org (Roy Franz)
Date: Fri,  9 Aug 2013 16:26:17 -0700
Subject: [PATCH 16/16] Add config EFI_STUB for ARM to Kconfig
In-Reply-To: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
Message-ID: <1376090777-20090-17-git-send-email-roy.franz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Roy Franz <roy.franz@linaro.org>
---
 arch/arm/Kconfig |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43594d5..8607d03 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1805,6 +1805,17 @@ config UACCESS_WITH_MEMCPY
 	  However, if the CPU data cache is using a write-allocate mode,
 	  this option is unlikely to provide any performance gain.
 
+config EFI_STUB
+	bool "EFI stub support"
+	depends on EFI
+	---help---
+	  This kernel feature allows a zImage to be loaded directly
+	  by EFI firmware without the use of a bootloader.  A PE/COFF
+	  header is added to the zImage in a way that makes the binary
+	  both a Linux zImage and an PE/COFF executable that can be
+	  executed directly by EFI firmware.
+	  See Documentation/efi-stub.txt for more information.
+
 config SECCOMP
 	bool
 	prompt "Enable seccomp to safely compute untrusted bytecode"
-- 
1.7.10.4
