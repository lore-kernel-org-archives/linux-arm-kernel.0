From: ben@decadent.org.uk (Ben Hutchings)
Date: Sat, 07 Apr 2012 05:08:45 +0100
Subject: [PATCH] ARM: orion5x: Fix GPIO enable bits for MPP9
Message-ID: <1333771725.7150.32.camel@deadeye>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 554cdaefd1cf7bb54b209c4e68c7cec87ce442a9 seems to have
accidentally inverted the GPIO valid bits for MPP9 (only).  For the
mv2120 platform which uses MPP9 as a GPIO LED device, this results in
the error:

[   12.711476] leds-gpio: probe of leds-gpio failed with error -22

Reported-by: Henry von Tresckow <hvontres@gmail.com>
References: http://bugs.debian.org/667446
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: stable at vger.kernel.org [v3.0+]
---
I know nothing about this platform, and this is totally untested.  But
it does look quite straightforward...

Ben.

 arch/arm/mach-orion5x/mpp.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-orion5x/mpp.h b/arch/arm/mach-orion5x/mpp.h
index eac6897..db70e79 100644
--- a/arch/arm/mach-orion5x/mpp.h
+++ b/arch/arm/mach-orion5x/mpp.h
@@ -65,8 +65,8 @@
 #define MPP8_GIGE               MPP(8,  0x1, 0, 0, 1,   1,   1)
 
 #define MPP9_UNUSED		MPP(9,  0x0, 0, 0, 1,   1,   1)
-#define MPP9_GPIO		MPP(9,  0x0, 0, 0, 1,   1,   1)
-#define MPP9_GIGE               MPP(9,  0x1, 1, 1, 1,   1,   1)
+#define MPP9_GPIO		MPP(9,  0x0, 1, 1, 1,   1,   1)
+#define MPP9_GIGE               MPP(9,  0x1, 0, 0, 1,   1,   1)
 
 #define MPP10_UNUSED		MPP(10, 0x0, 0, 0, 1,   1,   1)
 #define MPP10_GPIO		MPP(10, 0x0, 1, 1, 1,   1,   1)
-- 
1.7.9.5
