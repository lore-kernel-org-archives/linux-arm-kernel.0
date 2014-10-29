From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:58:39 +0900
Subject: [PATCH] ARM: shmobile: Remove ARCH_HAS_OPP completely
In-Reply-To: <cover.1414557793.git.horms+renesas@verge.net.au>
References: <cover.1414557793.git.horms+renesas@verge.net.au>
Message-ID: <383d3f3e979bfbace3101dacb21387806b44e847.1414557793.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Bolle <pebolle@tiscali.nl>

The Kconfig symbol ARCH_HAS_OPP became redundant in v3.16: commit
049d595a4db3 ("PM / OPP: Make OPP invisible to users in Kconfig")
removed the only dependency that used it. Setting it had no effect
anymore.

So commit 78c5e0bb145d ("PM / OPP: Remove ARCH_HAS_OPP") removed it. For
some reason that commit did not remove all select statements for that
symbol. These statements are now useless. Remove one from shmobile too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 21f457b..f59019d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -36,7 +36,6 @@ menuconfig ARCH_SHMOBILE_MULTI
 	select NO_IOPORT_MAP
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_OPP
 
 if ARCH_SHMOBILE_MULTI
 
-- 
2.1.1
