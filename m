From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Nov 2017 14:47:30 +0100
Subject: [PATCH v4 06/12] ARM: dts: r8a73a4: Remove CMT renesas,channels-mask
In-Reply-To: <1511876856-9495-1-git-send-email-geert+renesas@glider.be>
References: <1511876856-9495-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1511876856-9495-7-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a73a4.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 805b0fd70f53820d..8e48090e4fdc1412 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -138,9 +138,6 @@
 		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;
-
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
-- 
2.7.4
