From: william.wu@rock-chips.com (William Wu)
Date: Thu, 17 Aug 2017 16:24:32 +0800
Subject: [PATCH] arm64: dts: rockchip: disable tx ipgap linecheck for rk3399
 dwc3
Message-ID: <1502958272-1384-1-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3399 USB DWC3 controller has a issue that FS/LS devices not
recognized if inserted through USB 3.0 HUB. It's because that
the inter-packet delay between the SSPLIT token to SETUP token
is about 566ns, more then the USB spec requirement.

This patch adds a quirk "snps,dis-tx-ipgap-linecheck-quirk" to
disable the u2mac linestate check to decrease the SSPLIT token
to SETUP token inter-packet delay from 566ns to 466ns.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 27a4616..69cb311 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -412,6 +412,7 @@
 			snps,dis-u2-freeclk-exists-quirk;
 			snps,dis_u2_susphy_quirk;
 			snps,dis-del-phy-power-chg-quirk;
+			snps,dis-tx-ipgap-linecheck-quirk;
 			status = "disabled";
 		};
 	};
@@ -439,6 +440,7 @@
 			snps,dis-u2-freeclk-exists-quirk;
 			snps,dis_u2_susphy_quirk;
 			snps,dis-del-phy-power-chg-quirk;
+			snps,dis-tx-ipgap-linecheck-quirk;
 			status = "disabled";
 		};
 	};
-- 
2.0.0
