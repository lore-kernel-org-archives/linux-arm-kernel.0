From: kamal@canonical.com (Kamal Mostafa)
Date: Tue, 17 Jun 2014 14:43:48 -0700
Subject: [PATCH 3.13 134/212] arm: dts: Fix missing device_type="memory" for
 ste-ccu8540
In-Reply-To: <1403041506-13646-1-git-send-email-kamal@canonical.com>
References: <1403041506-13646-1-git-send-email-kamal@canonical.com>
Message-ID: <1403041506-13646-135-git-send-email-kamal@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

3.13.11.4 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leif Lindholm <leif.lindholm@linaro.org>

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/arm/boot/dts/ste-ccu8540.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ste-ccu8540.dts b/arch/arm/boot/dts/ste-ccu8540.dts
index 7f3baf5..32dd55e 100644
--- a/arch/arm/boot/dts/ste-ccu8540.dts
+++ b/arch/arm/boot/dts/ste-ccu8540.dts
@@ -18,6 +18,7 @@
 	compatible = "st-ericsson,ccu8540", "st-ericsson,u8540";
 
 	memory at 0 {
+		device_type = "memory";
 		reg = <0x20000000 0x1f000000>, <0xc0000000 0x3f000000>;
 	};
 
-- 
1.9.1
