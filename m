From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sat,  8 Dec 2012 08:15:51 +0900
Subject: [PATCH 2/2] ARM: Kirkwood: Add support thermal sensor for 88F6282 and
 88F6283
In-Reply-To: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <1354922151-3250-2-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88F6282 and 88F6283 has thermal sensor.
This patch enables DT and kernel config.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/kirkwood-6282.dtsi |    6 ++++++
 arch/arm/configs/kirkwood_defconfig  |    2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 9ae2004..4d9cd74 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -41,5 +41,11 @@
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
+
+		thermal at 10078 {
+			compatible = "marvel,thermal-kirkwood";
+			reg = <0x10078 0x4>;
+			status = "okay";
+		};
 	};
 };
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
