From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 6 Jan 2015 20:34:18 +0000 (UTC)
Subject: [PATCH 1/4] arm64: fix missing asm/pgtable-hwdef.h include in
 asm/processor.h
In-Reply-To: <20150106103722.GC4858@leverpostej>
References: <20150106014554.27249.89116.stgit@dusk.lan>
 <20150106015156.27249.32173.stgit@dusk.lan>
 <20150106103722.GC4858@leverpostej>
Message-ID: <alpine.DEB.2.02.1501062032420.28771@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 6 Jan 2015, Mark Rutland wrote:

> If you can move this above the include of asm/ptrace.h,

Done; updated patch below.  Thanks for the review,


- Paul

From: Paul Walmsley <pwalmsley@nvidia.com>
Date: Mon, 5 Jan 2015 17:38:41 -0700
Subject: [PATCH 1/4] arm64: fix missing asm/pgtable-hwdef.h include in asm/processor.h

On next-20150105, defconfig compilation breaks with:

./arch/arm64/include/asm/processor.h:47:32: error: ?PHYS_MASK? undeclared (first use in this function)

Fix by including asm/pgtable-hwdef.h, where PHYS_MASK is defined.

This second version incorporates a comment from Mark Rutland
<mark.rutland@arm.com> to keep the includes in alphabetical order
by filename.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/processor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 286b1bec547c..d646241a78f6 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -31,6 +31,7 @@
 
 #include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
-- 
2.1.4
