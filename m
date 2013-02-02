From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  2 Feb 2013 15:35:49 +0100
Subject: [PATCH v3 4/4] Dove: Thermal: Add DT node and enable in defconfig
In-Reply-To: <1359815749-27705-1-git-send-email-andrew@lunn.ch>
References: <1359815749-27705-1-git-send-email-andrew@lunn.ch>
Message-ID: <1359815749-27705-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree node to instantiate the dove thermal driver.
Enable the driver and the thermal framework in dove_defconfig.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/dove.dtsi     |    5 +++++
 arch/arm/configs/dove_defconfig |    2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 42eac1f..3584a00 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -50,6 +50,11 @@
 			#clock-cells = <1>;
 		};
 
+		thermal: thermal at d001c {
+			compatible = "marvell,dove-thermal";
+			reg = <0xd001c 0x0c>, <0xd005c 0x08>;
+		};
+
 		uart0: serial at 12000 {
 			compatible = "ns16550a";
 			reg = <0x12000 0x100>;
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 0b7ee92..9713b5b 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -80,6 +80,8 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_DOVE_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.7.10.4
