From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 23 Feb 2011 02:29:11 +0300
Subject: [PATCH 3/3] ASoC: correct pxa AC97 DAI names
In-Reply-To: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
References: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1298417351-24727-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct names for pxa AC97 DAI are pxa2xx-ac97 and pxa2xx-ac97-aux. Fix
that for all PXA platforms.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/e740_wm9705.c    |    4 ++--
 sound/soc/pxa/e750_wm9705.c    |    4 ++--
 sound/soc/pxa/e800_wm9712.c    |    4 ++--
 sound/soc/pxa/em-x270.c        |    4 ++--
 sound/soc/pxa/mioa701_wm9713.c |    4 ++--
 sound/soc/pxa/palm27x.c        |    4 ++--
 sound/soc/pxa/tosa.c           |    4 ++--
 sound/soc/pxa/zylonite.c       |    4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 28333e7..dc65650 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -117,7 +117,7 @@ static struct snd_soc_dai_link e740_dai[] = {
 	{
 		.name = "AC97",
 		.stream_name = "AC97 HiFi",
-		.cpu_dai_name = "pxa-ac97.0",
+		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9705-hifi",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
@@ -126,7 +126,7 @@ static struct snd_soc_dai_link e740_dai[] = {
 	{
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
-		.cpu_dai_name = "pxa-ac97.1",
+		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name = "wm9705-aux",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 01bf316..51897fc 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -99,7 +99,7 @@ static struct snd_soc_dai_link e750_dai[] = {
 	{
 		.name = "AC97",
 		.stream_name = "AC97 HiFi",
-		.cpu_dai_name = "pxa-ac97.0",
+		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9705-hifi",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
@@ -109,7 +109,7 @@ static struct snd_soc_dai_link e750_dai[] = {
 	{
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
-		.cpu_dai_name = "pxa-ac97.1",
+		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name ="wm9705-aux",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index c6a37c6..053ed20 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -89,7 +89,7 @@ static struct snd_soc_dai_link e800_dai[] = {
 	{
 		.name = "AC97",
 		.stream_name = "AC97 HiFi",
-		.cpu_dai_name = "pxa-ac97.0",
+		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9712-hifi",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
@@ -98,7 +98,7 @@ static struct snd_soc_dai_link e800_dai[] = {
 	{
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
-		.cpu_dai_name = "pxa-ac97.1",
+		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name ="wm9712-aux",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index fc22e6e..b13a425 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -37,7 +37,7 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 	{
 		.name = "AC97",
 		.stream_name = "AC97 HiFi",
-		.cpu_dai_name = "pxa-ac97.0",
+		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9712-hifi",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
@@ -45,7 +45,7 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 	{
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
-		.cpu_dai_name = "pxa-ac97.1",
+		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name ="wm9712-aux",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 0d70fc8..38ca675 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -162,7 +162,7 @@ static struct snd_soc_dai_link mioa701_dai[] = {
 	{
 		.name = "AC97",
 		.stream_name = "AC97 HiFi",
-		.cpu_dai_name = "pxa-ac97.0",
+		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9713-hifi",
 		.codec_name = "wm9713-codec",
 		.init = mioa701_wm9713_init,
@@ -172,7 +172,7 @@ static struct snd_soc_dai_link mioa701_dai[] = {
 	{
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
-		.cpu_dai_name = "pxa-ac97.1",
+		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name ="wm9713-aux",
 		.codec_name = "wm9713-codec",
 		.platform_name = "pxa-pcm-audio",
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 857db96..504e400 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -132,7 +132,7 @@ static struct snd_soc_dai_link palm27x_dai[] = {
 {
 	.name = "AC97 HiFi",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "pxa-ac97.0",
+	.cpu_dai_name = "pxa2xx-ac97",
 	.codec_dai_name =  "wm9712-hifi",
 	.codec_name = "wm9712-codec",
 	.platform_name = "pxa-pcm-audio",
@@ -141,7 +141,7 @@ static struct snd_soc_dai_link palm27x_dai[] = {
 {
 	.name = "AC97 Aux",
 	.stream_name = "AC97 Aux",
-	.cpu_dai_name = "pxa-ac97.1",
+	.cpu_dai_name = "pxa2xx-ac97-aux",
 	.codec_dai_name = "wm9712-aux",
 	.codec_name = "wm9712-codec",
 	.platform_name = "pxa-pcm-audio",
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index f75804e..4b6e5d6 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -219,7 +219,7 @@ static struct snd_soc_dai_link tosa_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "pxa-ac97.0",
+	.cpu_dai_name = "pxa2xx-ac97",
 	.codec_dai_name = "wm9712-hifi",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm9712-codec",
@@ -229,7 +229,7 @@ static struct snd_soc_dai_link tosa_dai[] = {
 {
 	.name = "AC97 Aux",
 	.stream_name = "AC97 Aux",
-	.cpu_dai_name = "pxa-ac97.1",
+	.cpu_dai_name = "pxa2xx-ac97-aux",
 	.codec_dai_name = "wm9712-aux",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm9712-codec",
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index b222a7d..25bba10 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -166,7 +166,7 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 	.stream_name = "AC97 HiFi",
 	.codec_name = "wm9713-codec",
 	.platform_name = "pxa-pcm-audio",
-	.cpu_dai_name = "pxa-ac97.0",
+	.cpu_dai_name = "pxa2xx-ac97",
 	.codec_name = "wm9713-hifi",
 	.init = zylonite_wm9713_init,
 },
@@ -175,7 +175,7 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 	.stream_name = "AC97 Aux",
 	.codec_name = "wm9713-codec",
 	.platform_name = "pxa-pcm-audio",
-	.cpu_dai_name = "pxa-ac97.1",
+	.cpu_dai_name = "pxa2xx-ac97-aux",
 	.codec_name = "wm9713-aux",
 },
 {
-- 
1.7.2.3
