From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 23:24:33 +0100
Subject: [PATCH 4/5] ARM: mvebu: Add SATA support for OpenBlocks AX3-4
In-Reply-To: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353536675-15010-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables SATA support on the OpenBlocks AX3-4. It has one
internal SATA port, and an external eSATA port.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 13ce6ae..b42652f 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -117,5 +117,9 @@
 				reg = <0x30>;
 			};
 		};
+		sata at d00a0000 {
+			nr-ports = <2>;
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
