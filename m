From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 17:06:16 +0300
Subject: [PATCH v2 01/20] ARM: omap2plus_defconfig: Enable audio related
 config options
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1435845995-19085-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More and more boards are moving to have audio support via simple-card.
At the same time enable options needed for most am335x and am43xx board for
audio support: McASP and TLV320AIC3X codecs.
The later two has been selected by the CONFIG_SND_AM33XX_SOC_EVM option, but
the aim is to convert all boards to use simple card.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ac521e764d10..b001f7ae67f3 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -324,10 +324,13 @@ CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_EDMA_SOC=m
 CONFIG_SND_AM33XX_SOC_EVM=m
+CONFIG_SND_DAVINCI_SOC_MCASP=m
 CONFIG_SND_OMAP_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
+CONFIG_SND_SIMPLE_CARD=m
+CONFIG_SND_SOC_TLV320AIC3X=m
 CONFIG_HID_GENERIC=m
 CONFIG_USB_HIDDEV=y
 CONFIG_USB_KBD=m
-- 
2.4.5
