From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:48 +0900
Subject: [PATCH 13/17] ARM: shmobile: koelsch: Enable SATA0 in
 r8a7791-koelsch.dts
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
Message-ID: <760c277b23973a3db181b2ae98d9a87f6e8f843e.1391665761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This enables SATA0 in Koelsch device tree.
SATA1 is not available on Koelsch since
its pinmux configuration is fixed to PCIe.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index d30527d..74f0985 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -122,3 +122,7 @@
 		renesas,function = "scif1";
 	};
 };
+
+&sata0 {
+	status = "okay";
+};
-- 
1.8.5.2
