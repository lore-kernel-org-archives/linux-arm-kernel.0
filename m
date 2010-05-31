From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 May 2010 14:19:50 +0200
Subject: [PATCH 2/2] i.MX ssi: Add missing Kconfig entry for Phytec boards
In-Reply-To: <20100531103045.GB3489@rakim.wolfsonmicro.main>
References: <20100531101200.GA3489@rakim.wolfsonmicro.main>
	<1275301701-17599-1-git-send-email-s.hauer@pengutronix.de>
	<20100531103045.GB3489@rakim.wolfsonmicro.main>
Message-ID: <20100531121950.GG26820@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 11:30:46AM +0100, Mark Brown wrote:
> On Mon, May 31, 2010 at 12:28:21PM +0200, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Is this different to your previous submission which I already have
> queued for application?
> 

Sorry, wrong patch. I wanted to update the other patch according to your
comment. Here's the right one.

Sascha


[PATCH 1/2] i.MX ssi: MX31ads sound support should depend on MACH_MX31ADS_WM1133_EV1

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index eba9b9d..10acbe9 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -13,7 +13,7 @@ config SND_MXC_SOC_SSI
 
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
-	depends on SND_IMX_SOC && EXPERIMENTAL
+	depends on SND_IMX_SOC && MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
 	select SND_SOC_WM8350
 	select SND_MXC_SOC_SSI
 	help
-- 
1.7.1

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
