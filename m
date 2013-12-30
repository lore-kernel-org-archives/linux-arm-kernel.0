From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Dec 2013 13:15:30 -0800
Subject: [PATCH v2 4/7] ARM: msm: Only build clock.c on proc_comm based
 platforms
In-Reply-To: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
References: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1388438133-431-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The functionality provided by clock.c in mach-msm is only needed
on proc_comm based platforms. Only build the file if proc_comm is
enabled. This prevents compile failures for platforms that are
part of the multi-platform kernel.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 7ed4c1b..6baae6e 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -1,5 +1,5 @@
 obj-y += timer.o
-obj-y += clock.o
+obj-$(CONFIG_MSM_PROC_COMM) += clock.o
 
 obj-$(CONFIG_MSM_VIC) += irq-vic.o
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
