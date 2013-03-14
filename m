From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 14 Mar 2013 13:27:43 +0200
Subject: [PATCH 4/4] arch: cris: amend Kconfig after mtdchar merge
In-Reply-To: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
References: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
Message-ID: <1363260463-10609-4-git-send-email-dedekind1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The mtdchar module was merged with the mtdcore module, which means that the
MTD_CHAR Kconfig symbol does not exist any more.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/cris/Kconfig                  |    1 -
 arch/cris/arch-v32/drivers/Kconfig |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index bb0ac66..2d15a46 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -264,7 +264,6 @@ config ETRAX_AXISFLASHMAP
 	select MTD_CFI
 	select MTD_CFI_AMDSTD
 	select MTD_JEDECPROBE if ETRAX_ARCH_V32
-	select MTD_CHAR
 	select MTD_BLOCK
 	select MTD_COMPLEX_MAPPINGS
 	help
diff --git a/arch/cris/arch-v32/drivers/Kconfig b/arch/cris/arch-v32/drivers/Kconfig
index af4a486..c55971a 100644
--- a/arch/cris/arch-v32/drivers/Kconfig
+++ b/arch/cris/arch-v32/drivers/Kconfig
@@ -404,7 +404,6 @@ config ETRAX_AXISFLASHMAP
 	select MTD_CFI
 	select MTD_CFI_AMDSTD
 	select MTD_JEDECPROBE
-	select MTD_CHAR
 	select MTD_BLOCK
 	select MTD_COMPLEX_MAPPINGS
 	help
-- 
1.7.10.4
