From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Tue, 5 Jun 2012 09:59:40 +0530
Subject: [PATCH v3 6/9] spi/tegra: add clk_prepare/clk_unprepare
In-Reply-To: <1338870583-8704-1-git-send-email-pgaikwad@nvidia.com>
References: <1338870583-8704-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1338870583-8704-7-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clk_prepare/clk_unprepare as required by the generic clk framework.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
Please ignore previous versions. Updated commit message and
maintainers properly in this version. No other change.

This patch should go through Tegra tree since other patches to port Tegra
to generic clock framework are dependent on it. Posting here to get ack from
the maintainers.

 drivers/spi/spi-tegra.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra.c b/drivers/spi/spi-tegra.c
index ae6d78a..7f99ff3 100644
--- a/drivers/spi/spi-tegra.c
+++ b/drivers/spi/spi-tegra.c
@@ -261,7 +261,7 @@ static void spi_tegra_start_transfer(struct spi_device *spi,
 		clk_set_rate(tspi->clk, speed);
 
 	if (tspi->cur_speed == 0)
-		clk_enable(tspi->clk);
+		clk_prepare_enable(tspi->clk);
 
 	tspi->cur_speed = speed;
 
@@ -373,7 +373,7 @@ static void tegra_spi_rx_dma_complete(struct tegra_dma_req *req)
 			spi = m->state;
 			spi_tegra_start_message(spi, m);
 		} else {
-			clk_disable(tspi->clk);
+			clk_disable_unprepare(tspi->clk);
 			tspi->cur_speed = 0;
 		}
 	}
-- 
1.7.4.1
