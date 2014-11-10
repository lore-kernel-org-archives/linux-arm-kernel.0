From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 10:32:18 +0900
Subject: [PATCH 1/8] ARM: shmobile: r8a7778 dtsi: Remove unnecessary MMC
 options
In-Reply-To: <cover.1415582842.git.horms+renesas@verge.net.au>
References: <cover.1415582842.git.horms+renesas@verge.net.au>
Message-ID: <a9ad9a47485a979397a2546d0ad5b9cf455e8857.1415582842.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As of commit b3a5d4ce65162d27 ("mmc: sdhi: update sh_mobile_sdhi_of_data
for r8a7778), the driver takes care of r8a7778 specific MMC options.
Hence they can be removed from the dtsi.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[geert: Rebased, reworded, added reference]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 315ec62..99eeec2 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -215,8 +215,6 @@
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4c000 0x100>;
 		interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -224,8 +222,6 @@
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4d000 0x100>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -233,8 +229,6 @@
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4f000 0x100>;
 		interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
-- 
2.1.1
