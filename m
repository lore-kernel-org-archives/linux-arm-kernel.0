From: joe@perches.com (Joe Perches)
Date: Sat, 13 Sep 2014 11:31:19 -0700
Subject: [PATCH 8/8] arm: mach-u300: Convert pr_warning to pr_warn
In-Reply-To: <cover.1410632834.git.joe@perches.com>
References: <cover.1410632834.git.joe@perches.com>
Message-ID: <b54e0c34addb2b9cc4c3a20d5afc8b27a3096d09.1410632835.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the more common pr_warn.

Other miscellanea:

o Coalesce formats
o Realign arguments
o typo fixes of Siple to Simple

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/mach-u300/dummyspichip.c | 65 +++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index ec0283c..1319968 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -80,8 +80,8 @@ static ssize_t dummy_looptest(struct device *dev,
 		"in 8bit mode\n");
 	status = spi_w8r8(spi, 0xAA);
 	if (status < 0)
-		pr_warning("Siple test 1: FAILURE: spi_write_then_read "
-			   "failed with status %d\n", status);
+		pr_warn("Simple test 1: FAILURE: spi_write_then_read failed with status %d\n",
+			status);
 	else
 		pr_info("Simple test 1: SUCCESS!\n");
 
@@ -89,8 +89,8 @@ static ssize_t dummy_looptest(struct device *dev,
 		"in 8bit mode (full FIFO)\n");
 	status = spi_write_then_read(spi, &txbuf[0], 8, &rxbuf[0], 8);
 	if (status < 0)
-		pr_warning("Simple test 2: FAILURE: spi_write_then_read() "
-			   "failed with status %d\n", status);
+		pr_warn("Simple test 2: FAILURE: spi_write_then_read() failed with status %d\n",
+			status);
 	else
 		pr_info("Simple test 2: SUCCESS!\n");
 
@@ -98,8 +98,8 @@ static ssize_t dummy_looptest(struct device *dev,
 		"in 8bit mode (see if we overflow FIFO)\n");
 	status = spi_write_then_read(spi, &txbuf[0], 14, &rxbuf[0], 14);
 	if (status < 0)
-		pr_warning("Simple test 3: FAILURE: failed with status %d "
-			   "(probably FIFO overrun)\n", status);
+		pr_warn("Simple test 3: FAILURE: failed with status %d (probably FIFO overrun)\n",
+			status);
 	else
 		pr_info("Simple test 3: SUCCESS!\n");
 
@@ -107,14 +107,14 @@ static ssize_t dummy_looptest(struct device *dev,
 		"bytes garbage with spi_read() in 8bit mode\n");
 	status = spi_write(spi, &txbuf[0], 8);
 	if (status < 0)
-		pr_warning("Simple test 4 step 1: FAILURE: spi_write() "
-			   "failed with status %d\n", status);
+		pr_warn("Simple test 4 step 1: FAILURE: spi_write() failed with status %d\n",
+			status);
 	else
 		pr_info("Simple test 4 step 1: SUCCESS!\n");
 	status = spi_read(spi, &rxbuf[0], 8);
 	if (status < 0)
-		pr_warning("Simple test 4 step 2: FAILURE: spi_read() "
-			   "failed with status %d\n", status);
+		pr_warn("Simple test 4 step 2: FAILURE: spi_read() failed with status %d\n",
+			status);
 	else
 		pr_info("Simple test 4 step 2: SUCCESS!\n");
 
@@ -122,16 +122,14 @@ static ssize_t dummy_looptest(struct device *dev,
 		"14 bytes garbage with spi_read() in 8bit mode\n");
 	status = spi_write(spi, &txbuf[0], 14);
 	if (status < 0)
-		pr_warning("Simple test 5 step 1: FAILURE: spi_write() "
-			   "failed with status %d (probably FIFO overrun)\n",
-			   status);
+		pr_warn("Simple test 5 step 1: FAILURE: spi_write() failed with status %d (probably FIFO overrun)\n",
+			status);
 	else
 		pr_info("Simple test 5 step 1: SUCCESS!\n");
 	status = spi_read(spi, &rxbuf[0], 14);
 	if (status < 0)
-		pr_warning("Simple test 5 step 2: FAILURE: spi_read() "
-			   "failed with status %d (probably FIFO overrun)\n",
-			   status);
+		pr_warn("Simple test 5 step 2: FAILURE: spi_read() failed with status %d (probably FIFO overrun)\n",
+			status);
 	else
 		pr_info("Simple test 5: SUCCESS!\n");
 
@@ -140,16 +138,14 @@ static ssize_t dummy_looptest(struct device *dev,
 		DMA_TEST_SIZE, DMA_TEST_SIZE);
 	status = spi_write(spi, &bigtxbuf_virtual[0], DMA_TEST_SIZE);
 	if (status < 0)
-		pr_warning("Simple test 6 step 1: FAILURE: spi_write() "
-			   "failed with status %d (probably FIFO overrun)\n",
-			   status);
+		pr_warn("Simple test 6 step 1: FAILURE: spi_write() failed with status %d (probably FIFO overrun)\n",
+			status);
 	else
 		pr_info("Simple test 6 step 1: SUCCESS!\n");
 	status = spi_read(spi, &bigrxbuf_virtual[0], DMA_TEST_SIZE);
 	if (status < 0)
-		pr_warning("Simple test 6 step 2: FAILURE: spi_read() "
-			   "failed with status %d (probably FIFO overrun)\n",
-			   status);
+		pr_warn("Simple test 6 step 2: FAILURE: spi_read() failed with status %d (probably FIFO overrun)\n",
+			status);
 	else
 		pr_info("Simple test 6: SUCCESS!\n");
 
@@ -169,18 +165,17 @@ static ssize_t dummy_looptest(struct device *dev,
 		pr_info("Simple test 7: SUCCESS! (expected failure with "
 			"status EIO)\n");
 	else if (status < 0)
-		pr_warning("Siple test 7: FAILURE: spi_write_then_read "
-			   "failed with status %d\n", status);
+		pr_warn("Simple test 7: FAILURE: spi_write_then_read failed with status %d\n",
+			status);
 	else
-		pr_warning("Siple test 7: FAILURE: spi_write_then_read "
-			   "succeeded but it was expected to fail!\n");
+		pr_warn("Simple test 7: FAILURE: spi_write_then_read succeeded but it was expected to fail!\n");
 
 	pr_info("Simple test 8: write 8 bytes, read back 8 bytes garbage "
 		"in 16bit mode (full FIFO)\n");
 	status = spi_write_then_read(spi, &txbuf[0], 8, &rxbuf[0], 8);
 	if (status < 0)
-		pr_warning("Simple test 8: FAILURE: spi_write_then_read() "
-			   "failed with status %d\n", status);
+		pr_warn("Simple test 8: FAILURE: spi_write_then_read() failed with status %d\n",
+			status);
 	else
 		pr_info("Simple test 8: SUCCESS!\n");
 
@@ -188,8 +183,8 @@ static ssize_t dummy_looptest(struct device *dev,
 		"in 16bit mode (see if we overflow FIFO)\n");
 	status = spi_write_then_read(spi, &txbuf[0], 14, &rxbuf[0], 14);
 	if (status < 0)
-		pr_warning("Simple test 9: FAILURE: failed with status %d "
-			   "(probably FIFO overrun)\n", status);
+		pr_warn("Simple test 9: FAILURE: failed with status %d (probably FIFO overrun)\n",
+			status);
 	else
 		pr_info("Simple test 9: SUCCESS!\n");
 
@@ -198,17 +193,15 @@ static ssize_t dummy_looptest(struct device *dev,
 	       DMA_TEST_SIZE, DMA_TEST_SIZE);
 	status = spi_write(spi, &bigtxbuf_virtual[0], DMA_TEST_SIZE);
 	if (status < 0)
-		pr_warning("Simple test 10 step 1: FAILURE: spi_write() "
-			   "failed with status %d (probably FIFO overrun)\n",
-			   status);
+		pr_warn("Simple test 10 step 1: FAILURE: spi_write() failed with status %d (probably FIFO overrun)\n",
+			status);
 	else
 		pr_info("Simple test 10 step 1: SUCCESS!\n");
 
 	status = spi_read(spi, &bigrxbuf_virtual[0], DMA_TEST_SIZE);
 	if (status < 0)
-		pr_warning("Simple test 10 step 2: FAILURE: spi_read() "
-			   "failed with status %d (probably FIFO overrun)\n",
-			   status);
+		pr_warn("Simple test 10 step 2: FAILURE: spi_read() failed with status %d (probably FIFO overrun)\n",
+			status);
 	else
 		pr_info("Simple test 10: SUCCESS!\n");
 
-- 
1.8.1.2.459.gbcd45b4.dirty
