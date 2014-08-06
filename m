From: hans@hanshq.net (Hans Wennborg)
Date: Tue,  5 Aug 2014 21:43:16 -0700
Subject: [PATCH 09/15] pinctrl: pinctrl-at91.c: fix decimal printf format
 specifiers prefixed with 0x
Message-ID: <1407300196-32708-1-git-send-email-hans@hanshq.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prefix suggests the number should be printed in hex, so use
the %x specifier to do that.

Found by using regex suggested by Joe Perches.

Signed-off-by: Hans Wennborg <hans@hanshq.net>
---
 drivers/pinctrl/pinctrl-at91.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index af1ba4f..60464a2 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -497,10 +497,10 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
 static void at91_pin_dbg(const struct device *dev, const struct at91_pmx_pin *pin)
 {
 	if (pin->mux) {
-		dev_dbg(dev, "pio%c%d configured as periph%c with conf = 0x%lu\n",
+		dev_dbg(dev, "pio%c%d configured as periph%c with conf = 0x%lx\n",
 			pin->bank + 'A', pin->pin, pin->mux - 1 + 'A', pin->conf);
 	} else {
-		dev_dbg(dev, "pio%c%d configured as gpio with conf = 0x%lu\n",
+		dev_dbg(dev, "pio%c%d configured as gpio with conf = 0x%lx\n",
 			pin->bank + 'A', pin->pin, pin->conf);
 	}
 }
-- 
2.0.0.526.g5318336
