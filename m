From: eltshanli@gmail.com (Li Jie)
Date: Thu, 17 Dec 2009 15:05:09 +0800
Subject: [PATCH] ARM: NUC900: Fix type error
Message-ID: <8fb2581d0912162305l782a4fd6qb4641dc11b2d463d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Wan:

When I compiling latest kernel code, I met following error:
  CC      arch/arm/mach-w90x900/dev.o
arch/arm/mach-w90x900/dev.c:200: error: variable
?nuc900_spiflash_data? has initializer but incomplete type

We should use nuc900_spi_info instead of w90p910_spi_info, right ?

Signed-off-by: lijie <eltshanli@gmail.com>
---
 arch/arm/mach-w90x900/dev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 51f17b7..ec711f4 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -197,7 +197,7 @@ static struct platform_device nuc900_device_emc = {

 /* SPI device */

-static struct w90p910_spi_info nuc900_spiflash_data = {
+static struct nuc900_spi_info nuc900_spiflash_data = {
 	.num_cs		= 1,
 	.lsb		= 0,
 	.txneg		= 1,
-- 
1.6.5.4
