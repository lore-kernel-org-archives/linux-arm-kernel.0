From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Feb 2013 12:01:48 -0200
Subject: [PATCH 3/3] ARM: mxs: ocotp: Fix sparse warning
In-Reply-To: <1360591308-7482-1-git-send-email-festevam@gmail.com>
References: <1360591308-7482-1-git-send-email-festevam@gmail.com>
Message-ID: <1360591308-7482-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Include <mach/common.h> header to fix the following sparse warning:

arch/arm/mach-mxs/ocotp.c:33:11: warning: symbol 'mxs_get_ocotp' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/ocotp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
index 54add60..1dff467 100644
--- a/arch/arm/mach-mxs/ocotp.c
+++ b/arch/arm/mach-mxs/ocotp.c
@@ -19,6 +19,7 @@
 #include <asm/processor.h>	/* for cpu_relax() */
 
 #include <mach/mxs.h>
+#include <mach/common.h>
 
 #define OCOTP_WORD_OFFSET		0x20
 #define OCOTP_WORD_COUNT		0x20
-- 
1.7.9.5
