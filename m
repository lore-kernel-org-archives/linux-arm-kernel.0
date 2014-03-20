From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 20 Mar 2014 02:48:20 -0700
Subject: [PATCH v6 00/36] mtd: st_spi_fsm: Add new driver
In-Reply-To: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140320094820.GJ31517@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 09:20:32AM +0000, Lee Jones wrote:
> This should be the final version (again) :)
> 
> Version 6:
>   Serviced 3 nits picked up by Brian during final review.

I'm really sorry to do this again, but can you *please* read *all* of my
comments? You're missing at least the following diff! I'm fine with an
incremental patch on top of this series.

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index aefd48db7ade..6369636e980a 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -3,7 +3,7 @@
  *
  * Author: Angus Clark <angus.clark@st.com>
  *
- * Copyright (C) 2010-2014 STicroelectronics Limited
+ * Copyright (C) 2010-2014 STMicroelectronics Limited
  *
  * JEDEC probe based on drivers/mtd/devices/m25p80.c
  *
@@ -1730,14 +1730,6 @@ static int stfsm_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	dev_dbg(fsm->dev, "%s to 0x%08x, len %zd\n", __func__, (u32)to, len);
 
-	*retlen = 0;
-
-	if (!len)
-		return 0;
-
-	if (to + len > mtd->size)
-		return -EINVAL;
-
 	/* Offset within page */
 	page_offs = to % FLASH_PAGESIZE;
 
