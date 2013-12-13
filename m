From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:47 +0900
Subject: [PATCH 13/69] ARM: shmobile: bockw: fixup MMC pin conflict on DTS
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <9ebe54baf8a166384201b4a78c649106047ebc75.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index c6b834f..4d997f8 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -51,10 +51,6 @@
 		vdd33a-supply = <&fixedregulator3v3>;
 	};
 
-	mmc_pins: mmc {
-		renesas,groups = "mmc_data8", "mmc_ctrl";
-		renesas,function = "mmc";
-	};
 };
 
 &mmcif {
@@ -79,4 +75,9 @@
 		renesas,groups = "scif0_data_a", "scif0_ctrl";
 		renesas,function = "scif0";
 	};
+
+	mmc_pins: mmc {
+		renesas,groups = "mmc_data8", "mmc_ctrl";
+		renesas,function = "mmc";
+	};
 };
-- 
1.8.4
