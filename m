From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  5 Aug 2011 12:24:44 +0200
Subject: [PATCH] mach-sa1100: fix PCI build problem
Message-ID: <1312539884-10631-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI nanoengine driver in the SA1100 machine probably has not
been building for some time. It probably dragged hardware.h
in implicitly and now it doesn't anymore. After this an SA1100
build selecting all system variants will build successfully.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/pci-nanoengine.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/pci-nanoengine.c b/arch/arm/mach-sa1100/pci-nanoengine.c
index 964c6c3..dd39fee 100644
--- a/arch/arm/mach-sa1100/pci-nanoengine.c
+++ b/arch/arm/mach-sa1100/pci-nanoengine.c
@@ -28,6 +28,7 @@
 #include <asm/mach-types.h>
 
 #include <mach/nanoengine.h>
+#include <mach/hardware.h>
 
 static DEFINE_SPINLOCK(nano_lock);
 
-- 
1.7.6
