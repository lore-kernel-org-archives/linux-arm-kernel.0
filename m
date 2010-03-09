From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Tue,  9 Mar 2010 15:10:32 +0900
Subject: [PATCH 2/4] ARM: S3C6410: Declare IISCDCLK_V4 Clock
In-Reply-To: <1268115034-5998-1-git-send-email-jassisinghbrar@gmail.com>
References: <1268115034-5998-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1268115034-5998-2-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Declare the source of clock provided at Xi2sCDCLK2 pin for IISv4 controller.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 2ac2e7d..c0041eb 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -518,6 +518,11 @@ static struct clk clk_iis_cd1 = {
 	.id		= -1,
 };
 
+static struct clk clk_iisv4_cd = {
+	.name		= "iis_cdclk_v4",
+	.id		= -1,
+};
+
 static struct clk clk_pcm_cd = {
 	.name		= "pcm_cdclk",
 	.id		= -1,
@@ -749,6 +754,7 @@ static struct clk *clks1[] __initdata = {
 	&clk_ext_xtal_mux,
 	&clk_iis_cd0,
 	&clk_iis_cd1,
+	&clk_iisv4_cd,
 	&clk_pcm_cd,
 	&clk_mout_epll.clk,
 	&clk_mout_mpll.clk,
-- 
1.6.2.5
