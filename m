From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 Mar 2016 10:05:44 +0900
Subject: [PATCH] ARM: dts: porter: remove enable prop from HS-USB device node
In-Reply-To: <cover.1456880499.git.horms+renesas@verge.net.au>
References: <cover.1456880499.git.horms+renesas@verge.net.au>
Message-ID: <949024d6702d1da8a266f42226d8402f0df078dc.1456880499.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

In  the final versions of the Porter board (called "PORTER_C") Renesas
decided to get rid  of the Maxim Integrated MAX3355 OTG chip and didn't
add any other provision to differ the host/gadget mode, so we'll have to
remove  no longer valid "renesas,enable-gpio" property from the HS-USB
device node.  Hopefully, the earlier revisions of the board were never
seen in the wild...

Fixes: c794f6a09a25 ("ARM: shmobile: porter: add HS-USB DT support")
Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 6713b1ea732b..01d239c3eaaa 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -283,7 +283,6 @@
 	pinctrl-names = "default";
 
 	status = "okay";
-	renesas,enable-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
 };
 
 &usbphy {
-- 
2.1.4
