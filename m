From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 31 Aug 2016 16:14:13 +0300
Subject: [PATCH v3 8/8] ARM: dts: am335x-evmsk: Add blue-and-red-wiring
 -property to lcdc node
In-Reply-To: <cover.1472634657.git.jsarha@ti.com>
References: <cover.1472634657.git.jsarha@ti.com>
Message-ID: <da8793eaa8013cea0ad6170d9fa26c878bbc0467.1472634657.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add blue-and-red-wiring -property to lcdc node. The am335x-evmsk has
blue and red wires crossed to get 24-bit RGB (and 16-bit BGR)
support. After this patch am335x-evmsk supports BGR565, RGB888, and
XRGB8888 color formats. See details in
Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 23b94e7..034e117 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -712,4 +712,6 @@
 
 &lcdc {
 	status = "okay";
+
+	blue-and-red-wiring = "crossed";
 };
-- 
1.9.1
