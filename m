From: linux@prisktech.co.nz (Linux Mailing List Email Account)
Date: Sun, 27 Feb 2011 05:59:01 -0000
Subject: PATCH [0/1] Clock support for VT8500/WM8505
Message-ID: <76F764B079F92A4E843589C893D0A0228D25@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch to add clocks support for VT8500/WM8505 SoC machines.
Signed-off-by: Tony Prisk (linux at prisktech.co.nz<mailto:linux@prisktech.co.nz>)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5e34579..0593323 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -878,6 +878,8 @@ config ARCH_VT8500
    select GENERIC_CLOCKEVENTS
    select ARCH_REQUIRE_GPIOLIB
    select HAVE_PWM
+    select CLKDEV_LOOKUP
+    select HAVE_CLK
    help
      Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
endchoice
diff --git a/arch/arm/mach-vt8500/Makefile b/arch/arm/mach-vt8500/Makefile
index 81aedb7..c0ae083 100644
--- a/arch/arm/mach-vt8500/Makefile
+++ b/arch/arm/mach-vt8500/Makefile
@@ -1,7 +1,7 @@
-obj-y += devices.o gpio.o irq.o timer.o
+obj-y += clock.o devices.o gpio.o irq.o timer.o
-obj-$(CONFIG_VTWM_VERSION_VT8500) += devices-vt8500.o
-obj-$(CONFIG_VTWM_VERSION_WM8505) += devices-wm8505.o
+obj-$(CONFIG_VTWM_VERSION_VT8500) += devices-vt8500.o clocks-vt8500.o
+obj-$(CONFIG_VTWM_VERSION_WM8505) += devices-wm8505.o clocks-wm8505.o
 obj-$(CONFIG_MACH_BV07) += bv07.o
obj-$(CONFIG_MACH_WM8505_7IN_NETBOOK) += wm8505_7in.o


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110227/1f18aef0/attachment-0001.html>
