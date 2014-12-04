From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  4 Dec 2014 10:21:45 +0000
Subject: [PATCH v2 RESEND 04/11] mtd: st_spi_fsm: Add support for Micron
 N25Q512A
In-Reply-To: <1417688512-7644-1-git-send-email-lee.jones@linaro.org>
References: <1417688512-7644-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1417688512-7644-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nunzio Raciti <nunzio.raciti@st.com>

This patch adds support for the Micron N25Q512A device as required
by the B2147 (STiD127) board.

Signed-off-by: Nunzio Raciti <nunzio.raciti@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 35eb475..1e79e9b 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -374,6 +374,8 @@ static struct flash_info flash_types[] = {
 	  stfsm_n25q_config },
 	{ "n25q256", 0x20ba19, 0, 64 * 1024,  512,
 	  N25Q_FLAG | FLASH_FLAG_32BIT_ADDR, 108, stfsm_n25q_config },
+	{ "n25q512", 0x20ba20, 0, 64 * 1024,  1024,
+	  N25Q_FLAG | FLASH_FLAG_32BIT_ADDR, 108, stfsm_n25q_config},
 
 	/*
 	 * Spansion S25FLxxxP
-- 
1.9.1
