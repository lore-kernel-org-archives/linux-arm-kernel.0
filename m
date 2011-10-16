From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 16 Oct 2011 11:08:06 +0300
Subject: [PATCH] ARM: ep93xx: bring back missing <mach/gpio.h>
Message-ID: <1318752486-970-1-git-send-email-mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change bd5f12a2476 (ARM: 7042/3: mach-ep93xx: break out GPIO driver specifics)
accidentally removed the ep93xx <mach/gpio.h> instead of making it an empty
file. This causes compilation to fail:

In file included from include/linux/gpio.h:18:0,
                  from drivers/gpio/gpiolib.c:10:
linux/arch/arm/include/asm/gpio.h:5:23: fatal error: mach/gpio.h: No such file or directory
compilation terminated.
make[2]: *** [drivers/gpio/gpiolib.o] Error 1

Fix this by adding the file back.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/include/mach/gpio.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/include/mach/gpio.h

diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h b/arch/arm/mach-ep93xx/include/mach/gpio.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-ep93xx/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
-- 
1.7.6.3
