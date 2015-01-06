From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 6 Jan 2015 20:30:59 +0000 (UTC)
Subject: [PATCH 2/4] arm64: fix missing linux/bug.h include in
 asm/arch_timer.h
In-Reply-To: <20150106102736.GA4858@leverpostej>
References: <20150106014554.27249.89116.stgit@dusk.lan>
 <20150106015210.27249.91222.stgit@dusk.lan>
 <20150106102736.GA4858@leverpostej>
Message-ID: <alpine.DEB.2.02.1501062029140.28771@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 6 Jan 2015, Mark Rutland wrote:

> Nit: could you move this above the include of linux/init.h so as to keep
> these in alphabetical order?

Done.  Updated patch below.  Thanks for the review,


- Paul

From: Paul Walmsley <pwalmsley@nvidia.com>
Date: Mon, 5 Jan 2015 17:38:41 -0700
Subject: [PATCH 2/4] arm64: fix missing linux/bug.h include in asm/arch_timer.h

On next-20150105, defconfig compilation breaks with:

./arch/arm64/include/asm/arch_timer.h:112:2: error: implicit declaration of function ?BUG? [-Werror=implicit-function-declaration]

Fix by including linux/bug.h, where the BUG macro is defined.

This second version incorporates a comment from Mark Rutland
<mark.rutland@arm.com> to keep the includes in alphabetical order
by filename.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/arch_timer.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index b1fa4e614718..fbe0ca31a99c 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -21,6 +21,7 @@
 
 #include <asm/barrier.h>
 
+#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/types.h>
 
-- 
2.1.4
