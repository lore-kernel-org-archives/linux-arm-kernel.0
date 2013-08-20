From: fathi.boudra@linaro.org (Fathi Boudra)
Date: Wed, 21 Aug 2013 00:02:42 +0300
Subject: [PATCH 2/3] ARM: vexpress_defconfig: Enable voltage regulator support
In-Reply-To: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
References: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
Message-ID: <1377032563-4502-3-git-send-email-fathi.boudra@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is needed for the MMC controller and allows to use the SD card:

mmc0: host doesn't support card's voltages
mmc0: error -22 whilst initialising SD card

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
---
 arch/arm/configs/vexpress_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index 3f970f1..c2f7ca1 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -77,6 +77,8 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_VEXPRESS=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
1.8.1.2
