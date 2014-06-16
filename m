From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 16 Jun 2014 16:57:03 +0200
Subject: [PATCH v3 4/4] ARM: tegra: jetson-tk1: Add XUSB pad controller
In-Reply-To: <1402930623-28886-1-git-send-email-thierry.reding@gmail.com>
References: <1402930623-28886-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1402930623-28886-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Assign lanes to the XUSB pads as used on the Jetson TK1.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index e31fb61a81d3..38d30877057c 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1619,6 +1619,32 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	padctl at 0,7009f000 {
+		pinctrl-0 = <&padctl_default>;
+		pinctrl-names = "default";
+
+		padctl_default: pinmux {
+			usb3 {
+				nvidia,lanes = "pcie-0", "pcie-1";
+				nvidia,function = "usb3";
+				nvidia,iddq = <0>;
+			};
+
+			pcie {
+				nvidia,lanes = "pcie-2", "pcie-3",
+					       "pcie-4";
+				nvidia,function = "pcie";
+				nvidia,iddq = <0>;
+			};
+
+			sata {
+				nvidia,lanes = "sata-0";
+				nvidia,function = "sata";
+				nvidia,iddq = <0>;
+			};
+		};
+	};
+
 	/* SD card */
 	sdhci at 0,700b0400 {
 		status = "okay";
-- 
1.9.2
