From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Oct 2012 17:46:37 +0100
Subject: [PATCH 1/4] arm64: Select MODULES_USE_ELF_RELA
In-Reply-To: <1350406000-30882-1-git-send-email-catalin.marinas@arm.com>
References: <1350406000-30882-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1350406000-30882-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 786d35d4 (make most arch asm/module.h files use
asm-generic/module.h) arm64 needs to enable MODULES_USE_ELF_RELA for
loadable modules.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7ff68c9..ef54a59 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -22,6 +22,7 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_SPARSE_IRQ
 	select IRQ_DOMAIN
+	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
 	select OF
 	select OF_EARLY_FLATTREE
