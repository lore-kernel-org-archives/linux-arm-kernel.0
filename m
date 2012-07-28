From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 28 Jul 2012 14:58:37 +0800
Subject: [PATCH 1/6] pinctrl: append new pins and groups in pxa910
In-Reply-To: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1343458722-17127-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinctrl-pxa910.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-pxa910.c b/drivers/pinctrl/pinctrl-pxa910.c
index c72ab4b..4164a6b 100644
--- a/drivers/pinctrl/pinctrl-pxa910.c
+++ b/drivers/pinctrl/pinctrl-pxa910.c
@@ -307,6 +307,7 @@ static struct pinctrl_pin_desc pxa910_pads[] = {
 	PINCTRL_PIN(ND_RDY0, "ND_RDY0"),
 	PINCTRL_PIN(SM_ADV, "SM_ADV"),
 	PINCTRL_PIN(ND_RDY1, "ND_RDY1"),
+	PINCTRL_PIN(SM_ADVMUX, "SM_ADVMUX"),
 	PINCTRL_PIN(SM_RDY, "SM_RDY"),
 	PINCTRL_PIN(MMC1_DAT7, "MMC1_DAT7"),
 	PINCTRL_PIN(MMC1_DAT6, "MMC1_DAT6"),
@@ -504,6 +505,8 @@ static const unsigned p910_mmc1_pin1[] = {MMC1_DAT7, MMC1_DAT6, MMC1_DAT5,
 	MMC1_CLK, MMC1_CD, GPIO99};
 static const unsigned p910_mmc2_pin1[] = {GPIO33, GPIO34, GPIO35, GPIO36,
 	GPIO37, GPIO38, GPIO39, GPIO40, GPIO41, GPIO42};
+static const unsigned p910_mmc2_pin2[] = {GPIO37, GPIO38, GPIO39, GPIO40,
+	GPIO41, GPIO42};
 static const unsigned p910_mmc3_pin1[] = {GPIO33, GPIO34, GPIO35, GPIO36,
 	GPIO49, GPIO50};
 static const unsigned p910_mmc3_pin2[] = {ND_IO7, ND_IO6, ND_IO5, ND_IO4,
@@ -674,6 +677,7 @@ static struct pxa3xx_pin_group pxa910_grps[] = {
 	GRP_910("usim2 3p2", USIM2, p910_usim2_pin2),
 	GRP_910("mmc1 12p", MMC1, p910_mmc1_pin1),
 	GRP_910("mmc2 10p", MMC2, p910_mmc2_pin1),
+	GRP_910("mmc2 6p", MMC2, p910_mmc2_pin2),
 	GRP_910("mmc3 6p", MMC3, p910_mmc3_pin1),
 	GRP_910("mmc3 10p", MMC3, p910_mmc3_pin2),
 	GRP_910("uart0 4p", UART0, p910_uart0_pin1),
@@ -808,7 +812,7 @@ static struct pxa3xx_pin_group pxa910_grps[] = {
 
 static const char * const p910_usim2_grps[] = {"usim2 3p1", "usim2 3p2"};
 static const char * const p910_mmc1_grps[] = {"mmc1 12p"};
-static const char * const p910_mmc2_grps[] = {"mmc2 10p"};
+static const char * const p910_mmc2_grps[] = {"mmc2 10p", "mmc2 6p"};
 static const char * const p910_mmc3_grps[] = {"mmc3 6p", "mmc3 10p"};
 static const char * const p910_uart0_grps[] = {"uart0 4p"};
 static const char * const p910_uart1_grps[] = {"uart1 2p1", "uart1 2p2",
-- 
1.7.9.5
