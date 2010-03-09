From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Tue,  9 Mar 2010 15:10:33 +0900
Subject: [PATCH 3/4] ARM: S3C6410: Declare possible sources of audio-bus2
In-Reply-To: <1268115034-5998-2-git-send-email-jassisinghbrar@gmail.com>
References: <1268115034-5998-1-git-send-email-jassisinghbrar@gmail.com>
	<1268115034-5998-2-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1268115034-5998-3-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Declare possible sources of CLKAUDIO[2]/audio-bus for IISv4 controller.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index c0041eb..6c286d5 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -554,6 +554,19 @@ static struct clksrc_sources clkset_audio1 = {
 	.nr_sources	= ARRAY_SIZE(clkset_audio1_list),
 };
 
+static struct clk *clkset_audio2_list[] = {
+	[0] = &clk_mout_epll.clk,
+	[1] = &clk_dout_mpll,
+	[2] = &clk_fin_epll,
+	[3] = &clk_iisv4_cd,
+	[4] = &clk_pcm_cd,
+};
+
+static struct clksrc_sources clkset_audio2 = {
+	.sources	= clkset_audio2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio2_list),
+};
+
 static struct clk *clkset_camif_list[] = {
 	&clk_h2,
 };
-- 
1.6.2.5
