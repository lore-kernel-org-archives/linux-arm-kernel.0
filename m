From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Mon, 30 Jul 2012 17:53:50 -0700
Subject: [PATCH 1/2] msm: io: Remove 7x30 iomap region from 7x00
Message-ID: <1343696030-11403-1-git-send-email-rvaswani@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is redundant code.

Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
---
 arch/arm/mach-msm/io.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index 5835c96..61d61cb 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -51,9 +51,6 @@ static struct map_desc msm_io_desc[] __initdata = {
 	defined(CONFIG_DEBUG_MSM_UART3)
 	MSM_DEVICE(DEBUG_UART),
 #endif
-#ifdef CONFIG_ARCH_MSM7X30
-	MSM_DEVICE(GCC),
-#endif
 	{
 		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
 		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS),
-- 
Sent by an employee of the Qualcomm Innovation Center,Inc
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
