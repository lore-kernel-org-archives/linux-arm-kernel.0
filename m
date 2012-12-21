From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Dec 2012 15:49:04 +0100
Subject: [PATCH v2 05/20] arm: mvebu: add DT information for the SDIO
 interface of Armada 370/XP
In-Reply-To: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1356101359-6054-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mvsdio MMC driver has a Device Tree binding, we add the
Device Tree informations to describe the SDIO interface available in
the Armada 370/XP SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index cf6c48a..41a5b11 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -129,6 +129,14 @@
 			clocks = <&coreclk 0>;
 			status = "disabled";
 		};
+
+		mvsdio at d00d4000 {
+			compatible = "marvell,orion-sdio";
+			reg = <0xd00d4000 0x200>;
+			interrupts = <54>;
+			clocks = <&gateclk 17>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.7.9.5
