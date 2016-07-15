From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 15 Jul 2016 11:25:20 +0200
Subject: [PATCH 7/7] ARM: dts: at91: Don't build unnecessary dtbs
In-Reply-To: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1468574720-24296-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Building both ARMv4 and ARMv5 dtbs when SOC_SAM_V4_V5 is an issue for
kernelci because it will then attempt to boot ARMv4 kernels on at91sam9
which doesn't work.

Use CONFIG_SOC_AT91RM9200 and CONFIG_SOC_AT91SAM9 instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fbd7de633788..e900dad597c6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -7,9 +7,10 @@ dtb-$(CONFIG_MACH_ARTPEC6) += \
 dtb-$(CONFIG_MACH_ASM9260) += \
 	alphascale-asm9260-devkit.dtb
 # Keep at91 dtb files sorted alphabetically for each SoC
-dtb-$(CONFIG_SOC_SAM_V4_V5) += \
+dtb-$(CONFIG_SOC_AT91RM9200) += \
 	at91rm9200ek.dtb \
-	mpa1600.dtb \
+	mpa1600.dtb
+dtb-$(CONFIG_SOC_AT91SAM9) += \
 	animeo_ip.dtb \
 	at91-qil_a9260.dtb \
 	aks-cdu.dtb \
-- 
2.8.1
