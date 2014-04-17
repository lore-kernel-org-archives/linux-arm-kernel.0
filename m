From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Apr 2014 07:44:58 +0900
Subject: [PATCH 09/14] ARM: shmobile: Add Koelsch clock workarounds for SDHI
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
Message-ID: <f278ea78beeb17ea07d11fc3372d4f98c94dcf46.1397774191.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add SDHI0, SDHI1 and SDHI2 to the clock workaround list for
Koelsch multiplatform. Without these additional lines wakeup
from Suspend-to-RAM never happens.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 63117d52..941f8b3 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -115,6 +115,9 @@ static const struct clk_name clk_enables[] __initconst = {
 	{ "i2c2", NULL, "e6530000.i2c" },
 	{ "msiof0", NULL, "e6e20000.spi" },
 	{ "qspi_mod", NULL, "e6b10000.spi" },
+	{ "sdhi0", NULL, "ee100000.sd" },
+	{ "sdhi1", NULL, "ee140000.sd" },
+	{ "sdhi2", NULL, "ee160000.sd" },
 	{ "thermal", NULL, "e61f0000.thermal" },
 };
 
-- 
1.8.4
