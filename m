From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Oct 2014 20:38:23 +0100
Subject: [PATCH v2] pinctrl: at91: fix compilation
Message-ID: <1414525103-10823-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macros introduced by 4334ac2db2be (pinctrl: at91: add drive strength
configuration) that were missed when copying the header.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pinctrl/pinctrl-at91.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.h b/drivers/pinctrl/pinctrl-at91.h
index c837c66ea360..79b957f1dfa2 100644
--- a/drivers/pinctrl/pinctrl-at91.h
+++ b/drivers/pinctrl/pinctrl-at91.h
@@ -63,4 +63,10 @@
 #define PIO_FRLHSR	0xd8	/* Fall/Rise - Low/High Status Register */
 #define PIO_SCHMITT	0x100	/* Schmitt Trigger Register */
 
+#define SAMA5D3_PIO_DRIVER1		0x118  /*PIO Driver 1 register offset*/
+#define SAMA5D3_PIO_DRIVER2		0x11C  /*PIO Driver 2 register offset*/
+
+#define AT91SAM9X5_PIO_DRIVER1	0x114  /*PIO Driver 1 register offset*/
+#define AT91SAM9X5_PIO_DRIVER2	0x118  /*PIO Driver 2 register offset*/
+
 #endif
-- 
2.1.0
