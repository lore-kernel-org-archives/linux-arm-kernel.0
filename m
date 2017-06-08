From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  8 Jun 2017 18:10:38 +0200
Subject: [PATCH 27/35] ARM: s3c2410_defconfig: Bring back lost (but wanted)
 options
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
Message-ID: <20170608161049.12421-27-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config was not updated for some time so it needs updates to get the
same options as wanted initially:
 - IP_NF_TARGET_LOG was replaced by NETFILTER_XT_TARGET_LOG;
 - NF_NAT was replaced by IP_NF_NAT;
 - SERIAL_DEV_BUS is now needed for BT_HCIUART_LL;
 - TPS65010 is now needed for MACH_OSIRIS_DVS;
 - DMADEVICES and S3C24XX_DMAC are now needed for MMC_S3C;

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/s3c2410_defconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index dc3469d9da26..aacc788f5d55 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -100,6 +100,7 @@ CONFIG_NF_CT_NETLINK=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
 CONFIG_NETFILTER_XT_TARGET_LED=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NETFILTER_XT_TARGET_NFLOG=m
 CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
@@ -143,8 +144,7 @@ CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_NF_NAT=m
+CONFIG_IP_NF_NAT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
@@ -272,6 +272,7 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=m
 CONFIG_PRINTER=y
 CONFIG_PPDEV=y
 CONFIG_HW_RANDOM=y
@@ -289,6 +290,7 @@ CONFIG_SENSORS_LM85=m
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MFD_SM501=y
+CONFIG_TPS65010=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
@@ -372,6 +374,8 @@ CONFIG_LEDS_TRIGGER_GPIO=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S3C=y
+CONFIG_DMADEVICES=y
+CONFIG_S3C24XX_DMAC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.9.3
