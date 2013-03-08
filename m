From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  8 Mar 2013 16:19:15 +0100
Subject: [PATCH v4 13/18] arm: mvebu: PCIe Device Tree informations for
 OpenBlocks AX3-4
In-Reply-To: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362755960-30791-14-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PlatHome OpenBlocks AX3-4 has an internal mini-PCIe slot that can
be used to plug mini-PCIe devices. We therefore enable the PCIe
interface that corresponds to this slot.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 3818a82..5f87bc8 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -139,5 +139,13 @@
 		usb at d0051000 {
 			status = "okay";
 		};
+
+		pcie-controller {
+			status = "okay";
+			/* Internal mini-PCIe connector */
+			pcie at 0,0 {
+				status = "okay";
+			};
+		};
 	};
 };
-- 
1.7.9.5
