From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  8 Mar 2017 10:19:09 +0100
Subject: [PATCH v4 5/7] arm64: set CONFIG_MMC_BCM2835=y in defconfig
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Message-ID: <1488964751-22763-10-git-send-email-kraxel@redhat.com>
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
index 7c48028..519a55c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -398,6 +398,7 @@ CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_K3=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SUNXI=y
+CONFIG_MMC_BCM2835=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
1.8.3.1
