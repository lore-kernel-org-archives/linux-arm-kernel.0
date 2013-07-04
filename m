From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 4 Jul 2013 15:55:25 +0800
Subject: [PATCH 1/5] pinctrl: sirf: fix the pin number and mux bit for usp0
Message-ID: <1372924529-5519-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

we missed a pin and related mux bit for usp pin group, this
patch fixes it.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas6.c b/drivers/pinctrl/sirf/pinctrl-atlas6.c
index 1fa39a4..c641be9 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas6.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas6.c
@@ -496,7 +496,7 @@ static const unsigned sdmmc5_pins[] = { 24, 25, 26 };
 static const struct sirfsoc_muxmask usp0_muxmask[] = {
 	{
 		.group = 1,
-		.mask = BIT(19) | BIT(20) | BIT(21) | BIT(22),
+		.mask = BIT(19) | BIT(20) | BIT(21) | BIT(22) | BIT(23),
 	},
 };
 
@@ -507,7 +507,7 @@ static const struct sirfsoc_padmux usp0_padmux = {
 	.funcval = 0,
 };
 
-static const unsigned usp0_pins[] = { 51, 52, 53, 54 };
+static const unsigned usp0_pins[] = { 51, 52, 53, 54, 55 };
 
 static const struct sirfsoc_muxmask usp1_muxmask[] = {
 	{
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
