From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Thu, 30 Nov 2017 09:12:24 +0530
Subject: [PATCH 2/2][v2] ARM: dts: ls1021aqds: Add nand node for ifc controller
In-Reply-To: <1512013344-4042-1-git-send-email-prabhakar.kushwaha@nxp.com>
References: <1512013344-4042-1-git-send-email-prabhakar.kushwaha@nxp.com>
Message-ID: <1512013344-4042-3-git-send-email-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS1021AQDS support NAND flash on IFC chip-select 2.

So add NAND node in device tree for IFC controller.

Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
Changes for v2: updated subject

 arch/arm/boot/dts/ls1021a-qds.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 9408753..2b37d04 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -239,6 +239,11 @@
 		device-width = <1>;
 	};
 
+	nand at 2,0 {
+		compatible = "fsl,ifc-nand";
+		reg = <0x2 0x0 0x10000>;
+	};
+
 	fpga: board-control at 3,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
