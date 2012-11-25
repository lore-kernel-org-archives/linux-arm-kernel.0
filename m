From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 25 Nov 2012 19:10:15 +0400
Subject: [PATCH] ARM64: Remove incorrect Kconfig symbol HAVE_SPARSE_IRQ
Message-ID: <1353856215-5371-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel does not contain symbol HAVE_SPARSE_IRQ. Definition
in arch/arm64/Kconfig seems typo because valid symbol is
MAY_HAVE_SPARSE_IRQ.
In any case SPARSE_IRQ is selected by default and we just
remove selecting of this symbol.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm64/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 20b688c..c0e93ac 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -23,7 +23,6 @@ config ARM64
 	select HAVE_IRQ_WORK
 	select HAVE_MEMBLOCK
 	select HAVE_PERF_EVENTS
-	select HAVE_SPARSE_IRQ
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
-- 
1.7.8.6
