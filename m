From: hramrach@gmail.com (Michal Suchanek)
Date: Sat, 25 Apr 2015 21:21:07 +0200
Subject: [PATCH 3/3] ARM: sunxi: spi: use proper errno when message is too
 long.
In-Reply-To: <cover.1430034797.git.hramrach@gmail.com>
References: <cover.1430034797.git.hramrach@gmail.com>
Message-ID: <4c27d44b2bdd759424ce4a4b2e8f6abf5d5a6735.1430034797.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-sun4i.c | 2 +-
 drivers/spi/spi-sun6i.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fbb0a4d..8238b4e 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -176,7 +176,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
-		return -EINVAL;
+		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ac48f59..0f5dd91 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -166,7 +166,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN6I_FIFO_DEPTH)
-		return -EINVAL;
+		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
-- 
2.1.4
