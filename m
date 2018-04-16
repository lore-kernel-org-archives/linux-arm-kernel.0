From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Mon, 16 Apr 2018 10:34:58 +0100
Subject: [RFC 2/3] ARM: dts: Renesas RZ/N1D SMP enable method
In-Reply-To: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <1523871304-48517-4-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a special enable method for the second CA7 of the Renesas RZ/N1D
(R9A06G032), as well as the default value for the "cpu-release-addr"
property.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 7d84b38..50f3043d 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -33,6 +33,8 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <1>;
+			enable-method = "renesas,r9a06g032-smp";
+			cpu-release-addr = <0x4000c204>;
 		};
 	};
 
-- 
2.7.4
