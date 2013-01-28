From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 28 Jan 2013 19:56:32 +0100
Subject: [PATCH v2 23/27] arm: mvebu: PCIe Device Tree informations for
 OpenBlocks AX3-4
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1359399397-29729-24-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PlatHome OpenBlocks AX3-4 has an internal mini-PCIe slot that can
be used to plug mini-PCIe devices. We therefore enable the PCIe
interface that corresponds to this slot.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index b42652f..67fcaaa 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -121,5 +121,12 @@
 			nr-ports = <2>;
 			status = "okay";
 		};
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
