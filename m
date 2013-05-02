From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 19:23:24 +0200
Subject: [PATCH 4/4] ARM: highbank: fix build after cache flush change
In-Reply-To: <1367515404-512212-1-git-send-email-arnd@arndb.de>
References: <1367515404-512212-1-git-send-email-arnd@arndb.de>
Message-ID: <1367515404-512212-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "ARM: cpu hotplug: remove majority of cache flushing from
platforms" has removed the inclusion of asm/cacheflush.h from
a number of files. Highbank still needs it because it calls
flush_cache_louis().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-highbank/hotplug.c b/arch/arm/mach-highbank/hotplug.c
index 80957f4..a019e4e 100644
--- a/arch/arm/mach-highbank/hotplug.c
+++ b/arch/arm/mach-highbank/hotplug.c
@@ -14,6 +14,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/kernel.h>
+#include <asm/cacheflush.h>
 
 #include "core.h"
 #include "sysregs.h"
-- 
1.8.1.2
