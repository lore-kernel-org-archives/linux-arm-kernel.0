From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 22 Apr 2011 17:38:28 +0530
Subject: [PATCH v4 10/11] da850: pruss CAN platform specific additions.
In-Reply-To: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1303474109-6212-11-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the necessary pins for the pruss CAN.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/da850.c            |    5 +++++
 arch/arm/mach-davinci/include/mach/mux.h |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index a7cf2d0..84a5e64 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -581,7 +581,12 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, EMA_CLK,		6,	0,	15,	1,	false)
 	MUX_CFG(DA850, EMA_WAIT_1,	6,	24,	15,	1,	false)
 	MUX_CFG(DA850, NEMA_CS_2,	7,	0,	15,	1,	false)
+	/* PRU functions for soft CAN */
+	MUX_CFG(DA850, PRUSS_PRU0_R31_0,	7,	28,	15,	0,	false)
+	MUX_CFG(DA850, PRUSS_PRU1_R30_15,	12,	0,	15,	4,	false)
+	MUX_CFG(DA850, PRUSS_PRU1_R31_18,	11,	20,	15,	0,	false)
 	/* GPIO function */
+	MUX_CFG(DA850, GPIO2_0,		6,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO2_4,		6,	12,	15,	8,	false)
 	MUX_CFG(DA850, GPIO2_6,		6,	4,	15,	8,	false)
 	MUX_CFG(DA850, GPIO2_8,		5,	28,	15,	8,	false)
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 5d4e0fe..85b3a0d 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -906,8 +906,13 @@ enum davinci_da850_index {
 	DA850_EMA_CLK,
 	DA850_EMA_WAIT_1,
 	DA850_NEMA_CS_2,
+	/* PRU I/O */
+	DA850_PRUSS_PRU0_R31_0,
+	DA850_PRUSS_PRU1_R30_15,
+	DA850_PRUSS_PRU1_R31_18,
 
 	/* GPIO function */
+	DA850_GPIO2_0,
 	DA850_GPIO2_4,
 	DA850_GPIO2_6,
 	DA850_GPIO2_8,
-- 
1.7.2.3
