From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:19:58 +0900
Subject: [PATCH 07/25] ARM: shmobile: r8a7791: sound enables Audio DMAC entry
 on DTSI
In-Reply-To: <cover.1415755881.git.horms+renesas@verge.net.au>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
Message-ID: <2a1873bc09509e7e9871254ed6360104091f1bae.1415755881.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 379e1a5..e856afa 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1399,6 +1399,50 @@
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 
+		dmas =		<&audma0 0x01>,	<&audma1 0x02>,	<&audma0 0x15>,	<&audma1 0x16>,
+				<&audma0 0x03>,	<&audma1 0x04>,	<&audma0 0x49>,	<&audma1 0x4a>,
+				<&audma0 0x05>,	<&audma1 0x06>,	<&audma0 0x63>,	<&audma1 0x64>,
+				<&audma0 0x07>,	<&audma1 0x08>,	<&audma0 0x6f>,	<&audma1 0x70>,
+				<&audma0 0x09>,	<&audma1 0x0a>,	<&audma0 0x71>,	<&audma1 0x72>,
+				<&audma0 0x0b>,	<&audma1 0x0c>,	<&audma0 0x73>,	<&audma1 0x74>,
+				<&audma0 0x0d>,	<&audma1 0x0e>,	<&audma0 0x75>,	<&audma1 0x76>,
+				<&audma0 0x0f>,	<&audma1 0x10>,	<&audma0 0x79>,	<&audma1 0x7a>,
+				<&audma0 0x11>,	<&audma1 0x12>,	<&audma0 0x7b>,	<&audma1 0x7c>,
+				<&audma0 0x13>,	<&audma1 0x14>,	<&audma0 0x7d>,	<&audma1 0x7e>,
+
+				<&audma0 0x85>,	<&audma1 0x9a>,	<&audma0 0xbc>,
+				<&audma0 0x87>,	<&audma1 0x9c>,	<&audma0 0xbe>,
+				<&audma0 0x89>,	<&audma1 0x9e>,
+				<&audma0 0x8b>,	<&audma1 0xa0>,
+				<&audma0 0x8d>,	<&audma1 0xb0>,
+				<&audma0 0x8f>,	<&audma1 0xb2>,
+				<&audma0 0x91>,	<&audma1 0xb4>,
+				<&audma0 0x93>,	<&audma1 0xb6>,
+				<&audma0 0x95>,	<&audma1 0xb8>,
+				<&audma0 0x97>,	<&audma1 0xba>;
+
+		dma-names =	"mem_ssi0",	"ssi0_mem",	"mem_ssiu0",	"ssiu0_mem",
+				"mem_ssi1",	"ssi1_mem",	"mem_ssiu1",	"ssiu1_mem",
+				"mem_ssi2",	"ssi2_mem",	"mem_ssiu2",	"ssiu2_mem",
+				"mem_ssi3",	"ssi3_mem",	"mem_ssiu3",	"ssiu3_mem",
+				"mem_ssi4",	"ssi4_mem",	"mem_ssiu4",	"ssiu4_mem",
+				"mem_ssi5",	"ssi5_mem",	"mem_ssiu5",	"ssiu5_mem",
+				"mem_ssi6",	"ssi6_mem",	"mem_ssiu6",	"ssiu6_mem",
+				"mem_ssi7",	"ssi7_mem",	"mem_ssiu7",	"ssiu7_mem",
+				"mem_ssi8",	"ssi8_mem",	"mem_ssiu8",	"ssiu8_mem",
+				"mem_ssi9",	"ssi9_mem",	"mem_ssiu9",	"ssiu9_mem",
+
+				"mem_src0",	"src0_mem",	"dvc0_mem",
+				"mem_src1",	"src1_mem",	"dvc1_mem",
+				"mem_src2",	"src2_mem",
+				"mem_src3",	"src3_mem",
+				"mem_src4",	"src4_mem",
+				"mem_src5",	"src5_mem",
+				"mem_src6",	"src6_mem",
+				"mem_src7",	"src7_mem",
+				"mem_src8",	"src8_mem",
+				"mem_src9",	"src9_mem";
+
 		status = "disabled";
 
 		rcar_sound,dvc {
-- 
2.1.1
