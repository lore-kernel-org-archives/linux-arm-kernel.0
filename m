From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 15 Jan 2014 22:40:48 +0100
Subject: [PATCH v6 1/6] dt-bindings: sram: describe option to reserve parts of
 the memory
In-Reply-To: <27256277.YJ687suYy5@phil>
References: <27256277.YJ687suYy5@phil>
Message-ID: <1433254.MeOmJHi2Mt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs need parts of their sram for special purposes. So while being part
of the peripheral, it should not be part of the genpool controlling the sram.

Therefore add an option mmio-sram-reserved to keep arbitrary portions of the
sram from general usage.

Suggested-by: Rob Herring <robherring2@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
---
 Documentation/devicetree/bindings/misc/sram.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/misc/sram.txt
index 4d0a00e..09ee7a3 100644
--- a/Documentation/devicetree/bindings/misc/sram.txt
+++ b/Documentation/devicetree/bindings/misc/sram.txt
@@ -8,9 +8,17 @@ Required properties:
 
 - reg : SRAM iomem address range
 
+Optional properties:
+
+- mmio-sram-reserved: ordered list of reserved chunks inside the sram that
+  should not be used by the operating system.
+  Format is <base size>, <base size>, ...; with base being relative to the
+  reg property base.
+
 Example:
 
 sram: sram at 5c000000 {
 	compatible = "mmio-sram";
 	reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
+	mmio-sram-reserved = <0x0 0x100>; /* reserve 0x5c000000-0x5c000100 */
 };
-- 
1.7.10.4
