From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 13 Oct 2014 08:31:48 +0200
Subject: [PATCH v5 01/10] ARM: add mach-asm9260
In-Reply-To: <CAL_JsqLuSPC3napmZDpOTNhWy-Vzw8=g76QRwcjTckrReVQczA@mail.gmail.com>
References: <CAL_JsqLuSPC3napmZDpOTNhWy-Vzw8=g76QRwcjTckrReVQczA@mail.gmail.com>
Message-ID: <1413181908-14937-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

it is low cost (?) SoC targeted for market in China and India which
trying to compete with AT91SAM9G25.

Here is some info:
http://www.alphascale.com/index.asp?ics/615.html

One of products:
http://www.aliexpress.com/store/product/2014-hot-sales-FREE-SHIPPING-new-Purple-core-ARM9-development-board-ASM9260T-SDRAM-power-line/433637_1931495721.html

In some cases this SoC looks similar to iMX23/iMX28. But currently it makes no
sense to merge mach code of this devices. Especially because most differences
are already collected mach-mxs folder.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/Kconfig              | 2 ++
 arch/arm/mach-asm9260/Kconfig | 8 ++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/arm/mach-asm9260/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5918d40..87373da 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -968,6 +968,8 @@ source "arch/arm/mach-w90x900/Kconfig"
 
 source "arch/arm/mach-zynq/Kconfig"
 
+source "arch/arm/mach-asm9260/Kconfig"
+
 # Definitions to make life easier
 config ARCH_ACORN
 	bool
diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
new file mode 100644
index 0000000..eef90d9
--- /dev/null
+++ b/arch/arm/mach-asm9260/Kconfig
@@ -0,0 +1,8 @@
+config MACH_ASM9260
+	bool "Alphascale ASM9260"
+	depends on ARCH_MULTI_V5
+	select IRQ_MXS
+	select ASM9260_TIMER
+	select CPU_ARM926T
+	help
+	  Support for Alpascale ASM9260 based platform.
-- 
1.9.1
