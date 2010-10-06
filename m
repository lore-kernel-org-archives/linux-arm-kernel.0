From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed,  6 Oct 2010 00:42:49 -0700
Subject: [PATCH 10/20 v2] msm: dma: add stub functions for dma features not
	yet present on 8x60
In-Reply-To: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
References: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1286350979-19328-11-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Walker <dwalker@codeaurora.org>

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/dma.h |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/dma.h b/arch/arm/mach-msm/include/mach/dma.h
index 00f9bbf..05583f5 100644
--- a/arch/arm/mach-msm/include/mach/dma.h
+++ b/arch/arm/mach-msm/include/mach/dma.h
@@ -32,10 +32,18 @@ struct msm_dmov_cmd {
 	void *data;
 };
 
+#ifndef CONFIG_ARCH_MSM8X60
 void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd);
 void msm_dmov_stop_cmd(unsigned id, struct msm_dmov_cmd *cmd, int graceful);
 int msm_dmov_exec_cmd(unsigned id, unsigned int cmdptr);
-
+#else
+static inline
+void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd) { }
+static inline
+void msm_dmov_stop_cmd(unsigned id, struct msm_dmov_cmd *cmd, int graceful) { }
+static inline
+int msm_dmov_exec_cmd(unsigned id, unsigned int cmdptr) { return -EIO; }
+#endif
 
 
 #define DMOV_SD0(off, ch) (MSM_DMOV_BASE + 0x0000 + (off) + ((ch) << 2))
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
