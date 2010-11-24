From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 24 Nov 2010 15:55:41 +0100
Subject: [PATCH 7/7] at91/board-yl-9200: fix typo in video support
In-Reply-To: <20101124143448.GH11909@game.jcrosoft.org>
References: <20101124143448.GH11909@game.jcrosoft.org>
Message-ID: <1290610541-29255-7-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for the epson frambuffer support it's CONFIG_FB_S1D13XXX
not CONFIG_FB_S1D135XX

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-yl-9200.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 89df00a..e0f0080 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -387,7 +387,7 @@ static struct spi_board_info yl9200_spi_devices[] = {
  * EPSON S1D13806 FB (discontinued chip)
  * EPSON S1D13506 FB
  */
-#if defined(CONFIG_FB_S1D135XX) || defined(CONFIG_FB_S1D13XXX_MODULE)
+#if defined(CONFIG_FB_S1D13XXX) || defined(CONFIG_FB_S1D13XXX_MODULE)
 #include <video/s1d13xxxfb.h>
 
 
-- 
1.7.1
