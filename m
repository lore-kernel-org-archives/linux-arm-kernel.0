From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:53 +0900
Subject: [PATCH 25/33] ARM: shmobile: lager: Correct setting of ethernet PHY
 LED mode
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <1c47a6aae8bc6113463c47e9b8d35e35e97411b2.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct binding is "micrel,led-mode", not "led-mode".

This corrects an error which was introduced when setting of ethernet PHY
LED mode was added by 82e62182d59bd1d0 ("ARM: shmobile: lager: Set ethernet
PHY LED mode").

This makes the lager code consistent with the koelsch code which was added
by ae00d12a032490b3 ("ARM: shmobile: koelsch: Set ethernet PHY LED mode").

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index a55c5f8..265cba1 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -213,7 +213,7 @@
 		reg = <1>;
 		interrupt-parent = <&irqc0>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-		led-mode = <1>;
+		micrel,led-mode = <1>;
 	};
 };
 
-- 
1.8.5.2
