From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 18 Jan 2013 15:31:49 +0100
Subject: [PATCH v2 1/8] ARM: OMAP: 3430sdp: Enable extmute functionality for
 audio
In-Reply-To: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
References: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1358519516-13165-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the use of extmute on the HS path.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index bb73afc..40c22a7 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -382,6 +382,9 @@ static int __init omap3430_i2c_init(void)
 	sdp3430_twldata.vpll2->constraints.apply_uV = true;
 	sdp3430_twldata.vpll2->constraints.name = "VDVI";
 
+	sdp3430_twldata.audio->codec->hs_extmute = 1;
+	sdp3430_twldata.audio->codec->hs_extmute_gpio = -EINVAL;
+
 	omap3_pmic_init("twl4030", &sdp3430_twldata);
 
 	/* i2c2 on camera connector (for sensor control) and optional isp1301 */
-- 
1.8.1
