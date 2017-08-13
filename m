From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sun, 13 Aug 2017 18:13:13 +0530
Subject: [PATCH 6/6] [media] tuners: make snd_pcm_hardware const
In-Reply-To: <1502628193-3343-1-git-send-email-bhumirks@gmail.com>
References: <1502628193-3343-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502628193-3343-7-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/tuners/tda18271-maps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/tuners/tda18271-maps.c b/drivers/media/tuners/tda18271-maps.c
index 7d11467..9679804 100644
--- a/drivers/media/tuners/tda18271-maps.c
+++ b/drivers/media/tuners/tda18271-maps.c
@@ -1182,7 +1182,7 @@ int tda18271_lookup_map(struct dvb_frontend *fe,
 
 /*---------------------------------------------------------------------*/
 
-static struct tda18271_std_map tda18271c1_std_map = {
+static const struct tda18271_std_map tda18271c1_std_map = {
 	.fm_radio = { .if_freq = 1250, .fm_rfn = 1, .agc_mode = 3, .std = 0,
 		      .if_lvl = 0, .rfagc_top = 0x2c, }, /* EP3[4:0] 0x18 */
 	.atv_b    = { .if_freq = 6750, .fm_rfn = 0, .agc_mode = 1, .std = 6,
@@ -1215,7 +1215,7 @@ int tda18271_lookup_map(struct dvb_frontend *fe,
 		      .if_lvl = 1, .rfagc_top = 0x37, }, /* EP3[4:0] 0x1f */
 };
 
-static struct tda18271_std_map tda18271c2_std_map = {
+static const struct tda18271_std_map tda18271c2_std_map = {
 	.fm_radio = { .if_freq = 1250, .fm_rfn = 1, .agc_mode = 3, .std = 0,
 		      .if_lvl = 0, .rfagc_top = 0x2c, }, /* EP3[4:0] 0x18 */
 	.atv_b    = { .if_freq = 6000, .fm_rfn = 0, .agc_mode = 1, .std = 5,
-- 
1.9.1
