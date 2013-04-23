From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:41 +0200
Subject: [PATCH 09/21] spi/sirf: fix MODULE_DEVICE_TABLE
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes building the spi-sirf driver as a loadable module, which uses
an incorrect MODULE_DEVICE_TABLE, by changing the reference to the
correct symbol.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@kernel.org>
Cc: spi-devel-general at lists.sourceforge.net
Cc: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index f59d417..0808cd5 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -660,7 +660,7 @@ static const struct of_device_id spi_sirfsoc_of_match[] = {
 	{ .compatible = "sirf,marco-spi", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sirfsoc_spi_of_match);
+MODULE_DEVICE_TABLE(of, spi_sirfsoc_of_match);
 
 static struct platform_driver spi_sirfsoc_driver = {
 	.driver = {
-- 
1.8.1.2
