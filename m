From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 4 Feb 2011 11:03:12 -0600
Subject: [PATCH] ep93xx: fix build error in edb93xx framebuffer support
In-Reply-To: <201102021738.22717.hartleys@visionengravers.com>
References: <201102021738.22717.hartleys@visionengravers.com>
Message-ID: <0D753D10438DA54287A00B027084269764CF0C44E3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The patch below is needed to fix a build error introduced by:

ARM: 6643/1: ep93xx: add framebuffer support to edb93xx boards

This patch is in linux-next now (commit 6491e80bbb830a593649be9fce83c6b2a520e8d7)
but has not reached Linus tree.

Should I add it to your patch tracking system?

Thanks,
Hartley

-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of H Hartley Sweeten
Sent: Wednesday, February 02, 2011 5:38 PM
To: ARM Kernel
Cc: Ryan Mallon; subaparts at yandex.ru
Subject: [PATCH] ep93xx: fix build error in edb93xx framebuffer support

Add missing semicolon to fix a build error.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Reported-by: Alexander Sverdlin <subaparts@yandex.ru>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 9b00bee..3f37567 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -126,7 +126,7 @@ static int __init edb93xx_has_fb(void)
 	/* These platforms have an ep93xx with video capability */
 	return (machine_is_edb9307() || machine_is_edb9307a() ||
 		machine_is_edb9312() || machine_is_edb9315() ||
-		machine_is_edb9315a())
+		machine_is_edb9315a());
 }
 
 static void __init edb93xx_register_fb(void)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
