From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 05 Jan 2015 18:52:15 -0700
Subject: [PATCH 2/4] arm64: fix missing linux/bug.h include in asm/arch_timer.h
In-Reply-To: <20150106014554.27249.89116.stgit@dusk.lan>
References: <20150106014554.27249.89116.stgit@dusk.lan>
Message-ID: <20150106015210.27249.91222.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On next-20150105, defconfig compilation breaks with:

./arch/arm64/include/asm/arch_timer.h:112:2: error: implicit declaration of function ?BUG? [-Werror=implicit-function-declaration]

Fix by including linux/bug.h, where the BUG macro is defined.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/arch_timer.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index b1fa4e614718..779455564c9a 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -23,6 +23,7 @@
 
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/bug.h>
 
 #include <clocksource/arm_arch_timer.h>
 
