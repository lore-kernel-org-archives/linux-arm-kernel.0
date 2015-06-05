From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu,  4 Jun 2015 18:58:37 -0700
Subject: [PATCH 2/3] ARM: Remove redundant ARCH_SPARSEMEM_DEFAULT setting
In-Reply-To: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
References: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1433469518-8472-3-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Cernekee <cernekee@gmail.com>

If ARCH_SPARSEMEM_ENABLE=y and ARCH_{FLATMEM,DISCONTIGMEM}_ENABLE=n,
then the logic in mm/Kconfig already makes CONFIG_SPARSEMEM the only
choice.  This is true for all of the existing ARM users of
ARCH_SPARSEMEM_ENABLE.

Forcing ARCH_SPARSEMEM_DEFAULT=y if ARCH_SPARSEMEM_ENABLE=y prevents
us from ever defaulting to FLATMEM, so we should remove this setting.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 arch/arm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48b..5998b53 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1628,9 +1628,6 @@ config ARCH_HAS_HOLES_MEMORYMODEL
 config ARCH_SPARSEMEM_ENABLE
 	bool
 
-config ARCH_SPARSEMEM_DEFAULT
-	def_bool ARCH_SPARSEMEM_ENABLE
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
-- 
1.9.1
