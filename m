From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 1 Oct 2014 13:37:31 +0300
Subject: [PATCH 1/4] ARM: dts: keystone: fix io range for usb_phy0
In-Reply-To: <1412159854-21143-1-git-send-email-grygorii.strashko@ti.com>
References: <1412159854-21143-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1412159854-21143-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IO range size is set incorrectly for USB PHY0 deivice
it should be 24 instead of 32. Otherwise, It causes
USB PHY1 probing failure.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 4e53494..d1f03a0 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -177,7 +177,7 @@
 			compatible = "ti,keystone-usbphy";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			reg = <0x2620738 32>;
+			reg = <0x2620738 24>;
 			status = "disabled";
 		};
 
-- 
1.9.1
