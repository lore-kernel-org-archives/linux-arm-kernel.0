From: davidb@codeaurora.org (David Brown)
Date: Wed, 30 Nov 2011 16:29:04 -0800
Subject: [PATCH 3/3] ARM: msm: Remove cpu_is test for msm7201 soc
In-Reply-To: <1322699344-28422-1-git-send-email-davidb@codeaurora.org>
References: <1322699344-28422-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1322699344-28422-3-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the last bits of this target are gone, the CPU test is no
longer useful.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/cpu.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/cpu.h b/arch/arm/mach-msm/include/mach/cpu.h
index a9481b0..e5e7fb5 100644
--- a/arch/arm/mach-msm/include/mach/cpu.h
+++ b/arch/arm/mach-msm/include/mach/cpu.h
@@ -20,17 +20,11 @@
 
 /* TODO: For now, only one CPU can be compiled at a time. */
 
-#define cpu_is_msm7x01()	0
 #define cpu_is_msm7x30()	0
 #define cpu_is_qsd8x50()	0
 #define cpu_is_msm8x60()	0
 #define cpu_is_msm8960()	0
 
-#ifdef CONFIG_ARCH_MSM7X00A
-# undef cpu_is_msm7x01
-# define cpu_is_msm7x01()	1
-#endif
-
 #ifdef CONFIG_ARCH_MSM7X30
 # undef cpu_is_msm7x30
 # define cpu_is_msm7x30()	1
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
