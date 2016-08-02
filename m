From: khilman@baylibre.com (Kevin Hilman)
Date: Tue,  2 Aug 2016 11:36:37 -0700
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: enable DA850 audio as modules
In-Reply-To: <20160802183637.4860-1-khilman@baylibre.com>
References: <20160802183637.4860-1-khilman@baylibre.com>
Message-ID: <20160802183637.4860-2-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Build audio support for DA850-based devices as modules in the default
defconfig.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 67c90373ba1d..91eb0b2f8d61 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -118,6 +118,7 @@ CONFIG_DAVINCI_WATCHDOG=m
 CONFIG_MFD_DM355EVM_MSP=y
 CONFIG_TPS6507X=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
@@ -127,6 +128,9 @@ CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
 CONFIG_SND_SOC=m
+CONFIG_SND_EDMA_SOC=m
+CONFIG_SND_DA850_SOC_EVM=m
+CONFIG_SND_SIMPLE_CARD=m
 CONFIG_HID=m
 CONFIG_HID_A4TECH=m
 CONFIG_HID_APPLE=m
-- 
2.9.0
