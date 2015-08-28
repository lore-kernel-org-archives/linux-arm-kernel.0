From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 14:42:34 +0200
Subject: [PATCH 7/9] arm: tegra: apalis_t30: set otg dr_mode for eval board
In-Reply-To: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440765756-1382-8-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has currently no functional effect as neither USB device nor OTG
is currently supported on any Tegras in mainline as of yet. However
once we use the same device tree on U-Boot this will actually make it
work properly there.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 5a49f03..37437c6 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -153,6 +153,7 @@
 
 	usb-phy at 7d000000 {
 		status = "okay";
+		dr_mode = "otg";
 		vbus-supply = <&usbo1_vbus_reg>;
 	};
 
-- 
2.4.3
