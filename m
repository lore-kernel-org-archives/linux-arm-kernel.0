From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 15 Apr 2014 10:07:24 +0200
Subject: [PATCH 1/2] ARM: berlin: add the LIBGPIO as a dependency for the BG2Q
In-Reply-To: <1397549245-3338-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397549245-3338-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1397549245-3338-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q has GPIOs driven by the dwapb GPIO driver. Add the LIBGPIO as a
dependency to be able to support them.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 291f1cac6c3d..c31968712095 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -28,6 +28,7 @@ config MACH_BERLIN_BG2Q
 	select CPU_V7
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
+	select ARCH_REQUIRE_GPIOLIB
 
 endmenu
 
-- 
1.8.3.2
