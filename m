From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:34 +0900
Subject: [PATCH 08/69] ARM: shmobile: r8a7778: Fix pin control device address
 in DT
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <80d01feec9f20e30ab7a998a120bce697bb7d935.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The PFC device is erroneously declared at address 0xfffc000 instead of
0xfffc0000. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 7a2c433..a582211 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -114,7 +114,7 @@
 
 	pfc: pfc at fffc0000 {
 		compatible = "renesas,pfc-r8a7778";
-		reg = <0xfffc000 0x118>;
+		reg = <0xfffc0000 0x118>;
 	};
 
 	i2c0: i2c at ffc70000 {
-- 
1.8.4
