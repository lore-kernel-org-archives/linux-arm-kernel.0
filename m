From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 10:50:31 -0600
Subject: [PATCH] ARM: tegra: Include assembler.h in sleep.S to fix build break
Message-ID: <1332175831-5900-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6f6f6a7 "ARM: create a common IOMEM definition" moved macro
IOMEM(), and requires users to include <asm/assembler.h>. Fix Tegra's
sleep.S to do so.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/mach-tegra/sleep.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 8f9fde1..48cc7c6 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -22,7 +22,10 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
+#include <asm/assembler.h>
+
 #include <linux/linkage.h>
+
 #include <mach/io.h>
 #include <mach/iomap.h>
 
-- 
1.7.0.4
