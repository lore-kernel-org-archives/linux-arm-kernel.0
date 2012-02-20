From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 20 Feb 2012 12:26:06 +0200
Subject: [PATCHv10 2/4] omap3: voltage: fix channel configuration
In-Reply-To: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
References: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
Message-ID: <1329733568-26676-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP3 uses the default settings for VDD1 channel, otherwise the settings will
overlap with VDD2 and attempting to modify VDD1 voltage will actually change
VDD2 voltage.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc3xxx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index a5ec7f8f..5d8eaf3 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -46,6 +46,7 @@ static struct omap_vc_common omap3_vc_common = {
 };
 
 struct omap_vc_channel omap3_vc_mpu = {
+	.flags = OMAP_VC_CHANNEL_DEFAULT,
 	.common = &omap3_vc_common,
 	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
 	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
-- 
1.7.4.1
