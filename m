From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Nov 2009 16:43:53 +0000
Subject: [PATCH 1/7] S3C64XX: Staticise platform data for PCM devices
In-Reply-To: <20091127164312.GA11913@rakim.wolfsonmicro.main>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
Message-ID: <1259340239-12067-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbols aren't declared and don't need to be exported, they go
along with the device structure.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-s3c64xx/dev-audio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
index 9e07344..a21a88f 100644
--- a/arch/arm/plat-s3c64xx/dev-audio.c
+++ b/arch/arm/plat-s3c64xx/dev-audio.c
@@ -118,7 +118,7 @@ static struct resource s3c64xx_pcm0_resource[] = {
 	},
 };
 
-struct s3c_audio_pdata s3c_pcm0_pdata = {
+static struct s3c_audio_pdata s3c_pcm0_pdata = {
 	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
 };
 
@@ -151,7 +151,7 @@ static struct resource s3c64xx_pcm1_resource[] = {
 	},
 };
 
-struct s3c_audio_pdata s3c_pcm1_pdata = {
+static struct s3c_audio_pdata s3c_pcm1_pdata = {
 	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
 };
 
-- 
1.6.5.3
