From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Aug 2014 09:35:22 +0900
Subject: [PATCH v2 1/5] ARM: shmobile: lager: correct memory map value and
 syntax
In-Reply-To: <1409099726-21814-1-git-send-email-horms+renesas@verge.net.au>
References: <1409099726-21814-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1409099726-21814-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The base address of the second memory region on the lager
board is 0x140000000. Update the tag used in the dts file accordingly.

Also correct a syntax error by using two comma-delimited 32 bit values
rather than a single 64 bit value.

This is a documentation fix and should have no run-time affect.

This problem was introduced when the second memory region
was added to the lager dts file by 62bc32a2573c4219
("ARM: shmobile: Include all 4 GiB of memory on Lager)" in v3.14.

Cc: Olof Johansson <olof@lixom.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Correct syntax as well as value
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 0118cbf..9586c35 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -32,7 +32,7 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
-	memory at 180000000 {
+	memory at 1,40000000 {
 		device_type = "memory";
 		reg = <1 0x40000000 0 0xc0000000>;
 	};
-- 
2.0.1
