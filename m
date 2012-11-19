From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 19 Nov 2012 15:46:33 +0100
Subject: [PATCH 1/4] ARM: dts: exynos4210-origen: Split memory sections
In-Reply-To: <1353336396-21161-1-git-send-email-t.figa@samsung.com>
References: <1353336396-21161-1-git-send-email-t.figa@samsung.com>
Message-ID: <1353336396-21161-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes memory configuration defined in dts file of Origen
board from single 1 GiB section into four 256 MiB sections to match
section size limit.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index f16c99f..392d9de 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -22,7 +22,10 @@
 	compatible = "insignal,origen", "samsung,exynos4210";
 
 	memory {
-		reg = <0x40000000 0x40000000>;
+		reg =  <0x40000000 0x10000000
+			0x50000000 0x10000000
+			0x60000000 0x10000000
+			0x70000000 0x10000000>;
 	};
 
 	chosen {
-- 
1.8.0
