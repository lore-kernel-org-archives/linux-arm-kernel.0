From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Thu, 22 Feb 2018 15:45:08 +0530
Subject: [PATCH 3/4][v4][RESEND] ARM: dts: Add NOR connection type with IFC
In-Reply-To: <20180222101511.29631-1-prabhakar.kushwaha@nxp.com>
References: <20180222101511.29631-1-prabhakar.kushwaha@nxp.com>
Message-ID: <20180222101511.29631-4-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Connection between IFC and NOR flash is of big-endian type.

So add big-endian property in flash node to reflect the same.

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
Changes for v2: None
Changes for v3: None
Changes for v4: Updated device tree as per new binding

Resending as all patches of patchset never reaches to patchwork.

 arch/arm/boot/dts/ls1021a-qds.dts | 1 +
 arch/arm/boot/dts/ls1021a-twr.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 940875316d0f..8a383d37884a 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -237,6 +237,7 @@
 		reg = <0x0 0x0 0x8000000>;
 		bank-width = <2>;
 		device-width = <1>;
+		big-endian;
 	};
 
 	fpga: board-control at 3,0 {
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a8b148ad1dd2..2056d30df020 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -205,6 +205,7 @@
 		reg = <0x0 0x0 0x8000000>;
 		bank-width = <2>;
 		device-width = <1>;
+		big-endian;
 	};
 };
 
-- 
2.14.1
