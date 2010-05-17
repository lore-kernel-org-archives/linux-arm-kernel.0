From: jassi.brar@samsung.com (Jassi Brar)
Date: Mon, 17 May 2010 10:35:29 +0900
Subject: [PATCH 1/6] S3C: DMA: Change argument of s3c2410_dma_devconfig
In-Reply-To: <1274060104-14224-1-git-send-email-jassi.brar@samsung.com>
References: <1274060104-14224-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274060129-14256-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All other functions have the channel argument of type 'unsigned int'
the s3c2410_dma_devconfig also accept the same value as argument but
treat it as type 'int'. Remove this anomaly by make it 'unsigned int'.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c64xx/dma.c              |    2 +-
 arch/arm/plat-s3c24xx/dma.c              |    2 +-
 arch/arm/plat-samsung/include/plat/dma.h |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index b62bdf1..b4d6865 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -413,7 +413,7 @@ err_buff:
 EXPORT_SYMBOL(s3c2410_dma_enqueue);
 
 
-int s3c2410_dma_devconfig(int channel,
+int s3c2410_dma_devconfig(unsigned int channel,
 			  enum s3c2410_dmasrc source,
 			  unsigned long devaddr)
 {
diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index 93827b3..6ad274e 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -1104,7 +1104,7 @@ EXPORT_SYMBOL(s3c2410_dma_config);
  * devaddr:   physical address of the source
 */
 
-int s3c2410_dma_devconfig(int channel,
+int s3c2410_dma_devconfig(unsigned int channel,
 			  enum s3c2410_dmasrc source,
 			  unsigned long devaddr)
 {
diff --git a/arch/arm/plat-samsung/include/plat/dma.h b/arch/arm/plat-samsung/include/plat/dma.h
index 7584d75..2e8f8c6 100644
--- a/arch/arm/plat-samsung/include/plat/dma.h
+++ b/arch/arm/plat-samsung/include/plat/dma.h
@@ -110,8 +110,8 @@ extern int s3c2410_dma_config(unsigned int channel, int xferunit);
  * configure the device we're talking to
 */
 
-extern int s3c2410_dma_devconfig(int channel, enum s3c2410_dmasrc source,
-				 unsigned long devaddr);
+extern int s3c2410_dma_devconfig(unsigned int channel,
+		enum s3c2410_dmasrc source, unsigned long devaddr);
 
 /* s3c2410_dma_getposition
  *
-- 
1.6.2.5
