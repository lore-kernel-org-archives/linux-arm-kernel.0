From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Mon, 12 May 2014 10:31:57 +0100
Subject: [PATCH 2/2] ARM: Kconfig: remove dependence of CONFIG_DEBUG_RODATA on
 !kexec
In-Reply-To: <1399887117-2605-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1399887117-2605-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <1399887117-2605-2-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove DEBUG_RODATA dependence on !kexec since "ARM: kexec: Make .text R/W in
machine_kexec" fixes the incompatibility between those 2
options.

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 3cd7c0a..a96f585 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -969,7 +969,7 @@ config ARM_KERNMEM_PERMS
 
 config DEBUG_RODATA
 	bool "Make kernel text and rodata read-only"
-	depends on ARM_KERNMEM_PERMS && KEXEC=n && KPROBES=n
+	depends on ARM_KERNMEM_PERMS && KPROBES=n
 	default y
 	help
 	  If this is set, kernel text and rodata will be made read-only.
-- 
1.8.1.5
