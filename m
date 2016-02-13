From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 14 Feb 2016 01:26:34 +0300
Subject: [PATCH] ARM: dts: porter: remove enable prop from HS-USB device node
In-Reply-To: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
Message-ID: <2684686.0L09MeB6pA@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In  the final versions of the Porter board (called "PORTER_C") Renesas
decided to get rid  of the Maxim Integrated MAX3355 OTG chip and didn't
add any other provision to differ the host/gadget mode, so we'll have to
remove  no longer valid "renesas,enable-gpio" property from the HS-USB
device node.  Hopefully, the earlier revisions of the board were never
seen in the wild...

Fixes: c794f6a09a25 ("ARM: shmobile: porter: add HS-USB DT support")
Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'master' branch of Simon Horman's 'renesas.git' repo.

 arch/arm/boot/dts/r8a7791-porter.dts |    1 -
 1 file changed, 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -283,7 +283,6 @@
 	pinctrl-names = "default";
 
 	status = "okay";
-	renesas,enable-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
 };
 
 &usbphy {
