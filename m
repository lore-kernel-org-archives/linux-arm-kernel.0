From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 29 Oct 2014 16:25:59 +0800
Subject: [PATCH v4 04/10] ARM: dts: hix5hd2: add sata node
In-Reply-To: <1414571165-23736-1-git-send-email-zhangfei.gao@linaro.org>
References: <1414571165-23736-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1414571165-23736-5-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 arch/arm/boot/dts/hisi-x5hd2-dkb.dts |    5 +++++
 arch/arm/boot/dts/hisi-x5hd2.dtsi    |   20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
index 0da3f3b..721b092 100644
--- a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
+++ b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
@@ -79,3 +79,8 @@
 		reg = <1>;
 	};
 };
+
+&ahci {
+	phys = <&sata_phy>;
+	phy-names = "sata-phy";
+};
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 4f9e8a3..d5b3a8f 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -215,5 +215,25 @@
 			interrupts = <0 67 4>;
 			clocks = <&clock HIX5HD2_USB_CLK>;
 		};
+
+		peripheral_ctrl: syscon at a20000 {
+			compatible = "syscon";
+			reg = <0xa20000 0x1000>;
+		};
+
+		sata_phy: phy at 1900000 {
+			compatible = "hisilicon,hix5hd2-sata-phy";
+			reg = <0x1900000 0x10000>;
+			#phy-cells = <0>;
+			hisilicon,peripheral-syscon = <&peripheral_ctrl>;
+			hisilicon,power-reg = <0x8 10>;
+		};
+
+		ahci: sata at 1900000 {
+			compatible = "hisilicon,hisi-ahci";
+			reg = <0x1900000 0x10000>;
+			interrupts = <0 70 4>;
+			clocks = <&clock HIX5HD2_SATA_CLK>;
+		};
 	};
 };
-- 
1.7.9.5
