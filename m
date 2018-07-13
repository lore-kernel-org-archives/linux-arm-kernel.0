From: oliver.huebers@web.de (=?UTF-8?q?Oliver=20H=C3=BCbers?=)
Date: Fri, 13 Jul 2018 15:41:05 +0200
Subject: [PATCH 3/4] staging: mt7621: Add braces around macro argument
In-Reply-To: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
References: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
Message-ID: <1531489266-20410-3-git-send-email-oliver.huebers@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add braces around macro argument to avoid precedence problems.
This fixes the corresponding checkpatch warning.

Signed-off-by: Oliver H?bers <oliver.huebers@web.de>
Signed-off-by: Vanessa Borgmann <nessa.x@web.de>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index d0d3fb9..c118d78 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -132,7 +132,8 @@
 		else							\
 			rt_sysc_m32(val, 0, RALINK_RSTCTRL);		\
 	} while (0)
-#define DEASSERT_SYSRST_PCIE(val)	\
+
+#define DEASSERT_SYSRST_PCIE(val)					\
 	do {								\
 		if (rt_sysc_r32(SYSC_REG_CHIP_REV) == 0x00030101)	\
 			rt_sysc_m32(val, 0, RALINK_RSTCTRL);		\
-- 
2.7.4
