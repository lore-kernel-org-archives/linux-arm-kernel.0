From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  8 Jun 2017 18:10:36 +0200
Subject: [PATCH 25/35] ARM: mini2440_defconfig: Bring back lost (but wanted)
 options
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
Message-ID: <20170608161049.12421-25-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config was not updated for some time so it needs updates to get the
same options as wanted initially:
 - SERIAL_DEV_BUS is now needed for BT_HCIUART_LL;
 - USB_GADGET_S3C2410 was replaced by USB_S3C2410;
 - S3C24XX_DMAC is now needed for MMC_S3C;

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/mini2440_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index e621032ab1f0..45ce98d5392d 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -145,6 +145,7 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_LEGACY_PTY_COUNT=128
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=m
 CONFIG_IPMI_HANDLER=m
 CONFIG_IPMI_DEVICE_INTERFACE=m
 CONFIG_IPMI_SI=m
@@ -225,7 +226,7 @@ CONFIG_USB_SERIAL_CP210X=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_SPCP8X5=m
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_S3C2410=y
+CONFIG_USB_S3C2410=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
@@ -248,6 +249,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_S3C=y
 CONFIG_DMADEVICES=y
+CONFIG_S3C24XX_DMAC=y
 CONFIG_EXT2_FS=m
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.9.3
