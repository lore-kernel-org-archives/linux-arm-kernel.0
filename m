From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 18 Jan 2017 14:08:25 +0800
Subject: [PATCH 4/6] arm64: dts: mt8173: add reference clock for usb
In-Reply-To: <1484719707-12107-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1484719707-12107-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1484719707-12107-4-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add 26M reference clock for ssusb and xhci nodes

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 07fd2eb..e2862b6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -729,9 +729,11 @@
 			       <&u2port1 PHY_TYPE_USB2>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
 			clocks = <&topckgen CLK_TOP_USB30_SEL>,
+				 <&clk26m>,
 				 <&pericfg CLK_PERI_USB0>,
 				 <&pericfg CLK_PERI_USB1>;
 			clock-names = "sys_ck",
+				      "ref_ck",
 				      "wakeup_deb_p0",
 				      "wakeup_deb_p1";
 			mediatek,syscon-wakeup = <&pericfg>;
@@ -746,8 +748,8 @@
 				reg-names = "mac";
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
 				power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
-				clocks = <&topckgen CLK_TOP_USB30_SEL>;
-				clock-names = "sys_ck";
+				clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
+				clock-names = "sys_ck", "ref_ck";
 				status = "disabled";
 			};
 		};
-- 
1.7.9.5
