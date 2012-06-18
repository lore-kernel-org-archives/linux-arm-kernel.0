From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 18 Jun 2012 00:16:17 -0600
Subject: [PATCHv3 7/7] ARM: OMAP2+: mux: fix sparse warning
In-Reply-To: <20120618061037.30632.28539.stgit@dusk>
References: <20120618061037.30632.28539.stgit@dusk>
Message-ID: <20120618061614.30632.26422.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit bbd707acee279a61177a604822db92e8164d00db ("ARM: omap2: use
machine specific hook for late init") resulted in the addition of this
sparse warning:

arch/arm/mach-omap2/mux.c:791:12: warning: symbol 'omap_mux_late_init' was not declared. Should it be static?

Fix by including the header file containing the prototype.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 80e55c5..d3ef99c 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -41,6 +41,7 @@
 #include "control.h"
 #include "mux.h"
 #include "prm.h"
+#include "common.h"
 
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
 #define OMAP_MUX_BASE_SZ		0x5ca
