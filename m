From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Dec 2012 11:42:01 +0100
Subject: [PATCH 1/2] arm: mvebu: add RTC support for Armada 370 and Armada XP
In-Reply-To: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
References: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1355136122-30729-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 and Armada XP Socs have the same controller that the
one used in the orion platforms. This patch enables the selection of
rtc-mv with mvebu platform, and updates the device tree for these
SoCs.
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    6 ++++++
 drivers/rtc/Kconfig                  |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index cf6c48a..86dccfa 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -129,6 +129,12 @@
 			clocks = <&coreclk 0>;
 			status = "disabled";
 		};
+
+		rtc at 10300 {
+			compatible = "marvell,orion-rtc";
+			reg = <0xd0010300 0x20>;
+			interrupts = <50>;
+		};
 	};
 };
 
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 19c03ab..9356f75 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -994,7 +994,7 @@ config RTC_DRV_TX4939
 
 config RTC_DRV_MV
 	tristate "Marvell SoC RTC"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE
+	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU
 	help
 	  If you say yes here you will get support for the in-chip RTC
 	  that can be found in some of Marvell's SoC devices, such as
-- 
1.7.9.5
