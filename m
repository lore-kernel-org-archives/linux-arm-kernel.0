From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  6 Feb 2013 07:35:25 +0100
Subject: [PATCH v5 2/4] ARM: Kirkwood: Add support thermal sensor for 88F6282
 and 88F6283
In-Reply-To: <1360132527-22860-1-git-send-email-andrew@lunn.ch>
References: <1360132527-22860-1-git-send-email-andrew@lunn.ch>
Message-ID: <1360132527-22860-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Kirkwood 88F6282 and 88F6283 have a thermal sensor.
This patch adds a DT node and enables the driver in the kernel config.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-6282.dtsi |    6 ++++++
 arch/arm/configs/kirkwood_defconfig  |    2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 4ccea21..bd168b6 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -32,6 +32,12 @@
 			};
 		};
 
+		thermal at 10078 {
+			compatible = "marvell,kirkwood-thermal";
+			reg = <0x10078 0x4>;
+			status = "okay";
+		};
+
 		i2c at 11100 {
 			compatible = "marvell,mv64xxx-i2c";
 			reg = <0x11100 0x20>;
diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 93f3794..3d8667f 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -118,6 +118,8 @@ CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_KIRKWOOD_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_HID_DRAGONRISE=y
-- 
1.7.10.4
