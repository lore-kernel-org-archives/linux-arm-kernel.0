From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 28 Feb 2017 17:01:57 +0100
Subject: [PATCH v4 3/6] ARM: davinci: da8xx: add OF_DEV_AUXDATA() for vpif
In-Reply-To: <1488297720-4558-1-git-send-email-bgolaszewski@baylibre.com>
References: <1488297720-4558-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1488297720-4558-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@baylibre.com>

This is needed for the driver to access the vpif clock.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
[Bartosz: split the pdata-quirks patch in two with one
          adding the OF_DEV_AUXDATA entry]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index e3cef50..5699ce3 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -53,6 +53,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
 	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
 	OF_DEV_AUXDATA("ti,da850-ahci", 0x01e18000, "ahci_da850", NULL),
+	OF_DEV_AUXDATA("ti,da850-vpif", 0x01e17000, "vpif", NULL),
 	{}
 };
 
-- 
2.9.3
