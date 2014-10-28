From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Oct 2014 17:08:40 +0100
Subject: [PATCH 2/6] ASoC: cs42l51: make driver user-selectable
In-Reply-To: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414512524-24466-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are removing the Armada 370 DB audio machine driver to use
the 'simple-card' Device Tree binding, we can no longer select the
CS42L51 codec driver using a Kconfig 'select', and we instead need it
to be user-selectable. Therefore, this commit adds a prompt to make
the CS42L51 I2C codec driver user-selectable.

Cc: Brian Austin <brian.austin@cirrus.com>
Cc: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a68d173..f4fb12f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -336,7 +336,7 @@ config SND_SOC_CS42L51
 	tristate
 
 config SND_SOC_CS42L51_I2C
-	tristate
+	tristate "Cirrus Logic CS42L51 CODEC (I2C)"
 	select SND_SOC_CS42L51
 
 config SND_SOC_CS42L52
-- 
2.0.0
