From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 30 Aug 2018 19:15:36 +0200
Subject: [PATCH 3/6] ARM: dts: vfxxx: Add node for CRC hardware block
In-Reply-To: <20180830171539.20008-1-krzk@kernel.org>
References: <20180830171539.20008-1-krzk@kernel.org>
Message-ID: <20180830171539.20008-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for HW CRC16/CRC32 accelerator present on VF500 and VF610 SoCs.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/vfxxx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index d392794d9c13..d6d0eca02939 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -276,6 +276,13 @@
 				status = "disabled";
 			};
 
+			crc: crc at 40033000 {
+				compatible = "fsl,vf610-crc";
+				reg = <0x40033000 0x10>;
+				clocks = <&clks VF610_CLK_CRC>;
+				clock-names = "crc";
+			};
+
 			pit: pit at 40037000 {
 				compatible = "fsl,vf610-pit";
 				reg = <0x40037000 0x1000>;
-- 
2.14.1
