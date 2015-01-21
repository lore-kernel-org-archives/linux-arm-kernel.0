From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Jan 2015 10:32:06 +0100
Subject: [PATCH 7/7] ARM: mvebu: Add Device Tree description of SDHCI for
 Armada 388 RD
In-Reply-To: <1421832726-21656-1-git-send-email-gregory.clement@free-electrons.com>
References: <1421832726-21656-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1421832726-21656-8-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Device Tree description of SDHCI on Armada 388 RD board was
missing. This commit adds the node for it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-388-rd.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index c98a8f8d01a9..7dfede145ea3 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -51,6 +51,16 @@
 				clock-frequency = <100000>;
 			};
 
+			sdhci at d8000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&sdhci_pins>;
+				broken-cd;
+				no-1-8-v;
+				wp-inverted;
+				bus-width = <8>;
+				status = "okay";
+			};
+
 			serial at 12000 {
 				status = "okay";
 			};
-- 
1.9.1
