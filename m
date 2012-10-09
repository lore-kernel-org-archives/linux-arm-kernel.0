From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 09 Oct 2012 12:39:59 +0200
Subject: [PATCH] ARM: dts: exynos4210-trats: Split memory into 4 sections
Message-ID: <1349779199-30665-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the maximum section size on mach-exynos is set to 256MiB, boards
with memory configuration defined using sections bigger than 256MiB will
fail to boot with a kernel panic.

This patch modifies the dts file of Samsung Trats board to define four
sections of 256MiB instead of two of 512MiB to fix the boot problem.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 73567b8..a21511c 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -20,8 +20,10 @@
 	compatible = "samsung,trats", "samsung,exynos4210";
 
 	memory {
-		reg =  <0x40000000 0x20000000
-			0x60000000 0x20000000>;
+		reg =  <0x40000000 0x10000000
+			0x50000000 0x10000000
+			0x60000000 0x10000000
+			0x70000000 0x10000000>;
 	};
 
 	chosen {
-- 
1.7.12
