From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 6 Jan 2015 20:32:22 +0000 (UTC)
Subject: [PATCH 4/4] arm64: fix missing asm/io.h include in
 kernel/smp_spin_table.c
In-Reply-To: <20150106103404.GB4858@leverpostej>
References: <20150106014554.27249.89116.stgit@dusk.lan>
 <20150106015220.27249.74970.stgit@dusk.lan>
 <20150106103404.GB4858@leverpostej>
Message-ID: <alpine.DEB.2.02.1501062031170.28771@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 6 Jan 2015, Mark Rutland wrote:

> Nit: please move between the include of asm/cputype and asm/smp_plat.h,
> so as to keep the list in alphabetical order.

Done.  Updated patch below.  Thanks for the review,


- Paul


From: Paul Walmsley <pwalmsley@nvidia.com>
Date: Mon, 5 Jan 2015 17:38:42 -0700
Subject: [PATCH 4/4] arm64: fix missing asm/io.h include in kernel/smp_spin_table.c

On next-20150105, defconfig compilation breaks with:

arch/arm64/kernel/smp_spin_table.c:80:2: error: implicit declaration of function ?ioremap_cache? [-Werror=implicit-function-declaration]
arch/arm64/kernel/smp_spin_table.c:92:2: error: implicit declaration of function ?writeq_relaxed? [-Werror=implicit-function-declaration]
arch/arm64/kernel/smp_spin_table.c:101:2: error: implicit declaration of function ?iounmap? [-Werror=implicit-function-declaration]

Fix by including asm/io.h, which contains definitions or prototypes
for these macros or functions.

This second version incorporates a comment from Mark Rutland
<mark.rutland@arm.com> to keep the includes in alphabetical order
by filename.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/smp_spin_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 4f93c67e63de..14944e5b28da 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -25,6 +25,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 #include <asm/cputype.h>
+#include <asm/io.h>
 #include <asm/smp_plat.h>
 
 extern void secondary_holding_pen(void);
-- 
2.1.4
