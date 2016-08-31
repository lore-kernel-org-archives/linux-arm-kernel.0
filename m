From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 31 Aug 2016 16:14:11 +0300
Subject: [PATCH v3 6/8] ARM: dts: am335x-evm: Add blue-and-red-wiring
 -property to lcdc node
In-Reply-To: <cover.1472634657.git.jsarha@ti.com>
References: <cover.1472634657.git.jsarha@ti.com>
Message-ID: <d16927aa12414972d5c287d7c3bfc6701f1ec39d.1472634657.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add blue-and-red-wiring -property to lcdc node. The am335x-evm has
blue and red wires crossed to get 24-bit RGB (and 16-bit BGR)
support. After this patch am335x-evm supports BGR565, RGB888, and
XRGB8888 color formats. See details in
Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 5d28712..c3cbce0 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -497,6 +497,8 @@
 
 &lcdc {
 	status = "okay";
+
+	blue-and-red-wiring = "crossed";
 };
 
 &elm {
-- 
1.9.1
