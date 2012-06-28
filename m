From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 28 Jun 2012 12:39:05 +0200
Subject: [PATCH] ARM: mxs/tx28: fix odd include
Message-ID: <1340879945.1911.49.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mxs/module-tx28.c includes "../devices-mx28.h". That's a
bit odd, because that header can be found in the same directory. This
only works because arch/arm/mach-mxs/include should be in the header
search path for this file. Nevertheless, this file can simply include
"device-mx28.h" (just as the four other files including that header do).

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Untested, but obviously correct.

 arch/arm/mach-mxs/module-tx28.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/module-tx28.c b/arch/arm/mach-mxs/module-tx28.c
index 9a7b08b..0f71f82 100644
--- a/arch/arm/mach-mxs/module-tx28.c
+++ b/arch/arm/mach-mxs/module-tx28.c
@@ -11,7 +11,7 @@
 #include <linux/gpio.h>
 
 #include <mach/iomux-mx28.h>
-#include "../devices-mx28.h"
+#include "devices-mx28.h"
 
 #include "module-tx28.h"
 
-- 
1.7.7.6
