From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  6 Jan 2013 11:10:40 +0100
Subject: [PATCH 07/11] arm: mvebu: Armada XP MV78230 has two cores, not one
In-Reply-To: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
References: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
Message-ID: <1357467044-4914-8-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Contrary to our understanding at the time armada-xp-mv78230.dtsi was
written, the MV78230 variant of the Armada XP SoC has two cores and
not one. This patch updates the .dtsi file to take into account this
reality.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index c45c7b4..8f90fac 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -34,6 +34,13 @@
 		reg = <0>;
 		clocks = <&cpuclk 0>;
 	    };
+
+	    cpu at 1 {
+		device_type = "cpu";
+		compatible = "marvell,sheeva-v7";
+		reg = <1>;
+		clocks = <&cpuclk 1>;
+	    };
 	}
 
 	soc {
-- 
1.7.10.4
