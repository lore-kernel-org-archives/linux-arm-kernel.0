From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sun, 18 Dec 2016 23:17:57 -0800
Subject: [PATCH v4 3/3] ARM: dts: vf610-zii-dev-rev-b: Remove 'fixed-link'
 from DSA ports
In-Reply-To: <1482131877-6097-1-git-send-email-andrew.smirnov@gmail.com>
References: <1482131877-6097-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1482131877-6097-3-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove 'fixed-link' nodes from DSA ports since they are not needed (they
are not limiting link's speed and the ports will be configured to their
maximux speed as a default)

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since v3:

	- None

 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index c0fc3f2..646c90c 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -97,10 +97,6 @@
 						phy-mode = "rgmii-txid";
 						link = <&switch1port6
 							&switch2port9>;
-						fixed-link {
-							speed = <1000>;
-							full-duplex;
-						};
 					};
 
 					port at 6 {
@@ -165,10 +161,6 @@
 						label = "dsa";
 						phy-mode = "rgmii-txid";
 						link = <&switch0port5>;
-						fixed-link {
-							speed = <1000>;
-							full-duplex;
-						};
 					};
 				};
 				mdio {
-- 
2.5.5
