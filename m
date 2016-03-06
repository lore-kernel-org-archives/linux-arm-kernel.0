From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Sun,  6 Mar 2016 13:04:17 +0300
Subject: [PATCH] spi/rockchip: fix endian mode for 16-bit transfers
Message-ID: <1457258657-19154-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

16-bit transfers must be in big endian mode on wire.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/spi/spi-rockchip.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index aa9561f..ef77df7 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -510,7 +510,8 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	int rsd = 0;
 
 	u32 cr0 = (CR0_BHT_8BIT << CR0_BHT_OFFSET)
-		| (CR0_SSD_ONE << CR0_SSD_OFFSET);
+		| (CR0_SSD_ONE << CR0_SSD_OFFSET)
+		| (CR0_EM_BIG << CR0_EM_OFFSET);
 
 	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= ((rs->mode & 0x3) << CR0_SCPH_OFFSET);
-- 
1.7.9.5
