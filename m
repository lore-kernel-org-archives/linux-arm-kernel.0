From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Mon, 17 Jul 2017 22:16:56 +0800
Subject: [PATCH v2 2/5] arm64: dts: rockchip: add pd_edp node for rk3399
In-Reply-To: <1500301019-9960-1-git-send-email-jacob-chen@iotwrt.com>
References: <1500301019-9960-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1500301019-9960-3-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

1. add pd node for RK3399 Soc
2. create power domain tree
3. add qos node for domain

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 978057d..e0285f8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -956,6 +956,10 @@
 			};
 
 			/* These power domains are grouped by VD_LOGIC */
+			pd_edp at RK3399_PD_EDP {
+				reg = <RK3399_PD_EDP>;
+				clocks = <&cru PCLK_EDP_CTRL>;
+			};
 			pd_emmc at RK3399_PD_EMMC {
 				reg = <RK3399_PD_EMMC>;
 				clocks = <&cru ACLK_EMMC>;
-- 
2.7.4
