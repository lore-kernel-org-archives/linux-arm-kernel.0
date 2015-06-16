From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 16 Jun 2015 15:27:45 +0800
Subject: [PATCH v2 3/3] ARM: dts: Add RK3288 efuse node
In-Reply-To: <1434439665-27781-1-git-send-email-wxt@rock-chips.com>
References: <1434439665-27781-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1434439665-27781-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the efuse node on RK3288, we can get some information
when enable the efuse driver.
e.g.: the CPU version, leakage.....

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- Add the dts node on RK3288.

 arch/arm/boot/dts/rk3288.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 165968d..423355e 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -691,6 +691,11 @@
 		};
 	};
 
+	efuse: efuse at ffb40000 {
+		compatible = "rockchip,rk3066-efuse";
+		reg = <0xffb40000 0x10000>;
+	};
+
 	gic: interrupt-controller at ffc01000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
1.9.1
