From: alim.akhtar@samsung.com (alim akhtar)
Date: Wed, 17 Aug 2011 09:36:09 +0530
Subject: [PATCH 3/3] ARM: S5PC100: register the second instance of pl330 DMAC
In-Reply-To: <1313553969-14639-1-git-send-email-alim.akhtar@samsung.com>
References: <1313553969-14639-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1313553969-14639-4-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alim Akhtar <alim.akhtar@samsung.com>

Platform data is provided for two instance of pl330 DMAC,
but only one DMAC is register with amba_device.
This patch register the second instance.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/mach-s5pc100/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
index ef803e9..065a087 100644
--- a/arch/arm/mach-s5pc100/dma.c
+++ b/arch/arm/mach-s5pc100/dma.c
@@ -260,6 +260,7 @@ struct amba_device s5pc100_device_pdma1 = {
 static int __init s5pc100_dma_init(void)
 {
 	amba_device_register(&s5pc100_device_pdma0, &iomem_resource);
+	amba_device_register(&s5pc100_device_pdma1, &iomem_resource);
 
 	return 0;
 }
-- 
1.7.2.3
