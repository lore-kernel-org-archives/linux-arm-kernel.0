From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat,  7 Jan 2017 11:16:51 +0200
Subject: [PATCH v1.1] ARM: multi_v7_defconfig: Enable power sequence for
 Odroid U3
In-Reply-To: <20170107085203.4431-5-krzk@kernel.org>
References: <20170107085203.4431-5-krzk@kernel.org>
Message-ID: <20170107091651.10560-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Odroid U3 needs a power sequence for lan9730, if it was enabled by
bootloader.  Also enable the USB3503 HSCI to USB2.0 driver (device
is present on Odroid U3).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1 (v1 -> v1.1):
1. Enable also usb3503 driver.
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b01a43851294..8cc73e084b25 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -443,6 +443,7 @@ CONFIG_POWER_RESET_RMOBILE=y
 CONFIG_POWER_RESET_ST=y
 CONFIG_POWER_AVS=y
 CONFIG_ROCKCHIP_IODOMAIN=y
+CONFIG_PWRSEQ_GENERIC=y
 CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
@@ -686,6 +687,7 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_HSIC_USB3503=m
 CONFIG_AB8500_USB=y
 CONFIG_KEYSTONE_USB_PHY=y
 CONFIG_OMAP_USB3=y
-- 
2.9.3
