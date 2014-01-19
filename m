From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 19 Jan 2014 19:58:47 +0100
Subject: [PATCH v3 22/24] drm/i2c: tda998x: change the frequence in the
 audio channel
In-Reply-To: <cover.1390153344.git.moinejf@free.fr>
References: <cover.1390153344.git.moinejf@free.fr>
Message-ID: <20140119195847.646a40b0@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the frequence as 'not indicated' instead of '48kHz'
and adds some comments.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 05713f7..2fcc432 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -745,10 +745,11 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_CTS);
 
 	/* Write the channel status */
-	buf[0] = 0x04;
+	buf[0] = (1 << 2);			/* copyright unprotected */
 	buf[1] = 0x00;
-	buf[2] = 0x00;
-	buf[3] = 0xf1;
+	buf[2] = 1;				/* freq not indicated */
+	buf[3] = (0 << 4) |			/* orig freq = not indicated */
+			1;			/* max word length 24 bits */
 	reg_write_range(priv, REG_CH_STAT_B(0), buf, 4);
 
 	tda998x_audio_mute(priv, true);
-- 
1.8.5.3
