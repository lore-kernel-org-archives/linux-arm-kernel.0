From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 28 Sep 2009 20:51:27 +0200
Subject: [PATCH] Fix bcmring compile
Message-ID: <1254163887-2730-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The movement of the MMCI header file made bcmring break. It turns
out it was including asm/mmc.h without using it so fixing the
problem boils down to removing the offending include.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-bcmring/core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index 492c649..b53b973 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -45,7 +45,6 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <asm/mach/mmc.h>
 
 #include <cfg_global.h>
 
-- 
1.6.2.1
