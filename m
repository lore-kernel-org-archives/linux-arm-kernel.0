From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 19 Feb 2015 23:36:02 +0100
Subject: [PATCH v7 0/5] Patches to add support for Rockchip usb PHYs.
In-Reply-To: <1418396413-27937-1-git-send-email-lyz@rock-chips.com>
References: <1418396413-27937-1-git-send-email-lyz@rock-chips.com>
Message-ID: <83789848.BNM9GbusAN@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 12. Dezember 2014, 23:00:08 schrieb Yunzhi Li:
> Patches to add support for Rockchip usb phys.Add a new Rockchip
> usb phy driver and modify dwc2 controller driver to make dwc2
> platform devices support a generic PHY framework driver. This
> patch set has been tested on my rk3288-evb and power off the usb
> phys would reduce about 60mW power budget in total during sustem
> suspend.

it seems I missed a mail stating that the phy driver was applied and just
found it in the main tree during the merge window.

I've therefore applied the two dts patches for 3.21 and put the following
on top, so that the firefly board also gets phy support


Heiko

---------- 8< --------------
From: Heiko Stuebner <heiko@sntech.de>
Date: Thu, 19 Feb 2015 22:46:45 +0100
Subject: [PATCH] ARM: dts: rockchip: enable usbphy on rk3288-firefly

Enable the usb phys on the firefly board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index e6f873a..b9dda41 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -459,6 +459,10 @@
 	status = "okay";
 };
 
+&usbphy {
+	status = "okay";
+};
+
 &usb_host1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usbhub_rst>;
-- 
2.1.4
