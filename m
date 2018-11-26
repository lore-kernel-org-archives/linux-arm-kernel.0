From: plaes@plaes.org (Priit Laes)
Date: Mon, 26 Nov 2018 17:27:54 +0200
Subject: [PATCH 13/14] power: supply: axp20x: add missing include bitops.h
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
Message-ID: <9547ef8e8e6fe9f933264119bd186bdd83974999.1543245984.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The axp20x_usb_power driver uses BIT() operations but lacks the include
for it. Include the bitops.h header file.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/power/supply/axp20x_usb_power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 42001df..f52fe77 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -10,6 +10,7 @@
  * option) any later version.
  */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-- 
git-series 0.9.1
