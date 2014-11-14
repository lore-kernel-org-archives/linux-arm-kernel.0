From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 14 Nov 2014 16:57:31 +0100
Subject: [PATCH v3 4/5] ARM: mvebu: adjust ethernet aliases according to
 U-Boot requirements for A38x
In-Reply-To: <1415980652-7429-1-git-send-email-mw@semihalf.com>
References: <1415980652-7429-1-git-send-email-mw@semihalf.com>
Message-ID: <1415980652-7429-5-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to update MAC address entries in the ethernet nodes in Device Tree
both mainline U-Boot and Barebox bootloaders accept the same format of aliases,
which is 'ethernetX', where X stands for an interface number.
Other platforms in the mainline Linux, that comprise ethernet references in
'/aliases' node (like various flavours of imx or sunXi), follow the naming
scheme described above.

This commit ajusts ethernet aliases of Marvell Armada 38x SoC to be properly
recognized by bootloaders' MAC address fixup routines.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-38x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 242d0ec..74391da 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -25,9 +25,9 @@
 	aliases {
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
-		eth0 = &eth0;
-		eth1 = &eth1;
-		eth2 = &eth2;
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
+		ethernet2 = &eth2;
 	};
 
 	soc {
-- 
1.8.3.1
