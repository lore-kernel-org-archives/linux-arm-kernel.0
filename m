From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 26 Jul 2016 20:13:14 +0800
Subject: [PATCH v2 3/4] arm64: dts: rockchip: add reset saradc node for rk3368
 SoCs
In-Reply-To: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
References: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1469535195-5227-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SARADC controller needs to be reset before programming it, otherwise
it will not function properly.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index d02a9003..4f44d11 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -270,6 +270,8 @@
 		#io-channel-cells = <1>;
 		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
 		clock-names = "saradc", "apb_pclk";
+		resets = <&cru SRST_SARADC>;
+		reset-names = "saradc-apb";
 		status = "disabled";
 	};
 
-- 
1.9.1
