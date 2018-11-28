From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 28 Nov 2018 18:53:17 +0100
Subject: [PATCH v4 13/20] gpio: pxa: avoid attempting to set pin direction via
 pinctrl on MMP2
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
Message-ID: <20181128175324.163202-14-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similarly to PXA3xx pinctrl-single can't set pin direction on MMP2 either.
See also: commit 9dabfdd84bdfa ("gpio: pxa: disable pinctrl calls for
PXA3xx")

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/gpio/gpio-pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index bfe4c5c9f41c..1b437bbe5cf5 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -245,6 +245,7 @@ static bool pxa_gpio_has_pinctrl(void)
 {
 	switch (gpio_type) {
 	case PXA3XX_GPIO:
+	case MMP2_GPIO:
 		return false;
 
 	default:
-- 
2.19.1
