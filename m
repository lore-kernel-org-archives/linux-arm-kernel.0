From: manu@freebsd.org (Emmanuel Vadot)
Date: Mon, 23 Jul 2018 12:42:53 +0200
Subject: [PATCH 2/4] ARM: dts: sunxi: h3/h5: Add SID node
In-Reply-To: <20180723104255.94244-1-manu@freebsd.org>
References: <20180723104255.94244-1-manu@freebsd.org>
Message-ID: <20180723104255.94244-2-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both H3 and H5 and a SID controller at the same address.
They are know to be different, the H5 one is the same as the A64 so add
a node in the common dtsi and we will override the compatible string in
the SoC dts.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index c3bff1105e5d..2b3c629644a0 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -644,6 +644,10 @@
 			status = "disabled";
 		};
 
+		sid: eeprom at 1c14000 {
+			reg = <0x1c14000 0x400>;
+		};
+
 		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.17.0
