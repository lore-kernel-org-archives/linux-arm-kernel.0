From: 21cnbao@gmail.com (Barry Song)
Date: Fri,  3 Jan 2014 10:59:24 +0800
Subject: [PATCH 3/5] pinctrl: sirf: fix the pins of sdmmc5 connected with TriG
In-Reply-To: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
References: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1388717966-11703-4-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bin Shi <Bin.Shi@csr.com>

sdmmc5 has only 3 pins CMD, CLK, DATA which are connected with CSR
TriG RF multi-GNSS. The hardware connection is like:
DATA -- GPS_SGN
CLK  -- GPS_RF_CLK
CMD  -- GPS_MAG
here we drop redundant pins in sdmmc5 group.

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-prima2.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-prima2.c b/drivers/pinctrl/sirf/pinctrl-prima2.c
index 050777b..9704641 100644
--- a/drivers/pinctrl/sirf/pinctrl-prima2.c
+++ b/drivers/pinctrl/sirf/pinctrl-prima2.c
@@ -467,12 +467,6 @@ static const struct sirfsoc_muxmask sdmmc5_muxmask[] = {
 	{
 		.group = 0,
 		.mask = BIT(24) | BIT(25) | BIT(26),
-	}, {
-		.group = 1,
-		.mask = BIT(29),
-	}, {
-		.group = 2,
-		.mask = BIT(0) | BIT(1),
 	},
 };
 
@@ -484,7 +478,7 @@ static const struct sirfsoc_padmux sdmmc5_padmux = {
 	.funcval = BIT(13) | BIT(14),
 };
 
-static const unsigned sdmmc5_pins[] = { 24, 25, 26, 61, 64, 65 };
+static const unsigned sdmmc5_pins[] = { 24, 25, 26 };
 
 static const struct sirfsoc_muxmask usp0_muxmask[] = {
 	{
-- 
1.7.5.4
