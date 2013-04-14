From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:52 +0200
Subject: [PATCH v3 08/15] ASoC: fsl-ssi: Add SACNT definitions
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365939779-4507-9-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add definitions for AC97 control register.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Timur Tabi <timur@tabi.org>
---
 sound/soc/fsl/fsl_ssi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 2173000..e6b9a69 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -196,5 +196,13 @@ struct ccsr_ssi {
 #define CCSR_SSI_SOR_WAIT(x) (((x) & 3) << CCSR_SSI_SOR_WAIT_SHIFT)
 #define CCSR_SSI_SOR_SYNRST 		0x00000001
 
+#define CCSR_SSI_SACNT_FRDIV(x)		(((x) & 0x3f) << 5)
+#define CCSR_SSI_SACNT_WR		0x00000010
+#define CCSR_SSI_SACNT_RD		0x00000008
+#define CCSR_SSI_SACNT_RDWR_MASK	0x00000018
+#define CCSR_SSI_SACNT_TIF		0x00000004
+#define CCSR_SSI_SACNT_FV		0x00000002
+#define CCSR_SSI_SACNT_AC97EN		0x00000001
+
 #endif
 
-- 
1.8.1.5
