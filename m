From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 08 Jun 2010 18:44:58 +0800
Subject: [PATCH 1/2] pxa: Move 'regs-ac97.h' from /mach-pxa/inlude/ to
	/plat-pxa/include
Message-ID: <4C0E1F2A.1060306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is two kinds of changes:
(1) Move 'regs-ac97.h' from /mach-pxa/inlude/ to /plat-pxa/include.

It will be the public header file If pxa168 ac97 driver was submitted.

(2) Modify the path of including header file.

Apply to (1).

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 .../mach => plat-pxa/include/plat}/regs-ac97.h     |    0
 sound/arm/pxa2xx-ac97-lib.c                        |    2 +-
 sound/arm/pxa2xx-ac97.c                            |    2 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |    2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/{mach-pxa/include/mach => plat-pxa/include/plat}/regs-ac97.h (100%)

diff --git a/arch/arm/mach-pxa/include/mach/regs-ac97.h b/arch/arm/plat-pxa/include/plat/regs-ac97.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/regs-ac97.h
rename to arch/arm/plat-pxa/include/plat/regs-ac97.h
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 88eec38..e40093c 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -21,7 +21,7 @@
 #include <sound/pxa2xx-lib.h>

 #include <asm/irq.h>
-#include <mach/regs-ac97.h>
+#include <plat/regs-ac97.h>
 #include <mach/audio.h>

 static DEFINE_MUTEX(car_mutex);
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 5d94118..246d0a1 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -20,7 +20,7 @@
 #include <sound/initval.h>
 #include <sound/pxa2xx-lib.h>

-#include <mach/regs-ac97.h>
+#include <plat/regs-ac97.h>
 #include <mach/audio.h>

 #include "pxa2xx-pcm.h"
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index d314115..173c476 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -20,9 +20,9 @@
 #include <sound/pxa2xx-lib.h>

 #include <mach/hardware.h>
-#include <mach/regs-ac97.h>
 #include <mach/dma.h>
 #include <mach/audio.h>
+#include <plat/regs-ac97.h>

 #include "pxa2xx-pcm.h"
 #include "pxa2xx-ac97.h"
-- 
1.6.3.3
