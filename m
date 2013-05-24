From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 May 2013 01:45:11 -0400
Subject: [PATCH 8/8] ARM: vexpress/dcscb: select multi-cluster SMP operations
In-Reply-To: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
References: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1369374311-21260-9-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the DCSCB code is successfully probed and initialized, then the
generic MCPM SPM ops should be used as those operations need to be
arbitrated through the MCPM layer.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-vexpress/dcscb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 1acc975360..ce3118dc05 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -239,6 +239,8 @@ static int __init dcscb_init(void)
 		return ret;
 	}
 
+	mcpm_smp_set_ops();
+
 	pr_info("VExpress DCSCB support installed\n");
 
 	/*
-- 
1.8.1.2
