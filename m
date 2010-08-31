From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Aug 2010 14:52:32 +0100
Subject: [PATCH] ARM: Mark CPU_32v6K as depended on CPU_V7
Message-ID: <20100831135126.19953.11529.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU_32v6K is selected by CPU_V7 but it only depends on CPU_V6.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

It would be nice to have this patch before 2.6.36 is released to avoid a
warning introduced by my kbuild patch to warn on selecting options with
unmet dependencies.

 arch/arm/mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 33c3f57..a0a2928 100644
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
