From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 23:24:32 +0100
Subject: [PATCH 3/5] ARM: mvebu: Add support for the RTC in OpenBlocks AX3-4
In-Reply-To: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353536675-15010-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

The OpenBlocks AX3-4 has a Seiko Instruments S-35390A as the RTC
controller.  This patch enables this RTC device in the OpenBlocks
AX3-4 Device Tree.

[Thomas Petazzoni: updated with other OpenBlocks changes, rephrased
commit log.]
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index cb7f0d9..13ce6ae 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -111,6 +111,11 @@
 		i2c at d0011100 {
 			status = "okay";
 			clock-frequency = <400000>;
+
+			s35390a: s35390a at 30 {
+				compatible = "s35390a";
+				reg = <0x30>;
+			};
 		};
 	};
 };
-- 
1.7.9.5
