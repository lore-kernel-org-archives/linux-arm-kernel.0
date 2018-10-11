From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 11 Oct 2018 15:31:16 +0300
Subject: [PATCH] MAINTAINERS: Assign myself as a maintainer of ARM/LPC18XX
 architecture
Message-ID: <20181011123116.24885-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To all appearance Joachim Eastwood abandoned the maintenance of NXP
LPC18xx/LPC43xx archtecture about two years ago, and for me it would be
possible to continue the support, fortunately the quality of platform
drivers written by Joachim is exceptionally high.

The change is based on https://lkml.org/lkml/2018/9/24/1398 discussion.

At the same time two redundant explicit driver file paths are dropped
from the list, clk-lpc18xx* drivers are covered by "lpc18xx" search
pattern and timer-lpc32xx driver is covered by "lpc32xx" pattern and it
goes into ARM/LPC32XX entry, which is also under my wing, in other words
LPC18xx/LPC43xx clocksource and CCF drivers will remain maintained.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Joachim Eastwood <manabian@gmail.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57e78e400fd3..15c4abb7bda6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1653,12 +1653,10 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
 ARM/LPC18XX ARCHITECTURE
-M:	Joachim Eastwood <manabian@gmail.com>
+M:	Vladimir Zapolskiy <vz@mleia.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/lpc43*
-F:	drivers/clk/nxp/clk-lpc18xx*
-F:	drivers/clocksource/timer-lpc32xx.c
 F:	drivers/i2c/busses/i2c-lpc2k.c
 F:	drivers/memory/pl172.c
 F:	drivers/mtd/spi-nor/nxp-spifi.c
-- 
2.17.1
