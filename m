From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:30 +0200
Subject: [PATCH 16/23] [BUG] SPI: array out of bound => no CS
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-17-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/spi/spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3fb5b6d..74e6577 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -976,8 +976,8 @@ static int of_spi_register_master(struct spi_master *master)
 		return -ENOMEM;
 
 	memset(cs, -EINVAL, master->num_chipselect);
-	master->num_chipselect += nb;
 	cs += master->num_chipselect;
+	master->num_chipselect += nb;
 
 	for (i = 0; i < nb; i++)
 		cs[i] = of_get_named_gpio(np, "cs-gpios", i);
-- 
1.7.2.5
