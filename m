From: kamal@canonical.com (Kamal Mostafa)
Date: Tue, 17 Jun 2014 14:42:25 -0700
Subject: [3.13.y.z extended stable] Patch "arm: dts: Fix missing
 device_type="memory" for ste-ccu8540" has been added to staging queue
Message-ID: <1403041345-10016-1-git-send-email-kamal@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a note to let you know that I have just added a patch titled

    arm: dts: Fix missing device_type="memory" for ste-ccu8540

to the linux-3.13.y-queue branch of the 3.13.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue

This patch is scheduled to be released in version 3.13.11.4.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.13.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

>From 9be0219d7a880ddfb91221f7f70a6aa5fdfae125 Mon Sep 17 00:00:00 2001
From: Leif Lindholm <leif.lindholm@linaro.org>
Date: Thu, 17 Apr 2014 18:41:59 +0100
Subject: arm: dts: Fix missing device_type="memory" for ste-ccu8540

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
