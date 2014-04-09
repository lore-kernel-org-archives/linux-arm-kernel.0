From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Wed,  9 Apr 2014 17:50:37 +0100
Subject: [RFC PATCH 2/3] ARM: Kconfig: remove dependence of
 CONFIG_DEBUG_RODATA on !kexec
In-Reply-To: <1397062238-10515-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1397062238-10515-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <1397062238-10515-3-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 3c7adea..ed58326 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -970,7 +970,7 @@ config ARM_KERNMEM_PERMS
 
 config DEBUG_RODATA
 	bool "Make kernel text and rodata read-only"
-	depends on ARM_KERNMEM_PERMS && KEXEC=n && KPROBES=n
+	depends on ARM_KERNMEM_PERMS && KPROBES=n
 	default y
 	help
 	  If this is set, kernel text and rodata will be made read-only.
-- 
1.8.1.5
