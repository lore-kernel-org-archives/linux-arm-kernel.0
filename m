From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Oct 2011 14:15:07 +0800
Subject: [PATCH 2/5] arm/imx: explicitly includes mach/hardware.h in
	mach-kzm_arm11_01.c
In-Reply-To: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
References: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1318832110-29289-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach-kzm_arm11_01.c references a number of things requiring the
explicit inclusion of mach/hardware.h.  Otherwise, when indirect
inclusion to mach/hardware.h gets cleaned up, we will see the following
compile error.

  CC      arch/arm/mach-imx/mach-kzm_arm11_01.o
arch/arm/mach-imx/mach-kzm_arm11_01.c:71:3: error: implicit declaration of function ?IOMEM?
arch/arm/mach-imx/mach-kzm_arm11_01.c:71:3: error: implicit declaration of function ?IMX_IO_P2V_MODULE?
arch/arm/mach-imx/mach-kzm_arm11_01.c:71:14: error: ?MX31_CS4? undeclared here (not in a function)
arch/arm/mach-imx/mach-kzm_arm11_01.c:71:14: error: ?MX31_CS5? undeclared here (not in a function)
arch/arm/mach-imx/mach-kzm_arm11_01.c:71:3: error: implicit declaration of function ?IMX_IO_P2V?

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-kzm_arm11_01.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index 4288e8f..5f37f89 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -36,6 +36,7 @@
 
 #include <mach/clock.h>
 #include <mach/common.h>
+#include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
 
 #include "devices-imx31.h"
-- 
1.7.4.1
