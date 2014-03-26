From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Mar 2014 16:39:19 +0000
Subject: [PATCH 05/15] mtd: st_spi_fsm: Add Spansion S25FL032P to device table
In-Reply-To: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
References: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395851969-13520-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Angus Clark <angus.clark@st.com>

Add Spansion S25FL032P to the list of known devices.

Signed-off-by: Angus Clark <angus.clark@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index d6b352e..148c86f 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -413,6 +413,8 @@ static struct flash_info flash_types[] = {
 			FLASH_FLAG_READ_1_4_4   |	\
 			FLASH_FLAG_WRITE_1_1_4  |	\
 			FLASH_FLAG_READ_FAST)
+	{ "s25fl032p",  0x010215, 0x4d00,  64 * 1024,  64, S25FLXXXP_FLAG, 80,
+	  stfsm_s25fl_config},
 	{ "s25fl129p0", 0x012018, 0x4d00, 256 * 1024,  64, S25FLXXXP_FLAG, 80,
 	  stfsm_s25fl_config },
 	{ "s25fl129p1", 0x012018, 0x4d01,  64 * 1024, 256, S25FLXXXP_FLAG, 80,
-- 
1.8.3.2
