From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 20 Jan 2011 12:32:40 -0800
Subject: [PATCH 2/7] [ARM] msm: qsd8k memory base is at 0x20000000
In-Reply-To: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
References: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1295555565-21563-3-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brian Swetland <swetland@google.com>

The memory layout is effective as of AMSS 3170+.

Signed-off-by: Haley Teng <haley_teng@htc.com>
Signed-off-by: Dima Zavin <dima@android.com>
---
 arch/arm/mach-msm/Makefile.boot |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/Makefile.boot b/arch/arm/mach-msm/Makefile.boot
index 24dfbf8..3266727 100644
--- a/arch/arm/mach-msm/Makefile.boot
+++ b/arch/arm/mach-msm/Makefile.boot
@@ -1,3 +1,8 @@
   zreladdr-y		:= 0x10008000
 params_phys-y		:= 0x10000100
 initrd_phys-y		:= 0x10800000
+
+# for now, override for QSD8x50
+  zreladdr-$(CONFIG_ARCH_QSD8X50)		:= 0x20008000
+params_phys-$(CONFIG_ARCH_QSD8X50)		:= 0x20000100
+initrd_phys-$(CONFIG_ARCH_QSD8X50)		:= 0x21000000
-- 
1.7.0.4

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
