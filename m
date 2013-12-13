From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:13 +0900
Subject: [PATCH 39/69] ARM: shmobile: kzm9g-reference: Use falling edge IRQ
 for LAN9221
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <72e14c051a920d9c30d6cab2aecd1699a070aebe.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The device is configured to generate an active-low interrupt signal that
is automatically deasserted without requiring any action from the host.
Configure the IRQ to trigger on falling edge.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 605f6c6..12fdfaa 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -83,7 +83,7 @@
 		reg = <0x10000000 0x100>;
 		phy-mode = "mii";
 		interrupt-parent = <&irqpin0>;
-		interrupts = <3 IRQ_TYPE_NONE>;	/* active low */
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 		reg-io-width = <4>;
 		smsc,irq-push-pull;
 		smsc,save-mac-address;
-- 
1.8.4
