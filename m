From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 19 Feb 2014 10:15:05 +0100
Subject: [PATCH v2 2/2] ARM: DTS: OMAP4: Use l3_ick for the gpmc node
In-Reply-To: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch>
References: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1392801305-1698-3-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPMC clock is derived from l3_ick. The simplest solution is
to reference directly l3_ick to provide the GPMC fck in order to
get correct timings. The real management of the clock is left to
hwmod.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..69409f7 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -275,6 +275,8 @@
 			gpmc,num-waitpins = <4>;
 			ti,hwmods = "gpmc";
 			ti,no-idle-on-init;
+			clocks = <&l3_div_ck>;
+			clock-names = "fck";
 		};
 
 		uart1: serial at 4806a000 {
-- 
1.8.1.2
