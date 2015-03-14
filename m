From: amstan@chromium.org (Alexandru M Stan)
Date: Fri, 13 Mar 2015 17:55:32 -0700
Subject: [PATCH] ARM: dts: rockchip: disable gmac by default in rk3288.dtsi
In-Reply-To: <1426294532-32078-1-git-send-email-amstan@chromium.org>
References: <1426294532-32078-1-git-send-email-amstan@chromium.org>
Message-ID: <1426294532-32078-2-git-send-email-amstan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This block should not be enabled by default or else if the kconfig is set,
it will try to load/probe even if there's no phy connected.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index d771f68..eccc78d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -411,6 +411,7 @@
 			"mac_clk_rx", "mac_clk_tx",
 			"clk_mac_ref", "clk_mac_refout",
 			"aclk_mac", "pclk_mac";
+		status = "disabled";
 	};
 
 	usb_host0_ehci: usb at ff500000 {
-- 
2.2.0.rc0.207.ga3a616c
