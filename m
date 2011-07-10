From: ido@wizery.com (Ido Yariv)
Date: Sun, 10 Jul 2011 16:14:37 +0300
Subject: [PATCH v2 4/6] arm: davinci: DA850: Add MMC/SD1 pinmux configuration
In-Reply-To: <1310303679-17936-1-git-send-email-ido@wizery.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
Message-ID: <1310303679-17936-5-git-send-email-ido@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM18x has two MMC slots. Add the required pinmux configuration for the
second slot.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 arch/arm/mach-davinci/da850.c            |    7 +++++++
 arch/arm/mach-davinci/include/mach/mux.h |    8 ++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 133aac4..f6eafb4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -525,6 +525,13 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, MMCSD0_DAT_3,	10,	20,	15,	2,	false)
 	MUX_CFG(DA850, MMCSD0_CLK,	10,	0,	15,	2,	false)
 	MUX_CFG(DA850, MMCSD0_CMD,	10,	4,	15,	2,	false)
+	/* MMC/SD1 function */
+	MUX_CFG(DA850, MMCSD1_DAT_0,	18,	8,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_DAT_1,	19,	16,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_DAT_2,	19,	12,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_DAT_3,	19,	8,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_CLK,	18,	12,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_CMD,	18,	16,	15,	2,	false)
 	/* EMIF2.5/EMIFA function */
 	MUX_CFG(DA850, EMA_D_7,		9,	0,	15,	1,	false)
 	MUX_CFG(DA850, EMA_D_6,		9,	4,	15,	1,	false)
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 5d4e0fe..7fb7f1e 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -857,6 +857,14 @@ enum davinci_da850_index {
 	DA850_MMCSD0_CLK,
 	DA850_MMCSD0_CMD,
 
+	/* MMC/SD1 function */
+	DA850_MMCSD1_DAT_0,
+	DA850_MMCSD1_DAT_1,
+	DA850_MMCSD1_DAT_2,
+	DA850_MMCSD1_DAT_3,
+	DA850_MMCSD1_CLK,
+	DA850_MMCSD1_CMD,
+
 	/* EMIF2.5/EMIFA function */
 	DA850_EMA_D_7,
 	DA850_EMA_D_6,
-- 
1.7.4.1
