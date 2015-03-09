From: rjui@broadcom.com (Ray Jui)
Date: Mon, 9 Mar 2015 13:44:58 -0700
Subject: [PATCH v6 4/8] ARM: dts: enable IOMUX for Broadcom Cygnus
In-Reply-To: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
References: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
Message-ID: <1425933902-20652-5-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the IOMUX support for Broadcom Cygnus SoC

Signed-off-by: Ray Jui <rjui@broadcom.com>
Tested-by: Dmitry Torokhov <dtor@chromium.org>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index ff5fb6a..1cbae6a 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -54,6 +54,12 @@
 
 	/include/ "bcm-cygnus-clock.dtsi"
 
+	pinctrl: pinctrl at 0x0301d0c8 {
+		compatible = "brcm,cygnus-pinmux";
+		reg = <0x0301d0c8 0x30>,
+		      <0x0301d24c 0x2c>;
+	};
+
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.9.5
