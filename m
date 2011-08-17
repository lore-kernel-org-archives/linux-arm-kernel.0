From: alim.akhtar@samsung.com (alim akhtar)
Date: Wed, 17 Aug 2011 09:36:08 +0530
Subject: [PATCH 2/3] ARM: S5PV210: register the second instance of pl330 DMAC
In-Reply-To: <1313553969-14639-1-git-send-email-alim.akhtar@samsung.com>
References: <1313553969-14639-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1313553969-14639-3-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alim Akhtar <alim.akhtar@samsung.com>

Platform data is provided for two instance of pl330 DMAC,
but only one DMAC is register with amba_device.
This patch register the second instance.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/mach-s5pv210/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/dma.c b/arch/arm/mach-s5pv210/dma.c
index f79d0b0..86b749c 100644
--- a/arch/arm/mach-s5pv210/dma.c
+++ b/arch/arm/mach-s5pv210/dma.c
@@ -254,6 +254,7 @@ struct amba_device s5pv210_device_pdma1 = {
 static int __init s5pv210_dma_init(void)
 {
 	amba_device_register(&s5pv210_device_pdma0, &iomem_resource);
+	amba_device_register(&s5pv210_device_pdma1, &iomem_resource);
 
 	return 0;
 }
-- 
1.7.2.3
