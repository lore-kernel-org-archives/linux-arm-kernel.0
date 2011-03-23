From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 23 Mar 2011 08:15:42 -0400
Subject: [PATCH 2/2] davinci: mityomapl138: Use auto-probe to determine
	attached PHY ID
In-Reply-To: <1300882542-26039-1-git-send-email-michael.williamson@criticallink.com>
References: <1300882542-26039-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1300882542-26039-2-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current board configurations involving the MityDSP-L138 and MityARM-1808
only have one attached PHY, but it's address may not be the same.  Default
the behavior to auto-probe for the PHY and use the first one found.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index e5d554c..606a6f2 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -29,7 +29,7 @@
 #include <mach/mux.h>
 #include <mach/spi.h>
 
-#define MITYOMAPL138_PHY_ID		"0:03"
+#define MITYOMAPL138_PHY_ID		""
 
 #define FACTORY_CONFIG_MAGIC	0x012C0138
 #define FACTORY_CONFIG_VERSION	0x00010001
-- 
1.7.0.4
