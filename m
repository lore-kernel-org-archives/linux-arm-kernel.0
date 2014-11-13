From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:19:59 +0900
Subject: [PATCH 08/25] ARM: shmobile: r8a7790: sound enables Audio DMAC peri
 peri entry on DTSI
In-Reply-To: <cover.1415755881.git.horms+renesas@verge.net.au>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
Message-ID: <cbfc0b77b0c5ac11282882bfd734716e47d20b45.1415755881.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 92 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 70daf91..0bab1d5 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1437,7 +1437,51 @@
 				<&audma0 0x91>,	<&audma1 0xb4>,
 				<&audma0 0x93>,	<&audma1 0xb6>,
 				<&audma0 0x95>,	<&audma1 0xb8>,
-				<&audma0 0x97>,	<&audma1 0xba>;
+				<&audma0 0x97>,	<&audma1 0xba>,
+
+				<&audmapp 0x2d00>,	<&audmapp 0x2e00>,	<&audmapp 0x2f00>,	<&audmapp 0x3000>,	<&audmapp 0x3100>,
+				<&audmapp 0x2d04>,	<&audmapp 0x2e04>,	<&audmapp 0x2f04>,	<&audmapp 0x3004>,	<&audmapp 0x3104>,
+				<&audmapp 0x2d08>,	<&audmapp 0x2e08>,	<&audmapp 0x2f08>,	<&audmapp 0x3008>,	<&audmapp 0x3108>,
+				<&audmapp 0x2d0c>,	<&audmapp 0x2e0c>,	<&audmapp 0x2f0c>,	<&audmapp 0x300c>,	<&audmapp 0x310c>,
+				<&audmapp 0x2d0d>,	<&audmapp 0x2e0d>,	<&audmapp 0x2f0d>,	<&audmapp 0x300d>,	<&audmapp 0x310d>,
+				<&audmapp 0x2d0e>,	<&audmapp 0x2e0e>,	<&audmapp 0x2f0e>,	<&audmapp 0x300e>,	<&audmapp 0x310e>,
+				<&audmapp 0x2d0f>,	<&audmapp 0x2e0f>,	<&audmapp 0x2f0f>,	<&audmapp 0x300f>,	<&audmapp 0x310f>,
+				<&audmapp 0x2d10>,	<&audmapp 0x2e10>,	<&audmapp 0x2f10>,	<&audmapp 0x3010>,	<&audmapp 0x3110>,
+				<&audmapp 0x2d11>,	<&audmapp 0x2e11>,	<&audmapp 0x2f11>,	<&audmapp 0x3011>,	<&audmapp 0x3111>,
+				<&audmapp 0x2d12>,	<&audmapp 0x2e12>,	<&audmapp 0x2f12>,	<&audmapp 0x3012>,	<&audmapp 0x3112>,
+
+				<&audmapp 0x3200>,	<&audmapp 0x3300>,	<&audmapp 0x3400>,	<&audmapp 0x3500>,	<&audmapp 0x3600>,
+				<&audmapp 0x3204>,	<&audmapp 0x3304>,	<&audmapp 0x3404>,	<&audmapp 0x3504>,	<&audmapp 0x3604>,
+				<&audmapp 0x3208>,	<&audmapp 0x3308>,	<&audmapp 0x3408>,	<&audmapp 0x3508>,	<&audmapp 0x3608>,
+				<&audmapp 0x320c>,	<&audmapp 0x330c>,	<&audmapp 0x340c>,	<&audmapp 0x350c>,	<&audmapp 0x360c>,
+				<&audmapp 0x320d>,	<&audmapp 0x330d>,	<&audmapp 0x340d>,	<&audmapp 0x350d>,	<&audmapp 0x360d>,
+				<&audmapp 0x320e>,	<&audmapp 0x330e>,	<&audmapp 0x340e>,	<&audmapp 0x350e>,	<&audmapp 0x360e>,
+				<&audmapp 0x320f>,	<&audmapp 0x330f>,	<&audmapp 0x340f>,	<&audmapp 0x350f>,	<&audmapp 0x360f>,
+				<&audmapp 0x3210>,	<&audmapp 0x3310>,	<&audmapp 0x3410>,	<&audmapp 0x3510>,	<&audmapp 0x3610>,
+				<&audmapp 0x3211>,	<&audmapp 0x3311>,	<&audmapp 0x3411>,	<&audmapp 0x3511>,	<&audmapp 0x3611>,
+				<&audmapp 0x3212>,	<&audmapp 0x3312>,	<&audmapp 0x3412>,	<&audmapp 0x3512>,	<&audmapp 0x3612>,
+
+				<&audmapp 0x002d>,	<&audmapp 0x002e>,	<&audmapp 0x002f>,	<&audmapp 0x0030>,	<&audmapp 0x0031>,
+				<&audmapp 0x042d>,	<&audmapp 0x042e>,	<&audmapp 0x042f>,	<&audmapp 0x0430>,	<&audmapp 0x0431>,
+				<&audmapp 0x082d>,	<&audmapp 0x082e>,	<&audmapp 0x082f>,	<&audmapp 0x0830>,	<&audmapp 0x0831>,
+				<&audmapp 0x0c2d>,	<&audmapp 0x0c2e>,	<&audmapp 0x0c2f>,	<&audmapp 0x0c30>,	<&audmapp 0x0c31>,
+				<&audmapp 0x0d2d>,	<&audmapp 0x0d2e>,	<&audmapp 0x0d2f>,	<&audmapp 0x0d30>,	<&audmapp 0x0d31>,
+				<&audmapp 0x0e2d>,	<&audmapp 0x0e2e>,	<&audmapp 0x0e2f>,	<&audmapp 0x0e30>,	<&audmapp 0x0e31>,
+				<&audmapp 0x0f2d>,	<&audmapp 0x0f2e>,	<&audmapp 0x0f2f>,	<&audmapp 0x0f30>,	<&audmapp 0x0f31>,
+				<&audmapp 0x102d>,	<&audmapp 0x102e>,	<&audmapp 0x102f>,	<&audmapp 0x1030>,	<&audmapp 0x1031>,
+				<&audmapp 0x112d>,	<&audmapp 0x112e>,	<&audmapp 0x112f>,	<&audmapp 0x1130>,	<&audmapp 0x1131>,
+				<&audmapp 0x122d>,	<&audmapp 0x122e>,	<&audmapp 0x122f>,	<&audmapp 0x1230>,	<&audmapp 0x1231>,
+
+				<&audmapp 0x0032>,	<&audmapp 0x0033>,	<&audmapp 0x0034>,	<&audmapp 0x0035>,	<&audmapp 0x0036>,
+				<&audmapp 0x0432>,	<&audmapp 0x0433>,	<&audmapp 0x0434>,	<&audmapp 0x0435>,	<&audmapp 0x0436>,
+				<&audmapp 0x0832>,	<&audmapp 0x0833>,	<&audmapp 0x0834>,	<&audmapp 0x0835>,	<&audmapp 0x0836>,
+				<&audmapp 0x0c32>,	<&audmapp 0x0c33>,	<&audmapp 0x0c34>,	<&audmapp 0x0c35>,	<&audmapp 0x0c36>,
+				<&audmapp 0x0d32>,	<&audmapp 0x0d33>,	<&audmapp 0x0d34>,	<&audmapp 0x0d35>,	<&audmapp 0x0d36>,
+				<&audmapp 0x0e32>,	<&audmapp 0x0e33>,	<&audmapp 0x0e34>,	<&audmapp 0x0e35>,	<&audmapp 0x0e36>,
+				<&audmapp 0x0f32>,	<&audmapp 0x0f33>,	<&audmapp 0x0f34>,	<&audmapp 0x0f35>,	<&audmapp 0x0f36>,
+				<&audmapp 0x1032>,	<&audmapp 0x1033>,	<&audmapp 0x1034>,	<&audmapp 0x1035>,	<&audmapp 0x1036>,
+				<&audmapp 0x1132>,	<&audmapp 0x1133>,	<&audmapp 0x1134>,	<&audmapp 0x1135>,	<&audmapp 0x1136>,
+				<&audmapp 0x1232>,	<&audmapp 0x1233>,	<&audmapp 0x1234>,	<&audmapp 0x1235>,	<&audmapp 0x1236>;
 
 		dma-names =	"mem_ssi0",	"ssi0_mem",	"mem_ssiu0",	"ssiu0_mem",
 				"mem_ssi1",	"ssi1_mem",	"mem_ssiu1",	"ssiu1_mem",
@@ -1459,7 +1503,51 @@
 				"mem_src6",	"src6_mem",
 				"mem_src7",	"src7_mem",
 				"mem_src8",	"src8_mem",
-				"mem_src9",	"src9_mem";
+				"mem_src9",	"src9_mem",
+
+				"src0_ssiu0",		"src1_ssiu0",		"src2_ssiu0",		"src3_ssiu0",		"src4_ssiu0",
+				"src0_ssiu1",		"src1_ssiu1",		"src2_ssiu1",		"src3_ssiu1",		"src4_ssiu1",
+				"src0_ssiu2",		"src1_ssiu2",		"src2_ssiu2",		"src3_ssiu2",		"src4_ssiu2",
+				"src0_ssiu3",		"src1_ssiu3",		"src2_ssiu3",		"src3_ssiu3",		"src4_ssiu3",
+				"src0_ssiu4",		"src1_ssiu4",		"src2_ssiu4",		"src3_ssiu4",		"src4_ssiu4",
+				"src0_ssiu5",		"src1_ssiu5",		"src2_ssiu5",		"src3_ssiu5",		"src4_ssiu5",
+				"src0_ssiu6",		"src1_ssiu6",		"src2_ssiu6",		"src3_ssiu6",		"src4_ssiu6",
+				"src0_ssiu7",		"src1_ssiu7",		"src2_ssiu7",		"src3_ssiu7",		"src4_ssiu7",
+				"src0_ssiu8",		"src1_ssiu8",		"src2_ssiu8",		"src3_ssiu8",		"src4_ssiu8",
+				"src0_ssiu9",		"src1_ssiu9",		"src2_ssiu9",		"src3_ssiu9",		"src4_ssiu9",
+
+				"src5_ssiu0",		"src6_ssiu0",		"src7_ssiu0",		"src8_ssiu0",		"src9_ssiu0",
+				"src5_ssiu1",		"src6_ssiu1",		"src7_ssiu1",		"src8_ssiu1",		"src9_ssiu1",
+				"src5_ssiu2",		"src6_ssiu2",		"src7_ssiu2",		"src8_ssiu2",		"src9_ssiu2",
+				"src5_ssiu3",		"src6_ssiu3",		"src7_ssiu3",		"src8_ssiu3",		"src9_ssiu3",
+				"src5_ssiu4",		"src6_ssiu4",		"src7_ssiu4",		"src8_ssiu4",		"src9_ssiu4",
+				"src5_ssiu5",		"src6_ssiu5",		"src7_ssiu5",		"src8_ssiu5",		"src9_ssiu5",
+				"src5_ssiu6",		"src6_ssiu6",		"src7_ssiu6",		"src8_ssiu6",		"src9_ssiu6",
+				"src5_ssiu7",		"src6_ssiu7",		"src7_ssiu7",		"src8_ssiu7",		"src9_ssiu7",
+				"src5_ssiu8",		"src6_ssiu8",		"src7_ssiu8",		"src8_ssiu8",		"src9_ssiu8",
+				"src5_ssiu9",		"src6_ssiu9",		"src7_ssiu9",		"src8_ssiu9",		"src9_ssiu9",
+
+				"ssiu0_src0",		"ssiu0_src1",		"ssiu0_src2",		"ssiu0_src3",		"ssiu0_src4",
+				"ssiu1_src0",		"ssiu1_src1",		"ssiu1_src2",		"ssiu1_src3",		"ssiu1_src4",
+				"ssiu2_src0",		"ssiu2_src1",		"ssiu2_src2",		"ssiu2_src3",		"ssiu2_src4",
+				"ssiu3_src0",		"ssiu3_src1",		"ssiu3_src2",		"ssiu3_src3",		"ssiu3_src4",
+				"ssiu4_src0",		"ssiu4_src1",		"ssiu4_src2",		"ssiu4_src3",		"ssiu4_src4",
+				"ssiu5_src0",		"ssiu5_src1",		"ssiu5_src2",		"ssiu5_src3",		"ssiu5_src4",
+				"ssiu6_src0",		"ssiu6_src1",		"ssiu6_src2",		"ssiu6_src3",		"ssiu6_src4",
+				"ssiu7_src0",		"ssiu7_src1",		"ssiu7_src2",		"ssiu7_src3",		"ssiu7_src4",
+				"ssiu8_src0",		"ssiu8_src1",		"ssiu8_src2",		"ssiu8_src3",		"ssiu8_src4",
+				"ssiu9_src0",		"ssiu9_src1",		"ssiu9_src2",		"ssiu9_src3",		"ssiu9_src4",
+
+				"ssiu0_src5",		"ssiu0_src6",		"ssiu0_src7",		"ssiu0_src8",		"ssiu0_src9",
+				"ssiu1_src5",		"ssiu1_src6",		"ssiu1_src7",		"ssiu1_src8",		"ssiu1_src9",
+				"ssiu2_src5",		"ssiu2_src6",		"ssiu2_src7",		"ssiu2_src8",		"ssiu2_src9",
+				"ssiu3_src5",		"ssiu3_src6",		"ssiu3_src7",		"ssiu3_src8",		"ssiu3_src9",
+				"ssiu4_src5",		"ssiu4_src6",		"ssiu4_src7",		"ssiu4_src8",		"ssiu4_src9",
+				"ssiu5_src5",		"ssiu5_src6",		"ssiu5_src7",		"ssiu5_src8",		"ssiu5_src9",
+				"ssiu6_src5",		"ssiu6_src6",		"ssiu6_src7",		"ssiu6_src8",		"ssiu6_src9",
+				"ssiu7_src5",		"ssiu7_src6",		"ssiu7_src7",		"ssiu7_src8",		"ssiu7_src9",
+				"ssiu8_src5",		"ssiu8_src6",		"ssiu8_src7",		"ssiu8_src8",		"ssiu8_src9",
+				"ssiu9_src5",		"ssiu9_src6",		"ssiu9_src7",		"ssiu9_src8",		"ssiu9_src9";
 
 		status = "disabled";
 
-- 
2.1.1
