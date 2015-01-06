From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 05 Jan 2015 18:52:26 -0700
Subject: [PATCH 4/4] arm64: fix missing asm/io.h include in
 kernel/smp_spin_table.c
In-Reply-To: <20150106014554.27249.89116.stgit@dusk.lan>
References: <20150106014554.27249.89116.stgit@dusk.lan>
Message-ID: <20150106015220.27249.74970.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On next-20150105, defconfig compilation breaks with:

arch/arm64/kernel/smp_spin_table.c:80:2: error: implicit declaration of function ?ioremap_cache? [-Werror=implicit-function-declaration]
arch/arm64/kernel/smp_spin_table.c:92:2: error: implicit declaration of function ?writeq_relaxed? [-Werror=implicit-function-declaration]
arch/arm64/kernel/smp_spin_table.c:101:2: error: implicit declaration of function ?iounmap? [-Werror=implicit-function-declaration]

Fix by including asm/io.h, which contains definitions or prototypes
for these macros or functions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/smp_spin_table.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 4f93c67e63de..4d9f10b9d869 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -26,6 +26,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/cputype.h>
 #include <asm/smp_plat.h>
+#include <asm/io.h>
 
 extern void secondary_holding_pen(void);
 volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
