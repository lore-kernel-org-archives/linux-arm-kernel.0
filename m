From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:43 +0200
Subject: [PATCH 48/58] arm64: dts: renesas: salvator-xs: Improve SATA switch
 settings comments
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <48e1f50bd67a4ee6c168e5d869cc49096cb2d203.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The comments describing the non-default switch settings to use SATA are
confusing: 'Off' refers to the switch position, not to the MD12 logic
value, while the parentheses suggest otherwise.  Rephrase to fix this.

Fixes: bec000784d5bb571 ("arm64: dts: renesas: salvator-xs: enable SATA")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts  | 2 +-
 arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index ba3357636fdb..cf08a119eec0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -184,7 +184,7 @@
 	};
 };
 
-/* MD12 (SW12-7) must be set 'Off' which is not the default! */
+/* SW12-7 must be set 'Off' (MD12 set to 1) which is not the default! */
 &sata {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
index 45016a06fab1..f03a5e9e0c42 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
@@ -57,7 +57,7 @@
 	};
 };
 
-/* MD12 (SW12-7) must be set 'Off' which is not the default! */
+/* SW12-7 must be set 'Off' (MD12 set to 1) which is not the default! */
 &sata {
 	status = "okay";
 };
-- 
2.11.0
