From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed,  6 Oct 2010 00:42:53 -0700
Subject: [PATCH 14/20 v2] msm: physical offset for MSM8X60
In-Reply-To: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
References: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1286350979-19328-15-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSM8x60 has a different physical memory offset than other targets.

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/memory.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
index 50c7847..070e17d 100644
--- a/arch/arm/mach-msm/include/mach/memory.h
+++ b/arch/arm/mach-msm/include/mach/memory.h
@@ -23,6 +23,8 @@
 #define PHYS_OFFSET		UL(0x20000000)
 #elif defined(CONFIG_ARCH_MSM7X30)
 #define PHYS_OFFSET		UL(0x00200000)
+#elif defined(CONFIG_ARCH_MSM8X60)
+#define PHYS_OFFSET		UL(0x40200000)
 #else
 #define PHYS_OFFSET		UL(0x10000000)
 #endif
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
