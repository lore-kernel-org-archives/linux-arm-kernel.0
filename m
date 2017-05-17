From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed, 17 May 2017 18:16:17 +0800
Subject: [PATCH v2 4/4] arm: dts: rk322x: update tsadc's frequence setting
In-Reply-To: <1495016177-2413-1-git-send-email-frank.wang@rock-chips.com>
References: <1495016177-2413-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1495016177-2413-5-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rocky Hao <rocky.hao@rock-chips.com>

Update freq of tsadc's working clock as 32768 hz, if not set, tsadc
will work at a default frequence.

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 9a9da1f..c054e9e 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -434,6 +434,8 @@
 		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
 		clock-names = "tsadc", "apb_pclk";
+		assigned-clocks = <&cru SCLK_TSADC>;
+		assigned-clock-rates = <32768>;
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
 		pinctrl-names = "init", "default", "sleep";
-- 
2.0.0
