From: vm.rod25@gmail.com (vm.rod25 at gmail.com)
Date: Fri, 12 Nov 2010 16:38:52 -0600
Subject: [PATCH v8 6/9] davinci: MMC/SD and USB-OHCI configuration for
	Omapl138-Hawkboard
In-Reply-To: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
Message-ID: <1289601535-6746-7-git-send-email-vm.rod25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch defines Pin Mux configuration to enable MMC/SD
and USB-OHCI on the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
Tested-by: Rene Gonzalez <renegs.2378@gmail.com>
---
 arch/arm/mach-davinci/da850.c            |    4 ++++
 arch/arm/mach-davinci/include/mach/mux.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index f033a0a..4458bff 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -543,11 +543,15 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, EMA_WAIT_1,	6,	24,	15,	1,	false)
 	MUX_CFG(DA850, NEMA_CS_2,	7,	0,	15,	1,	false)
 	/* GPIO function */
+	MUX_CFG(DA850, GPIO2_4,		6,	12,	15,	8,	false)
 	MUX_CFG(DA850, GPIO2_6,		6,	4,	15,	8,	false)
 	MUX_CFG(DA850, GPIO2_8,		5,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO2_15,	5,	0,	15,	8,	false)
+	MUX_CFG(DA850, GPIO3_12,	7,	12,	15,	8,	false)
+	MUX_CFG(DA850, GPIO3_13,	7,	8,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_0,		10,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_1,		10,	24,	15,	8,	false)
+	MUX_CFG(DA850, GPIO6_13,	13,	8,	15,	8,	false)
 	MUX_CFG(DA850, RTC_ALARM,	0,	28,	15,	2,	false)
 #endif
 };
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index de11aac..5d4e0fe 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -908,11 +908,15 @@ enum davinci_da850_index {
 	DA850_NEMA_CS_2,
 
 	/* GPIO function */
+	DA850_GPIO2_4,
 	DA850_GPIO2_6,
 	DA850_GPIO2_8,
 	DA850_GPIO2_15,
+	DA850_GPIO3_12,
+	DA850_GPIO3_13,
 	DA850_GPIO4_0,
 	DA850_GPIO4_1,
+	DA850_GPIO6_13,
 	DA850_RTC_ALARM,
 };
 
-- 
1.7.0.4
