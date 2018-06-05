From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Tue,  5 Jun 2018 12:28:48 +0100
Subject: [PATCH v4 3/3] ARM: dts: Renesas R9A06G032 SMP enable method
In-Reply-To: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <1528198148-23308-4-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a special enable method for the second CA7 of the R9A06G032
as well as the default value for the "cpu-release-addr" property.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 40827bb..9d7e74a 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -1,3 +1,4 @@
+
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Base Device Tree Source for the Renesas RZ/N1D (R9A06G032)
@@ -30,6 +31,8 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clocks = <&sysctrl R9A06G032_CLK_A7MP>;
+			enable-method = "renesas,r9a06g032-smp";
+			cpu-release-addr = <0x4000c204>;
 		};
 	};
 
-- 
2.7.4
