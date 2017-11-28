From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Nov 2017 14:47:36 +0100
Subject: [PATCH v4 12/12] ARM: dts: sh73a0: Remove CMT renesas,channels-mask
In-Reply-To: <1511876856-9495-1-git-send-email-geert+renesas@glider.be>
References: <1511876856-9495-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1511876856-9495-13-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the DTS to remove the now deprecated "renesas,channels-mask"
property.

The channel information is now kept in the device driver and can easily
be determined based on the compat string.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Rebased against renesas-devel-20171127-v4.15-rc1,

v3:
  - Take over from Magnus,
  - Split in per-SoC patches,

v2:
  - Rebased on top of power-domain changes,
  - Added Acked-by and Tested-by from Geert.
---
 arch/arm/boot/dts/sh73a0.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 88d7e5631d340740..914a7c2a584f9083 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -100,9 +100,6 @@
 		clocks = <&mstp3_clks SH73A0_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
-
-		renesas,channels-mask = <0x3f>;
-
 		status = "disabled";
 	};
 
-- 
2.7.4
