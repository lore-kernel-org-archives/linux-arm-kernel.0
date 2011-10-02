From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 22:27:59 +0200
Subject: [PATCH 1/6] ASoC: codecs/wm8682: use __devexit_p
In-Reply-To: <1317587284-2776-1-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
Message-ID: <1317587284-2776-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a build error when CONFIG_HOTPLUG is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ian Lartey <ian@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8782.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index a2a09f8..f2ced71 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -60,7 +60,7 @@ static struct platform_driver wm8782_codec_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8782_probe,
-	.remove = wm8782_remove,
+	.remove = __devexit_p(wm8782_remove),
 };
 
 static int __init wm8782_init(void)
-- 
1.7.5.4
