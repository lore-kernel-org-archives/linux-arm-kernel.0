From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 6 Jan 2015 20:36:16 +0000 (UTC)
Subject: [PATCH 3/4] arm64: fix missing asm/alternative.h include in
 kernel/module.c
In-Reply-To: <20150106104008.GD4858@leverpostej>
References: <20150106014554.27249.89116.stgit@dusk.lan>
 <20150106015215.27249.86394.stgit@dusk.lan>
 <20150106104008.GD4858@leverpostej>
Message-ID: <alpine.DEB.2.02.1501062034560.28771@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 6 Jan 2015, Mark Rutland wrote:

> If this can move above the include of asm/insn.h:

Done; updated patch below.  

cheers,

- Paul


From: Paul Walmsley <pwalmsley@nvidia.com>
Date: Mon, 5 Jan 2015 17:38:41 -0700
Subject: [PATCH 3/4] arm64: fix missing asm/alternative.h include in kernel/module.c

On next-20150105, defconfig compilation breaks with:

arch/arm64/kernel/module.c:408:4: error: implicit declaration of function ?apply_alternatives? [-Werror=implicit-function-declaration]

Fix by including asm/alternative.h, where the apply_alternatives()
prototype is declared.

This second version incorporates a comment from Mark Rutland
<mark.rutland@arm.com> to keep the includes in alphabetical order
by filename.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index fd027b101de5..9b6f71db2709 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -25,6 +25,7 @@
 #include <linux/mm.h>
 #include <linux/moduleloader.h>
 #include <linux/vmalloc.h>
+#include <asm/alternative.h>
 #include <asm/insn.h>
 #include <asm/sections.h>
 
-- 
2.1.4
