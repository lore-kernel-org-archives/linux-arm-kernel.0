From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat,  3 Dec 2016 14:30:19 -0800
Subject: [PATCH v2 3/3] ARM: dts: vf610-zii-dev-rev-b: Remove 'fixed-link'
 from DSA ports
In-Reply-To: <1480804219-12596-1-git-send-email-andrew.smirnov@gmail.com>
References: <1480804219-12596-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1480804219-12596-3-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove 'fixed-link' nodes from DSA ports since they are not needed (they
are not limiting link's speed and the ports will be configured to their
maximux speed as a default)

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since v1:
	- Patch was not present in v1

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
