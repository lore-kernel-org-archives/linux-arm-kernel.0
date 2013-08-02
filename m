From: roy.franz@linaro.org (Roy Franz)
Date: Fri,  2 Aug 2013 14:29:08 -0700
Subject: [PATCH 7/7] Add config EFI_STUB for ARM
In-Reply-To: <1375478948-22562-1-git-send-email-roy.franz@linaro.org>
References: <1375478948-22562-1-git-send-email-roy.franz@linaro.org>
Message-ID: <1375478948-22562-8-git-send-email-roy.franz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Roy Franz <roy.franz@linaro.org>
---
 arch/arm/Kconfig |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 37c0f4e..192968c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1805,6 +1805,16 @@ config UACCESS_WITH_MEMCPY
 	  However, if the CPU data cache is using a write-allocate mode,
 	  this option is unlikely to provide any performance gain.
 
+config EFI_STUB
+	bool "EFI stub support"
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
