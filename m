From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 04 Jun 2012 08:16:31 +0530
Subject: [PATCH] ARM: S3C64XX: Add a new dma request id for device tree based
 dma channel lookup
Message-ID: <1338777991-27194-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4972a80e16a2 (ARM: SAMSUNG: Add device tree support for pl330 dma engine
wrappers) introduced a new member 'dt_dmach_prop' in the struct samsung_dma_info
which is used to specify the dma channel number property as obtained from the
device tree. It also introduced a new dma request id 'DMACH_DT_PROP' to indicate
that a device tree node property represting the dma channel is available in
'struct samsung_dma_info'.

Add dma request id 'DMACH_DT_PROP' in s3c64xx dma channel id list in order to
maintain compatibility to the changes in the Samsung dma wrappper operations.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-s3c64xx/include/mach/dma.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/include/mach/dma.h b/arch/arm/mach-s3c64xx/include/mach/dma.h
index fe1a98c..57b1ff4 100644
--- a/arch/arm/mach-s3c64xx/include/mach/dma.h
+++ b/arch/arm/mach-s3c64xx/include/mach/dma.h
@@ -21,6 +21,7 @@
  */
 enum dma_ch {
 	/* DMA0/SDMA0 */
+	DMACH_DT_PROP = -1, /* not yet supported, do not use */
 	DMACH_UART0 = 0,
 	DMACH_UART0_SRC2,
 	DMACH_UART1,
-- 
1.6.6.rc2
