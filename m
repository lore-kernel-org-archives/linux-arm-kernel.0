From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 11 Aug 2012 15:31:44 +0200
Subject: [PATCH 3/5] arm: mvebu: use GPIO support now that a driver is
 available
In-Reply-To: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1344691906-15985-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-mvebu/include/mach/gpio.h |    1 +
 2 files changed, 2 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 95317a9..15b224c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -574,6 +574,7 @@ config ARCH_MVEBU
 	select IRQ_DOMAIN
 	select COMMON_CLK
 	select PINCTRL
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  Support for the Marvell SoC Family with device tree support
 
diff --git a/arch/arm/mach-mvebu/include/mach/gpio.h b/arch/arm/mach-mvebu/include/mach/gpio.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
-- 
1.7.9.5
