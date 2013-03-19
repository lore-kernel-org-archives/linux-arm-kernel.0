From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Mar 2013 11:17:57 +0900
Subject: [PATCH 09/13] ARM: shmobile: simplify kzm9g Kconfig dependencies
In-Reply-To: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
References: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363659481-5922-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Reference kernel configurations for armadillo800eva and kzm9g boards do not
have to depend on their respective "legacy" configurations, doing device
instantiation in .c, they can be configured and built independently.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
[horms+renesas at verge.net.au: created separate patch for kzm9g portion]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0c48af9..ab2bb71 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -131,7 +131,11 @@ config MACH_KZM9G
 
 config MACH_KZM9G_REFERENCE
 	bool "KZM-A9-GT board - Reference Device Tree Implementation"
-	depends on MACH_KZM9G
+	depends on ARCH_SH73A0
+	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select USE_OF
 	---help---
 	   Use reference implementation of KZM-A9-GT board support
 	   which makes as greater use of device tree at the expense
-- 
1.7.10.4
