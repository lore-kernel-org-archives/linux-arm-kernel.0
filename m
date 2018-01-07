From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun,  7 Jan 2018 14:36:52 +0100
Subject: [PATCH] Revert "ARM: dts: bcm283x: Fix DTC warnings about missing
 phy-cells"
Message-ID: <1515332212-23593-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 014d6da6cb2525d7f48fb08c705cb130cc7b5f4a.

The DT clean up could trigger an endless deferred probe of DWC2 USB driver
on the Raspberry Pi 2/3. So revert the change until we fixed the probing
issue.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---

Hi Arnd,
hi Olof,
i hope this has a chance to get into 4.15.

 arch/arm/boot/dts/bcm283x.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index dcde93c..013431e 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -639,6 +639,5 @@
 
 	usbphy: phy {
 		compatible = "usb-nop-xceiv";
-		#phy-cells = <0>;
 	};
 };
-- 
2.7.4
