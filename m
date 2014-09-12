From: cernekee@gmail.com (Kevin Cernekee)
Date: Thu, 11 Sep 2014 19:22:41 -0700
Subject: [PATCH 2/3] ARM: Remove redundant ARCH_SPARSEMEM_DEFAULT setting
In-Reply-To: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
References: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
Message-ID: <1410488562-21863-2-git-send-email-cernekee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If ARCH_SPARSEMEM_ENABLE=y and ARCH_{FLATMEM,DISCONTIGMEM}_ENABLE=n,
then the logic in mm/Kconfig already makes CONFIG_SPARSEMEM the only
choice.  This is true for all of the existing ARM users of
ARCH_SPARSEMEM_ENABLE.

Forcing ARCH_SPARSEMEM_DEFAULT=y if ARCH_SPARSEMEM_ENABLE=y prevents
us from ever defaulting to FLATMEM, so we should remove this setting.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/arm/Kconfig |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 32cbbd5..c3daeaf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1635,9 +1635,6 @@ config ARCH_HAS_HOLES_MEMORYMODEL
 config ARCH_SPARSEMEM_ENABLE
 	bool
 
-config ARCH_SPARSEMEM_DEFAULT
-	def_bool ARCH_SPARSEMEM_ENABLE
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
-- 
1.7.9.5
