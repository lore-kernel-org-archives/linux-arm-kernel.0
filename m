From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  5 Apr 2013 11:57:48 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7779: add each clocks ratio on comment
 area
In-Reply-To: <1365130669-11662-1-git-send-email-horms+renesas@verge.net.au>
References: <1365130669-11662-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1365130669-11662-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Adding comment describing the r8a7779 clock frequencies depending on
MD pin settings.

Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 7d86bfb..5436b51 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -26,6 +26,25 @@
 #include <mach/clock.h>
 #include <mach/common.h>
 
+/*
+ *		MD1 = 1			MD1 = 0
+ *		(PLLA = 1500)		(PLLA = 1600)
+ *		(MHz)			(MHz)
+ *------------------------------------------------+--------------------
+ * clkz		1000   (2/3)		800   (1/2)
+ * clkzs	 250   (1/6)		200   (1/8)
+ * clki		 750   (1/2)		800   (1/2)
+ * clks		 250   (1/6)		200   (1/8)
+ * clks1	 125   (1/12)		100   (1/16)
+ * clks3	 187.5 (1/8)		200   (1/8)
+ * clks4	  93.7 (1/16)		100   (1/16)
+ * clkp		  62.5 (1/24)		 50   (1/32)
+ * clkg		  62.5 (1/24)		 66.6 (1/24)
+ * clkb, CLKOUT
+ * (MD2 = 0)	  62.5 (1/24)		 66.6 (1/24)
+ * (MD2 = 1)	  41.6 (1/36)		 50   (1/32)
+*/
+
 #define MD(nr)	BIT(nr)
 
 #define FRQMR		IOMEM(0xffc80014)
-- 
1.7.10.4
