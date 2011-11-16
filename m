From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:20 -0500
Subject: [PATCH 02/23] ARM: mach-prima2: don't define SIRFSOC_VA in terms of
 VMALLOC_END
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

... since it is going to change.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Tested-by: Barry Song <baohua.song@csr.com>
---
 arch/arm/mach-prima2/include/mach/map.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-prima2/include/mach/map.h b/arch/arm/mach-prima2/include/mach/map.h
index 66b1ae2e55..6f24353257 100644
--- a/arch/arm/mach-prima2/include/mach/map.h
+++ b/arch/arm/mach-prima2/include/mach/map.h
@@ -9,8 +9,10 @@
 #ifndef __MACH_PRIMA2_MAP_H__
 #define __MACH_PRIMA2_MAP_H__
 
-#include <mach/vmalloc.h>
+#include <linux/const.h>
 
-#define SIRFSOC_VA(x)			(VMALLOC_END + ((x) & 0x00FFF000))
+#define SIRFSOC_VA_BASE		_AC(0xFEC00000, UL)
+
+#define SIRFSOC_VA(x)		(SIRFSOC_VA_BASE + ((x) & 0x00FFF000))
 
 #endif
-- 
1.7.7.1.431.g10b2a
