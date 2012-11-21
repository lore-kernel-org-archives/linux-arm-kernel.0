From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 23:24:31 +0100
Subject: [PATCH 2/5] ARM: mvebu: Add support for I2C on OpenBlocks AX3-4
In-Reply-To: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353536675-15010-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

The OpenBlocks AX3-4 board, based on the Armada XP SoC, has an I2C
bus. This patch enables this bus and sets the clock frequency of the
bus.

[Thomas Petazzoni: updated with other changes on OpenBlocks, rephrased
commit log.]
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 638fb68..cb7f0d9 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -104,5 +104,13 @@
 			phy = <&phy3>;
 			phy-mode = "sgmii";
 		};
+		i2c at d0011000 {
+			status = "okay";
+			clock-frequency = <400000>;
+		};
+		i2c at d0011100 {
+			status = "okay";
+			clock-frequency = <400000>;
+		};
 	};
 };
-- 
1.7.9.5
