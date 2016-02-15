From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 15 Feb 2016 21:38:34 +0100
Subject: [PATCH v3 6/7] arm64: dts: r8a7795: Add missing properties to CA57 L2
 cache node
In-Reply-To: <1455568715-20880-1-git-send-email-geert+renesas@glider.be>
References: <1455568715-20880-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1455568715-20880-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing "cache-unified" and "cache-level" properties to the
Cortex-A57 cache-controller node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Remaining part of "[PATCH v2 6/6] arm64: renesas: r8a7795: Add L2
    cache-controller nodes", after dropping the "arm,data-latency" and
    "arm,tag-latency" properties.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b5e46e4ff72ad003..c07f4e83b988ba42 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -68,6 +68,8 @@
 
 	L2_CA57: cache-controller at 0 {
 		compatible = "cache";
+		cache-unified;
+		cache-level = <2>;
 	};
 
 	extal_clk: extal {
-- 
1.9.1
