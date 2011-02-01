From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue,  1 Feb 2011 20:17:44 +0530
Subject: [PATCH v1 6/9] da850: pruss CAN platform specific additions.
In-Reply-To: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1296571667-12049-7-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the necessary pins for the pruss CAN.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/da850.c            |    4 ++++
 arch/arm/mach-davinci/include/mach/mux.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 341d836..11ce7ba 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -565,6 +565,10 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, EMA_CLK,		6,	0,	15,	1,	false)
 	MUX_CFG(DA850, EMA_WAIT_1,	6,	24,	15,	1,	false)
 	MUX_CFG(DA850, NEMA_CS_2,	7,	0,	15,	1,	false)
+	/* PRU functions for soft CAN */
+	MUX_CFG(DA850, PRUSS_PRU0_R31_0,	7,	28,	15,	0,	false)
+	MUX_CFG(DA850, PRUSS_PRU1_R30_15,	12,	0,	15,	4,	false)
+	MUX_CFG(DA850, PRUSS_PRU1_R31_18,	11,	20,	15,	0,	false)
 	/* GPIO function */
 	MUX_CFG(DA850, GPIO2_4,		6,	12,	15,	8,	false)
 	MUX_CFG(DA850, GPIO2_6,		6,	4,	15,	8,	false)
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 5d4e0fe..10f49f2 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -906,6 +906,10 @@ enum davinci_da850_index {
 	DA850_EMA_CLK,
 	DA850_EMA_WAIT_1,
 	DA850_NEMA_CS_2,
+	/* PRU I/O */
+	DA850_PRUSS_PRU0_R31_0,
+	DA850_PRUSS_PRU1_R30_15,
+	DA850_PRUSS_PRU1_R31_18,
 
 	/* GPIO function */
 	DA850_GPIO2_4,
-- 
1.7.2.3
