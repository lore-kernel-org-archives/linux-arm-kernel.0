From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Dec 2014 11:59:12 +0000
Subject: [PATCH v3 05/13] mtd: st_spi_fsm: Fix [-Wsign-compare] build warning
In-Reply-To: <1418644760-18773-1-git-send-email-lee.jones@linaro.org>
References: <1418644760-18773-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1418644760-18773-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/mtd/devices/st_spi_fsm.c:1647:17:
  warning: comparison between signed and unsigned integer expressions

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index d82394a..63a84d2 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -1625,11 +1625,11 @@ static int stfsm_write(struct stfsm *fsm, const uint8_t *buf,
 	uint32_t size_lb;
 	uint32_t size_mop;
 	uint32_t tmp[4];
+	uint32_t i;
 	uint32_t page_buf[FLASH_PAGESIZE_32];
 	uint8_t *t = (uint8_t *)&tmp;
 	const uint8_t *p;
 	int ret;
-	int i;
 
 	dev_dbg(fsm->dev, "writing %d bytes to 0x%08x\n", size, offset);
 
-- 
1.9.1
