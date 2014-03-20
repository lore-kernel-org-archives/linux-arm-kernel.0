From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 11:11:43 +0000
Subject: [PATCH 1/5] mtd: st_spi_fsm: Remove useless consts from function
 arguments
In-Reply-To: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395313907-25318-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index aefd48d..dcc1dc3 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -785,8 +785,7 @@ static void stfsm_wait_seq(struct stfsm *fsm)
 	dev_err(fsm->dev, "timeout on sequence completion\n");
 }
 
-static void stfsm_read_fifo(struct stfsm *fsm, uint32_t *buf,
-			    const uint32_t size)
+static void stfsm_read_fifo(struct stfsm *fsm, uint32_t *buf, uint32_t size)
 {
 	uint32_t remaining = size >> 2;
 	uint32_t avail;
@@ -811,8 +810,7 @@ static void stfsm_read_fifo(struct stfsm *fsm, uint32_t *buf,
 	}
 }
 
-static int stfsm_write_fifo(struct stfsm *fsm,
-			    const uint32_t *buf, const uint32_t size)
+static int stfsm_write_fifo(struct stfsm *fsm, uint32_t *buf, uint32_t size)
 {
 	uint32_t words = size >> 2;
 
@@ -1544,8 +1542,8 @@ static int stfsm_read(struct stfsm *fsm, uint8_t *buf, uint32_t size,
 	return 0;
 }
 
-static int stfsm_write(struct stfsm *fsm, const uint8_t *const buf,
-		       const uint32_t size, const uint32_t offset)
+static int stfsm_write(struct stfsm *fsm, const uint8_t *buf,
+		       uint32_t size, uint32_t offset)
 {
 	struct stfsm_seq *seq = &fsm->stfsm_seq_write;
 	uint32_t data_pads;
@@ -1670,7 +1668,7 @@ static int stfsm_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 	return 0;
 }
 
-static int stfsm_erase_sector(struct stfsm *fsm, const uint32_t offset)
+static int stfsm_erase_sector(struct stfsm *fsm, uint32_t offset)
 {
 	struct stfsm_seq *seq = &stfsm_seq_erase_sector;
 	int ret;
-- 
1.8.3.2
