From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 12 Oct 2013 17:35:13 +0800
Subject: [PATCH 11/11] ARM: dts: imx6qdl-sabresd: Enable runtime pm for usbotg
 and usb host 1
In-Reply-To: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
References: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1381570513-24927-12-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable runtime power management support for usbotg and usb host 1.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 64e454b..c8c57db 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -215,6 +215,7 @@
 
 &usbh1 {
 	vbus-supply = <&reg_usb_h1_vbus>;
+	supports_runtime_pm;
 	status = "okay";
 };
 
@@ -223,6 +224,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg_2>;
 	disable-over-current;
+	supports_runtime_pm;
 	status = "okay";
 };
 
-- 
1.7.1
