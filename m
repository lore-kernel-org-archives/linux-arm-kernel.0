From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  1 Feb 2017 17:21:19 +0100
Subject: [PATCH] staging: bcm2835-audio: remove incorrect include path
Message-ID: <20170201162137.2183285-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver introduces a new instance of the missing-include-dirs warning that
is enabled at the "make W=1" level but has no other output:

cc1: error: /git/arm-soc/drivers/staging/vc04_services/interface/vcos/linuxkernel: No such file or directory [-Werror=missing-include-dirs]

In order to let us enable the warning by default in the future, we should
just remove the incorrect argument here.

Fixes: 23b028c871e1 ("staging: bcm2835-audio: initial staging submission")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/bcm2835-audio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/bcm2835-audio/Makefile b/drivers/staging/bcm2835-audio/Makefile
index d2719e20d1ab..d7b88d164d15 100644
--- a/drivers/staging/bcm2835-audio/Makefile
+++ b/drivers/staging/bcm2835-audio/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_SND_BCM2835)	+= snd-bcm2835.o
 snd-bcm2835-objs		:= bcm2835.o bcm2835-ctl.o bcm2835-pcm.o bcm2835-vchiq.o
 
-ccflags-y += -Idrivers/staging/vc04_services -Idrivers/staging/vc04_services/interface/vcos/linuxkernel -D__VCCOREVER__=0x04000000
+ccflags-y += -Idrivers/staging/vc04_services -D__VCCOREVER__=0x04000000
 
-- 
2.9.0
