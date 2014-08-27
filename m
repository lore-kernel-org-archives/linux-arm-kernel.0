From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Aug 2014 09:35:23 +0900
Subject: [PATCH v2 2/5] ARM: shmobile: henninger: correct memory map syntax
In-Reply-To: <1409099726-21814-1-git-send-email-horms+renesas@verge.net.au>
References: <1409099726-21814-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1409099726-21814-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct a syntax error by using two comma-delimited 32 bit values
rather than a single 64 bit value.

This is a documentation fix and should have no run-time affect.

This problem was introduced when the device tree was
added for henninger by 4b37ab033e6f8c975
("ARM: shmobile: henninger: initial device tree") in v3.15.

Cc: Olof Johansson <olof@lixom.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index f1b56de..b064724 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -30,7 +30,7 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
-	memory at 200000000 {
+	memory at 2,00000000 {
 		device_type = "memory";
 		reg = <2 0x00000000 0 0x40000000>;
 	};
-- 
2.0.1
