From: kraxel@redhat.com (Gerd Hoffmann)
Date: Tue, 21 Feb 2017 10:07:04 +0100
Subject: [PATCH v3 5/7] arm64: set CONFIG_MMC_BCM2835=y in defconfig
In-Reply-To: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
Message-ID: <1487668026-7100-6-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to enable this controller so that we can switch the SD card's
pinmux over to it by default, which will improve storage performance.

Read access (dd with 64k blocks on rpi2):
  CONFIG_MMC_SDHCI_IPROC: 11-12 MB/s
  CONFIG_MMC_BCM2835:     19-20 MB/s

Differences on write access are pretty much in the noise.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 33b744d..75131a6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -391,6 +391,7 @@ CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_K3=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SUNXI=y
+CONFIG_MMC_BCM2835=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
1.8.3.1
