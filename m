From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Oct 2014 10:53:46 +0200
Subject: [PATCH 8/9] ARM: berlin: Add phy-connection-type to BG2Q PHY
In-Reply-To: <1413881627-21639-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413881627-21639-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1413881627-21639-9-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine T?nart <antoine.tenart@free-electrons.com>

Internal FastEthernet PHY on BG2Q is connected via MII, add a
corresponding phy-connection-type property.

Tested-by: Antoine T?nart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: netdev at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/berlin2q.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 891d56b03922..6dbc520bddc1 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -127,6 +127,7 @@
 			status = "disabled";
 
 			ethphy0: ethernet-phy at 0 {
+				phy-connection-type = "mii";
 				reg = <0>;
 			};
 		};
-- 
2.1.1
