From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue,  1 Sep 2015 17:57:54 +0800
Subject: [PATCH v3 6/9] ARM: dts: Add arm,
 pl330-broken-no-flushp quirk for rk3288 platform
In-Reply-To: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1441101474-1590-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Addy Ke <addy.ke@rock-chips.com>

Pl330 integrated in rk3288 platform doesn't support
DMAFLUSHP function. So we add arm,pl330-broken-no-flushp quirk
for it. Also we add rockchip,i2s-broken-burst-len and
rockchip,spi-broken-burst-len to fix this problem.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Olof Johansson <olof@lixom.net>
cc: Sonny Rao <sonnyrao@chromium.org>

Reviewed-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v3:
- add Reviewed-by: Sonny Rao <sonnyrao@chromium.org>

Changes in v2:
- amend the author
- add Reviewed-by: Doug Anderson <dianders@chromium.org>
- amend Olof's mail address

Changes in v1:
- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
  by Krzysztof.
- remove Sunny's tag

 arch/arm/boot/dts/rk3288.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 22316d0..2654167 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -144,6 +144,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMAC2>;
 			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
 		};
 
 		dmac_bus_ns: dma-controller at ff600000 {
@@ -155,6 +156,7 @@
 			clocks = <&cru ACLK_DMAC1>;
 			clock-names = "apb_pclk";
 			status = "disabled";
+			arm,pl330-broken-no-flushp;
 		};
 
 		dmac_bus_s: dma-controller at ffb20000 {
@@ -165,6 +167,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMAC1>;
 			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
 		};
 	};
 
@@ -264,6 +267,7 @@
 		reg = <0xff110000 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		rockchip,spi-broken-burst-len;
 		status = "disabled";
 	};
 
@@ -279,6 +283,7 @@
 		reg = <0xff120000 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		rockchip,spi-broken-burst-len;
 		status = "disabled";
 	};
 
@@ -294,6 +299,7 @@
 		reg = <0xff130000 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		rockchip,spi-broken-burst-len;
 		status = "disabled";
 	};
 
@@ -642,6 +648,7 @@
 		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_bus>;
+		rockchip,i2s-broken-burst-len;
 		status = "disabled";
 	};
 
-- 
2.3.7
