From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  7 Dec 2012 23:04:37 +0100
Subject: [RFC v1 14/16] arm: mvebu: PCIe Device Tree informations for Armada
 370 Mirabox
In-Reply-To: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1354917879-32073-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Globalscale Mirabox platform uses one PCIe interface for an
available mini-PCIe slot, and the other PCIe interface for an internal
USB 3.0 controller. We add the necessary Device Tree informations to
enable those two interfaces.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-mirabox.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 3b40713..6de4b74 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -52,5 +52,19 @@
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
+
+		pcie-controller {
+			status = "okay";
+
+			/* Internal mini-PCIe connector */
+			pcie0 at 0xd0040000 {
+				status = "okay";
+			};
+
+			/* Connected on the PCB to a USB 3.0 XHCI controller */
+			pcie1 at 0xd0080000 {
+				status = "okay";
+			};
+		};
 	};
 };
-- 
1.7.9.5
