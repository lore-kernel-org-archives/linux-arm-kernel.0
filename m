From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 17:18:36 +0100
Subject: [PATCHv6 14/17] arm: mvebu: PCIe Device Tree informations for Armada
 370 Mirabox
In-Reply-To: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1364314719-1049-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Globalscale Mirabox platform uses one PCIe interface for an
available mini-PCIe slot, and the other PCIe interface for an internal
USB 3.0 controller. We add the necessary Device Tree informations to
enable those two interfaces.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-mirabox.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index dd0c57d..5549de6 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -70,5 +70,21 @@
 		usb at d0051000 {
 			status = "okay";
 		};
+
+		pcie-controller {
+			status = "okay";
+
+			/* Internal mini-PCIe connector */
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+
+			/* Connected on the PCB to a USB 3.0 XHCI controller */
+			pcie at 2,0 {
+				/* Port 1, Lane 0 */
+				status = "okay";
+			};
+		};
 	};
 };
-- 
1.7.9.5
