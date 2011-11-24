From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 25 Nov 2011 01:00:36 +0400
Subject: [PATCH 06/41] ARM: restart: cns3xxx: use new restart hook
In-Reply-To: <20111124203037.GR9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6jH-0001Wy-5x@rmk-PC.arm.linux.org.uk>
 <20111124203037.GR9581@n2100.arm.linux.org.uk>
Message-ID: <20111124210036.GA26662@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 08:30:38PM +0000, Russell King - ARM Linux wrote:
> Ack?

Sure, except that pm.c now needs to include core.h (or the prototype
has to be added to pm.h). Otherwise I'm getting the following warning:

    CHECK   arch/arm/mach-cns3xxx/pm.c
  arch/arm/mach-cns3xxx/pm.c:92:6: warning: symbol 'cns3xxx_restart' was not declared. Should it be static?

Following hunk helps:

diff --git a/arch/arm/mach-cns3xxx/pm.c b/arch/arm/mach-cns3xxx/pm.c
index 5136c4c..335494c 100644
--- a/arch/arm/mach-cns3xxx/pm.c
+++ b/arch/arm/mach-cns3xxx/pm.c
@@ -14,6 +14,7 @@
 #include <mach/system.h>
 #include <mach/cns3xxx.h>
 #include <mach/pm.h>
+#include "core.h"
 
 void cns3xxx_pwr_clk_en(unsigned int block)
 {


Other than that,

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
