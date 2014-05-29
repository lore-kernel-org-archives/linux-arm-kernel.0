From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 30 May 2014 08:31:24 +0900
Subject: [PATCH] ARM: shmobile: armadillo800eva: fixup HDMI sound flags setting
In-Reply-To: <cover.1401406177.git.horms+renesas@verge.net.au>
References: <cover.1401406177.git.horms+renesas@verge.net.au>
Message-ID: <730359857f5f0e1fac9881c63d389d73adb5f416.1401406177.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

c7a507eea1db1430476289f525f9c853d5d485e8
(ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags)
fixuped FSI driver's behavior
which didn't match to ALSA flags.

But, it didn't care about armadillo800eva HDMI sound flags.
This patch fixed it.

Reported-by: Bui Duc Phuc(Fukuda) <bd-phuc@jinso.co.jp>
Reported-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 2858f38..40895cc 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1016,7 +1016,7 @@ static struct asoc_simple_card_info fsi2_hdmi_info = {
 	.platform	= "sh_fsi2",
 	.cpu_dai = {
 		.name	= "fsib-dai",
-		.fmt	= SND_SOC_DAIFMT_CBM_CFM,
+		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
 	},
 	.codec_dai = {
 		.name = "sh_mobile_hdmi-hifi",
-- 
1.8.5.2
