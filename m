From: yong.shen@linaro.org (yong.shen at linaro.org)
Date: Thu, 17 Feb 2011 10:01:37 +0100
Subject: [PATCH v3 1/3] ARM: IMX: add tzic_enable_wake in the head file
In-Reply-To: <1297933299-30367-1-git-send-email-yong.shen@linaro.org>
References: <1297933299-30367-1-git-send-email-yong.shen@linaro.org>
Message-ID: <1297933299-30367-2-git-send-email-yong.shen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

Add tzic_enable_wake in the head file, so other code can call it.

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/plat-mxc/include/mach/mxc.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 04c7a26..962d742 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -182,6 +182,7 @@ struct cpu_op {
 };
 
 extern struct cpu_op *(*get_cpu_op)(int *op);
+extern int tzic_enable_wake(int is_idle);
 #endif
 
 #if defined(CONFIG_ARCH_MX3) || defined(CONFIG_ARCH_MX2)
-- 
1.7.1
