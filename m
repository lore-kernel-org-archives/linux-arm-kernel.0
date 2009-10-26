From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 26 Oct 2009 11:55:58 +0100
Subject: [PATCH 4/5] ARM: MX3: Add pad config for MMC pins on lilly-db
In-Reply-To: <1256554559-17828-4-git-send-email-daniel@caiaq.de>
References: <1256554559-17828-1-git-send-email-daniel@caiaq.de>
	<1256554559-17828-2-git-send-email-daniel@caiaq.de>
	<1256554559-17828-3-git-send-email-daniel@caiaq.de>
	<1256554559-17828-4-git-send-email-daniel@caiaq.de>
Message-ID: <1256554559-17828-5-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mx31lilly-db.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lilly-db.c b/arch/arm/mach-mx3/mx31lilly-db.c
index 60f2d15..bb1e44f 100644
--- a/arch/arm/mach-mx3/mx31lilly-db.c
+++ b/arch/arm/mach-mx3/mx31lilly-db.c
@@ -111,6 +111,9 @@ static int mxc_mmc1_get_ro(struct device *dev)
 
 static int gpio_det, gpio_wp;
 
+#define MMC_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
+			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
+
 static int mxc_mmc1_init(struct device *dev,
 			 irq_handler_t detect_irq, void *data)
 {
@@ -119,6 +122,13 @@ static int mxc_mmc1_init(struct device *dev,
 	gpio_det = IOMUX_TO_GPIO(MX31_PIN_GPIO1_1);
 	gpio_wp = IOMUX_TO_GPIO(MX31_PIN_LCS0);
 
+	mxc_iomux_set_pad(MX31_PIN_SD1_DATA0, MMC_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SD1_DATA1, MMC_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SD1_DATA2, MMC_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SD1_DATA3, MMC_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SD1_CLK, MMC_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SD1_CMD, MMC_PAD_CFG);
+
 	ret = gpio_request(gpio_det, "MMC detect");
 	if (ret)
 		return ret;
-- 
1.6.5
