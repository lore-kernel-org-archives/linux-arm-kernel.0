From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 12 Dec 2017 09:29:51 +0000
Subject: [PATCH 2/2] ARM: dts: vf610-zii-dev: use XAUI for DSA link ports
Message-ID: <E1eOgsp-0001Ab-9x@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use XAUI rather than XGMII for DSA link ports, as this is the interface
mode that the switches actually use. XAUI is the 4 lane bus with clock
per direction, whereas XGMII is a 32 bit bus with clock.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
This must be applied along with patch 1 to avoid breakage.

 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index 1b102c7f7928..4a972fceb3b5 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -128,7 +128,7 @@
 					switch0port10: port at 10 {
 						reg = <10>;
 						label = "dsa";
-						phy-mode = "xgmii";
+						phy-mode = "xaui";
 						link = <&switch1port10>;
 					};
 				};
@@ -233,7 +233,7 @@
 					switch1port10: port at 10 {
 						reg = <10>;
 						label = "dsa";
-						phy-mode = "xgmii";
+						phy-mode = "xaui";
 						link = <&switch0port10>;
 					};
 				};
-- 
2.7.4
