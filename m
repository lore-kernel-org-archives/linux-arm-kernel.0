From: tklauser@distanz.ch (Tobias Klauser)
Date: Wed,  1 Feb 2012 13:33:42 +0100
Subject: [PATCH] spi/nuc900: Remove unnecessary memset of struct nuc900_spi
Message-ID: <1328099622-14058-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory allocated using kzalloc by spi_alloc_master so it doesn't
need to be set to 0 again.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/spi/spi-nuc900.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index 182e9c8..dae8be2 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -360,8 +360,6 @@ static int __devinit nuc900_spi_probe(struct platform_device *pdev)
 	}
 
 	hw = spi_master_get_devdata(master);
-	memset(hw, 0, sizeof(struct nuc900_spi));
-
 	hw->master = spi_master_get(master);
 	hw->pdata  = pdev->dev.platform_data;
 	hw->dev = &pdev->dev;
-- 
1.7.5.4
