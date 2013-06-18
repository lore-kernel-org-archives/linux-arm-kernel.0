From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Jun 2013 15:37:41 +0200
Subject: [PATCH] arm: mvebu: enable mini-PCIe connectors on Armada 370 RD
Message-ID: <1371562661-7139-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 RD board has two internal mini-PCIe connectors. This
commit adds the necessary Device Tree informations to enable the usage
of those mini-PCIe connectors.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Florian Fainelli <florian@openwrt.org>
---
 arch/arm/boot/dts/armada-370-rd.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 130f839..ec1587b 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -84,6 +84,22 @@
 					gpios = <&gpio0 6 1>;
 				};
 			};
+
+			pcie-controller {
+				status = "okay";
+
+				/* Internal mini-PCIe connector */
+				pcie at 1,0 {
+					/* Port 0, Lane 0 */
+					status = "okay";
+				};
+
+				/* Internal mini-PCIe connector */
+				pcie at 2,0 {
+					/* Port 1, Lane 0 */
+					status = "okay";
+				};
+			};
 		};
 	};
  };
-- 
1.8.1.2
