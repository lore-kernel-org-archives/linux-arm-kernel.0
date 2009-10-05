From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Mon,  5 Oct 2009 21:50:34 +0400
Subject: [PATCH] SA1100: fix building of h3100
Message-ID: <1254765034-29849-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both iPaqs h3100 and h3600 currently share the same source
file - h3600.c  But Makefile builds it only if CONFIG_SA1100_H3600
selected, so selecting just CONFIG_SA1100_H3100 results in
"no machine record defined" message and aborted compilation.

Fix it.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
Well, it left unnoticed by me for a while, just because I always build
kernels with _both_ machines compiled in.

 arch/arm/mach-sa1100/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
index 8a5546e..bb7b819 100644
--- a/arch/arm/mach-sa1100/Makefile
+++ b/arch/arm/mach-sa1100/Makefile
@@ -25,6 +25,7 @@ led-$(CONFIG_SA1100_CERF)		+= leds-cerf.o
 
 obj-$(CONFIG_SA1100_COLLIE)		+= collie.o
 
+obj-$(CONFIG_SA1100_H3100)		+= h3600.o
 obj-$(CONFIG_SA1100_H3600)		+= h3600.o
 
 obj-$(CONFIG_SA1100_HACKKIT)		+= hackkit.o
-- 
1.6.3.4
