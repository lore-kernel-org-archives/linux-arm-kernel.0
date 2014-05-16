From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:10 +0900
Subject: [PATCH 01/11] ARM: shmobile: henninger: specify EXTAL frequency
In-Reply-To: <cover.1400200395.git.horms+renesas@verge.net.au>
References: <cover.1400200395.git.horms+renesas@verge.net.au>
Message-ID: <2af0d93762e91d4496cc2e63761c70ae9f50f997.1400200395.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

When creating the initial device tree for the Henninger board,  I've overlooked
that EXTAL frequency needs to be overridden there. The 'sh-sci' driver  managed
to work somehow but the SDHI driver that I've tried to enable just hanged with
the default EXTAL frequency of 0...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index 6e67cea..0a65523 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -35,6 +35,10 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
 &pfc {
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
-- 
1.8.5.2
