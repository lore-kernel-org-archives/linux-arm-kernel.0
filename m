From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jan 2014 11:23:11 +0100
Subject: [PATCH 2/3] spi: core: Update the devm_spi_register_master
 documentation
In-Reply-To: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391163792-21819-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the devm_spi_register_master function is used together with the
spi_alloc_master as advertised in the documentation, it will either lead to a
memory leak if spi_put_master is removed, or we will try to access an already
freed memory area during the unregistration function.

Advertise that you want to use the devm_spi_alloc_master function in such case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index eb728ec..dc577b7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1444,7 +1444,7 @@ static void devm_spi_unregister(struct device *dev, void *res)
 /**
  * dev_spi_register_master - register managed SPI master controller
  * @dev:    device managing SPI master
- * @master: initialized master, originally from spi_alloc_master()
+ * @master: initialized master, originally from devm_spi_alloc_master()
  * Context: can sleep
  *
  * Register a SPI device as with spi_register_master() which will
-- 
1.8.4.2
