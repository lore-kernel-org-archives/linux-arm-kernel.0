From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:46:47 +0900
Subject: [PATCH 01/03] ARM: shmobile: Enable ARM_PATCH_PHYS_VIRT
In-Reply-To: <20130610094638.20803.18484.sendpatchset@w520>
References: <20130610094638.20803.18484.sendpatchset@w520>
Message-ID: <20130610094647.20803.93516.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Adjust mach-shmobile to add a select for CONFIG_ARM_PATCH_PHYS_VIRT
and at the same time remove NEED_MACH_MEMORY_H.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2013-06-05 12:01:18.000000000 +0900
@@ -634,6 +634,7 @@ config ARCH_MSM
 
 config ARCH_SHMOBILE
 	bool "Renesas SH-Mobile / R-Mobile"
+	select ARM_PATCH_PHYS_VIRT
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
@@ -643,7 +644,6 @@ config ARCH_SHMOBILE
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select MULTI_IRQ_HANDLER
-	select NEED_MACH_MEMORY_H
 	select NO_IOPORT
 	select PINCTRL if ARCH_WANT_OPTIONAL_GPIOLIB
 	select PM_GENERIC_DOMAINS if PM
