From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu, 17 Apr 2014 18:41:59 +0100
Subject: [PATCH 1/3] arm: dts: add device_type="memory" for ste-ccu8540
In-Reply-To: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1397756521-29387-2-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current .dts for ste-ccu8540 lacks a 'device_type = "memory"' for
its memory node, relying on an old ppc quirk in order to discover its
memory. Add this, to permit that quirk to be made ppc only.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-ccu8540.dts |    1 +
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
1.7.10.4
