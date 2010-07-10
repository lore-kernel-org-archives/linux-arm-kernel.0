From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 10 Jul 2010 10:02:12 +0100
Subject: [PATCH] ARM: Mark CPU_32v6K as depended on CPU_V7
Message-ID: <20100710090031.2668.97891.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU_32v6K is selected by CPU_V7 but it only depends on CPU_V6.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

I pushed a kbuild patch to the -next tree which warns when selecting
symbols with unmet dependencies. CPU_32v6K is one of those cases
(selected by CPU_V7).

 arch/arm/mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 4e93c4a..bad0d73 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -398,7 +398,7 @@ config CPU_V6
 # ARMv6k
 config CPU_32v6K
 	bool "Support ARM V6K processor extensions" if !SMP
-	depends on CPU_V6
+	depends on CPU_V6 || CPU_V7
 	default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
 	help
 	  Say Y here if your ARMv6 processor supports the 'K' extension.
