From: lexszero@gmail.com (Alexey Ignatov)
Date: Fri, 10 Apr 2015 02:00:51 +0300
Subject: [PATCH 2/2] davinci: DM365: Enable VCIF interrupt
In-Reply-To: <1428620479-32696-1-git-send-email-lexszero@gmail.com>
References: <1428620479-32696-1-git-send-email-lexszero@gmail.com>
Message-ID: <1428620479-32696-2-git-send-email-lexszero@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables VCIF interrupt for DM365.

Signed-off-by: Alexey Ignatov <lexszero@gmail.com>
---
 arch/arm/mach-davinci/dm365.c            | 3 +++
 arch/arm/mach-davinci/include/mach/mux.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 0ae8114..a83ef2e 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -632,6 +632,8 @@ INT_CFG(DM365,  INT_IMX1_ENABLE,     24,    1,    1,     false)
 INT_CFG(DM365,  INT_IMX1_DISABLE,    24,    1,    0,     false)
 INT_CFG(DM365,  INT_NSF_ENABLE,      25,    1,    1,     false)
 INT_CFG(DM365,  INT_NSF_DISABLE,     25,    1,    0,     false)
+INT_CFG(DM365,  INT_VCIF_ENABLE,     7,     1,    1,     false)
+INT_CFG(DM365,  INT_VCIF_DISABLE,    7,     1,    0,     false)
 
 EVT_CFG(DM365,	EVT2_ASP_TX,         0,     1,    0,     false)
 EVT_CFG(DM365,	EVT3_ASP_RX,         1,     1,    0,     false)
@@ -1138,6 +1140,7 @@ void __init dm365_init_vc(struct snd_platform_data *pdata)
 {
 	davinci_cfg_reg(DM365_EVT2_VC_TX);
 	davinci_cfg_reg(DM365_EVT3_VC_RX);
+	davinci_cfg_reg(DM365_INT_VCIF_ENABLE);
 	dm365_vc_device.dev.platform_data = pdata;
 	platform_device_register(&dm365_vc_device);
 }
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 631655e..1308731 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -335,6 +335,8 @@ enum davinci_dm365_index {
 	DM365_INT_IMX1_DISABLE,
 	DM365_INT_NSF_ENABLE,
 	DM365_INT_NSF_DISABLE,
+	DM365_INT_VCIF_ENABLE,
+	DM365_INT_VCIF_DISABLE,
 
 	/* EDMA event muxing */
 	DM365_EVT2_ASP_TX,
-- 
2.3.5
