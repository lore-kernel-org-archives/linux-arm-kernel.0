From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 24 May 2018 17:07:13 +0200
Subject: [PATCH v2 1/9] ARM: shmobile: defconfig: Enable MTD command line
 partition parsing
Message-ID: <20180524150721.28964-1-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for removing MTD partitioning from the DTs and moving
it over to kernel command line partition parsing, enable the support
for kernel command line MTD partition parsing.

The argument for not having MTD partitions in the DT is the same as
for not having hard drive partitions in DT, neither describes the
hardware itself, so it shouldn't be in the DT. Furthermore, kernel
command line MTD partition passing allows greater flexibility in
case someone decided to repartition the flash, which is well in the
realm of possibility with these systems.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc at vger.kernel.org
---
V2: No change
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b49887e86a3d..4d0d5a00a188 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -64,6 +64,7 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
-- 
2.16.2
