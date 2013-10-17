From: denis@eukrea.com (Denis Carikli)
Date: Thu, 17 Oct 2013 17:02:35 +0200
Subject: [Patch v2][ 37/37] ARM: imx_v6_v7_defconfig: Enable heartbeat led
 trigger.
In-Reply-To: <1382022155-21954-1-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
Message-ID: <1382022155-21954-38-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eukrea mbimxsd35 and mbimxsd51 have a gpio led that used to be
  in heartbeat mode, so we turn that driver on.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 2e05e22..574299c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -209,6 +209,9 @@ CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_PCF8563=y
-- 
1.7.9.5
