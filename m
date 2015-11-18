From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed, 18 Nov 2015 18:00:35 +0800
Subject: [PATCH v3 4/5] ARM: dts: rockchip: add reboot node
In-Reply-To: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1447840835-19903-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reboot notifier driver DT node for rk3xxx,rk3288 platform

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v3:
 - add DT node

Changes in v2: None

 arch/arm/boot/dts/rk3288.dtsi | 6 ++++++
 arch/arm/boot/dts/rk3xxx.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 906e938..975b8c9 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -169,6 +169,12 @@
 		};
 	};
 
+	reboot {
+		compatible = "rockchip,reboot";
+		rockchip,regmap = <&pmu>;
+		offset = <0x94>;
+	};
+
 	reserved-memory {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 4497d28..7b14d7a 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -103,6 +103,12 @@
 		};
 	};
 
+	reboot {
+		compatible = "rockchip,reboot";
+		rockchip,regmap = <&pmu>;
+		offset = <0x40>;
+	};
+
 	xin24m: oscillator {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
1.9.1
