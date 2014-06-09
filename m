From: jslaby@suse.cz (Jiri Slaby)
Date: Mon,  9 Jun 2014 10:50:10 +0200
Subject: [PATCH 3.12 075/146] arm: dts: Fix missing device_type="memory" for
 ste-ccu8540
In-Reply-To: <ebe219e45dcf94c1a34281167427cff4d742faef.1402303820.git.jslaby@suse.cz>
References: <ebe219e45dcf94c1a34281167427cff4d742faef.1402303820.git.jslaby@suse.cz>
Message-ID: <f91ba888fc325f37074be0e5ba0fba5d55a78783.1402303821.git.jslaby@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leif Lindholm <leif.lindholm@linaro.org>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit bfaed5abad998bfc88a66e6e71c7b08dcf82f04e upstream.

The current .dts for ste-ccu8540 lacks a 'device_type = "memory"' for
its memory node, relying on an old ppc quirk in order to discover its
memory. Fix the data so that all parsing code can handle it correctly.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/arm/boot/dts/ste-ccu8540.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ste-ccu8540.dts b/arch/arm/boot/dts/ste-ccu8540.dts
index 7f3baf51a3a9..32dd55e5f4e6 100644
--- a/arch/arm/boot/dts/ste-ccu8540.dts
+++ b/arch/arm/boot/dts/ste-ccu8540.dts
@@ -18,6 +18,7 @@
 	compatible = "st-ericsson,ccu8540", "st-ericsson,u8540";
 
 	memory at 0 {
+		device_type = "memory";
 		reg = <0x20000000 0x1f000000>, <0xc0000000 0x3f000000>;
 	};
 
-- 
1.9.3
