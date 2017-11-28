From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Nov 2017 14:47:34 +0100
Subject: [PATCH v4 10/12] ARM: dts: r8a7793: Remove CMT renesas,channels-mask
In-Reply-To: <1511876856-9495-1-git-send-email-geert+renesas@glider.be>
References: <1511876856-9495-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1511876856-9495-11-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a7793.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 035b5a7639bc7eb7..61dd291d907da2f5 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -257,8 +257,6 @@
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		resets = <&cpg 124>;
 
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -278,8 +276,6 @@
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		resets = <&cpg 329>;
 
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
-- 
2.7.4
