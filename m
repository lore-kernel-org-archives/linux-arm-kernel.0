From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 13 Mar 2010 12:17:59 +0100
Subject: staging/dream: fix gpio_input compilation
Message-ID: <20100313111759.GA2317@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


gpio_* drivers still need drivers in staging. Yes, that will need to
be fixed, but at least fix compilation for now.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/staging/dream/Makefile b/drivers/staging/dream/Makefile
index 2b79151..43d1eec 100644
--- a/drivers/staging/dream/Makefile
+++ b/drivers/staging/dream/Makefile
@@ -1,3 +1,4 @@
+EXTRA_CFLAGS=-Idrivers/staging/dream/include
 obj-$(CONFIG_MSM_ADSP)		+= qdsp5/ smd/
 obj-$(CONFIG_MSM_CAMERA)	+= camera/
 obj-$(CONFIG_INPUT_GPIO)	+= gpio_axis.o gpio_event.o gpio_input.o gpio_matrix.o gpio_output.o
