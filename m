From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Wed, 7 Feb 2018 02:53:09 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable serial console on RPi 3
Message-ID: <20180207005309.14365-1-tuomas@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi 3 uses the 8250-based auxilary UART of the BCM2837 SoC
as the primary serial console of the board, so enable it in the
multiplatform defconfig.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index da7387689b88..f77bd01c7927 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -312,6 +312,9 @@ CONFIG_INPUT_ADXL34X=m
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_BCM2835AUX=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_8250_MT6577=y
-- 
2.16.1
