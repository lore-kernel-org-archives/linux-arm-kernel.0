From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Oct 2015 02:52:46 +0800
Subject: [RFC PATCH] ASOC: sunxi: sun4i_snd_txctrl_on() can be static
In-Reply-To: <1443635458-8873-5-git-send-email-codekipper@gmail.com>
References: <201510010231.FvvWaROC%fengguang.wu@intel.com>
Message-ID: <20150930185246.GA82847@lkp-hsx03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 sun4i-spdif.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 5fff6f6..cf0ed80 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -204,7 +204,7 @@ static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
 
 }
 
-void sun4i_snd_txctrl_on(struct snd_pcm_substream *substream,
+static void sun4i_snd_txctrl_on(struct snd_pcm_substream *substream,
 				struct sun4i_spdif_dev *host)
 {
 	if (substream->runtime->channels == 1)
@@ -228,7 +228,7 @@ void sun4i_snd_txctrl_on(struct snd_pcm_substream *substream,
 					SUN4I_SPDIF_CTL_GEN);
 }
 
-void sun4i_snd_txctrl_off(struct snd_pcm_substream *substream,
+static void sun4i_snd_txctrl_off(struct snd_pcm_substream *substream,
 				struct sun4i_spdif_dev *host)
 {
 	/* SPDIF TX DISABLE */
