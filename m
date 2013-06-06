From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 6 Jun 2013 10:24:20 +0200
Subject: [PATCH v3 7/7] pcmcia/trivial: at91_cf: fix checkpatch error
In-Reply-To: <cover.1370506678.git.nicolas.ferre@atmel.com>
References: <cover.1370506678.git.nicolas.ferre@atmel.com>
Message-ID: <a132c622362cc90434f2a744a5cf2c3b22e86b58.1370506678.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Navet <laurent.navet@gmail.com>

fix this checkpatch error:
- ERROR: switch and case should be at the same indent

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/pcmcia/at91_cf.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 8ddc57c..b8f5acf 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -119,14 +119,14 @@ at91_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
 	/* switch Vcc if needed and possible */
 	if (gpio_is_valid(cf->board->vcc_pin)) {
 		switch (s->Vcc) {
-			case 0:
-				gpio_set_value(cf->board->vcc_pin, 0);
-				break;
-			case 33:
-				gpio_set_value(cf->board->vcc_pin, 1);
-				break;
-			default:
-				return -EINVAL;
+		case 0:
+			gpio_set_value(cf->board->vcc_pin, 0);
+			break;
+		case 33:
+			gpio_set_value(cf->board->vcc_pin, 1);
+			break;
+		default:
+			return -EINVAL;
 		}
 	}
 
-- 
1.8.2.2
