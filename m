From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 14:42:45 +0800
Subject: [PATCH 2/5] ARM: imx: add audmux pad setting for imx51-babbage
In-Reply-To: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336718568-26810-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before i.MX51 Pinctrl support is available, we have to reply on
the iomux initialization in non-DT board file to set iomux up for
DT boot.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-mx51_babbage.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx51_babbage.c b/arch/arm/mach-imx/mach-mx51_babbage.c
index e4b822e..517672e 100644
--- a/arch/arm/mach-imx/mach-mx51_babbage.c
+++ b/arch/arm/mach-imx/mach-mx51_babbage.c
@@ -163,6 +163,12 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
 	MX51_PAD_CSPI1_SS0__GPIO4_24,
 	MX51_PAD_CSPI1_SS1__GPIO4_25,
+
+	/* Audio */
+	MX51_PAD_AUD3_BB_TXD__AUD3_TXD,
+	MX51_PAD_AUD3_BB_RXD__AUD3_RXD,
+	MX51_PAD_AUD3_BB_CK__AUD3_TXC,
+	MX51_PAD_AUD3_BB_FS__AUD3_TXFS,
 };
 
 /* Serial ports */
-- 
1.7.5.4
