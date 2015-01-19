From: b38611@freescale.com (Fugang Duan)
Date: Mon, 19 Jan 2015 17:38:02 +0800
Subject: [PATCH net-next 1/1] ARM: dts: imx6sx: correct i.MX6sx sdb board enet
 phy address
Message-ID: <1421660282-29494-1-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit (3d125f9c91c5) cause i.MX6SX sdb enet cannot work. The cause is
the commit add mdio node with un-correct phy address.

The patch just correct i.MX6sx sdb board enet phy address.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 8c1febd..9db123f 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -167,11 +167,11 @@
 		#size-cells = <0>;
 
 		ethphy1: ethernet-phy at 0 {
-			reg = <0>;
+			reg = <1>;
 		};
 
 		ethphy2: ethernet-phy at 1 {
-			reg = <1>;
+			reg = <2>;
 		};
 	};
 };
-- 
1.7.8
