From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 21 Mar 2013 12:40:17 +0100
Subject: [PATCH v2 7/7] pcmcia/trivial: at91_cf: fix checkpatch error
In-Reply-To: <cover.1363865228.git.nicolas.ferre@atmel.com>
References: <cover.1363865228.git.nicolas.ferre@atmel.com>
Message-ID: <c1435f58cfd59c8e49d36a04a597543bb0a330d3.1363865228.git.nicolas.ferre@atmel.com>
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
1.8.0
