From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 25 Jul 2014 23:49:36 +0200
Subject: [PATCH v3 4/8] ARM: Kconfig: set default gpio number for rockchip SoCs
In-Reply-To: <1406324980-2450-1-git-send-email-heiko@sntech.de>
References: <1406324980-2450-1-git-send-email-heiko@sntech.de>
Message-ID: <1406324980-2450-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new rk3288 needs a bigger gpio space, as it has 9 gpio banks.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
Tested-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 245058b..b3ba139 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1558,6 +1558,7 @@ config ARCH_NR_GPIO
 	default 416 if ARCH_SUNXI
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
+	default 288 if ARCH_ROCKCHIP
 	default 264 if MACH_H4700
 	default 0
 	help
-- 
1.9.0
