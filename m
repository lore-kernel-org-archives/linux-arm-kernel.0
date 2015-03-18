From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Mar 2015 15:53:10 +0000
Subject: [PATCH 11/13] can: at91_can: use endian agnostic IO accessors
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426693992-31163-12-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change __raw accesors to  endian agnostic versions to allow the driver
to work properly on big endian systems.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Wolfgang Grandegger <wg@grandegger.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: linux-can at vger.kernel.org
CC: netdev at vger.kernel.org
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/net/can/at91_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index eeb4b8b..f4e40aa 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -291,13 +291,13 @@ static inline unsigned int get_tx_echo_mb(const struct at91_priv *priv)
 
 static inline u32 at91_read(const struct at91_priv *priv, enum at91_reg reg)
 {
-	return __raw_readl(priv->reg_base + reg);
+	return readl_relaxed(priv->reg_base + reg);
 }
 
 static inline void at91_write(const struct at91_priv *priv, enum at91_reg reg,
 		u32 value)
 {
-	__raw_writel(value, priv->reg_base + reg);
+	writel_relaxed(value, priv->reg_base + reg);
 }
 
 static inline void set_mb_mode_prio(const struct at91_priv *priv,
-- 
2.1.4
