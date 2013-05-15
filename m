From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 15 May 2013 15:36:58 +0200
Subject: [PATCHv4 5/9] arm: kirkwood: convert MPL CEC4 to use DT for the PCIe
 interface
In-Reply-To: <1368625022-25243-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368625022-25243-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1368625022-25243-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the PCIe mvebu driver is usable on Kirkwood, use it instead
of the legacy PCIe code, since it allows to describe the PCIe
interfaces in the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-mplcec4.dts |    8 ++++++++
 arch/arm/mach-kirkwood/board-mplcec4.c |    1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 7588241..90501cf 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -139,6 +139,14 @@
 			cd-gpios = <&gpio1 15 0>;
 			/* No WP GPIO */
 		};
+
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/mach-kirkwood/board-mplcec4.c b/arch/arm/mach-kirkwood/board-mplcec4.c
index 7d6dc66..938712e 100644
--- a/arch/arm/mach-kirkwood/board-mplcec4.c
+++ b/arch/arm/mach-kirkwood/board-mplcec4.c
@@ -29,7 +29,6 @@ void __init mplcec4_init(void)
 	 */
 	kirkwood_ge00_init(&mplcec4_ge00_data);
 	kirkwood_ge01_init(&mplcec4_ge01_data);
-	kirkwood_pcie_init(KW_PCIE0);
 }
 
 
-- 
1.7.9.5
