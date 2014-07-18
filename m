From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Jul 2014 02:20:39 +0200
Subject: [PATCH v2 4/7] ARM: Kconfig: set default gpio number for rockchip SoCs
In-Reply-To: <4868343.UFgjaXesOn@diego>
References: <4868343.UFgjaXesOn@diego>
Message-ID: <18259629.1kmfELlyGc@diego>
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
index 87b63fd..8d1dee0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1574,6 +1574,7 @@ config ARCH_NR_GPIO
 	default 416 if ARCH_SUNXI
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
+	default 288 if ARCH_ROCKCHIP
 	default 264 if MACH_H4700
 	default 0
 	help
-- 
1.9.0
