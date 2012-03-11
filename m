From: robherring2@gmail.com (Rob Herring)
Date: Sun, 11 Mar 2012 16:08:18 -0500
Subject: [PATCH 2/4] ARM: iop13xx: fix missing declaration of
 iop13xx_init_early
In-Reply-To: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331500100-31351-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Commit 1dfe34ae794c13 (ARM: iop13xx: use runtime ioremap hook) missed
a declaration of iop13xx_init_early resulting in a build error.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-iop13xx/include/mach/iop13xx.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-iop13xx/include/mach/iop13xx.h b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
index 07e9ff7..e190dcd 100644
--- a/arch/arm/mach-iop13xx/include/mach/iop13xx.h
+++ b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
@@ -5,6 +5,7 @@
 /* The ATU offsets can change based on the strapping */
 extern u32 iop13xx_atux_pmmr_offset;
 extern u32 iop13xx_atue_pmmr_offset;
+void iop13xx_init_early(void);
 void iop13xx_init_irq(void);
 void iop13xx_map_io(void);
 void iop13xx_platform_init(void);
-- 
1.7.5.4
