From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat,  8 Feb 2014 21:13:03 +0100
Subject: [PATCH] mmc: mmci: rename some extended flags
Message-ID: <1391890383-10280-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These four (so far unused) flags are only found in the ST Micro
versions of MMCI, so infix them properly with the _ST_ infix.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 168bc72f7a94..84c0e59b792a 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -38,10 +38,11 @@
 #define MCI_CPSM_INTERRUPT	(1 << 8)
 #define MCI_CPSM_PENDING	(1 << 9)
 #define MCI_CPSM_ENABLE		(1 << 10)
-#define MCI_SDIO_SUSP		(1 << 11)
-#define MCI_ENCMD_COMPL		(1 << 12)
-#define MCI_NIEN		(1 << 13)
-#define MCI_CE_ATACMD		(1 << 14)
+/* Argument flag extenstions in the ST Micro versions */
+#define MCI_ST_SDIO_SUSP	(1 << 11)
+#define MCI_ST_ENCMD_COMPL	(1 << 12)
+#define MCI_ST_NIEN		(1 << 13)
+#define MCI_ST_CE_ATACMD	(1 << 14)
 
 #define MMCIRESPCMD		0x010
 #define MMCIRESPONSE0		0x014
-- 
1.8.5.3
