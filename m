From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 05 Mar 2013 21:17:17 +0100
Subject: [PATCH v2] ARM: dove: drop "select COMMON_CLK_DOVE"
In-Reply-To: <51363A9E.6090507@gmail.com>
References: <1362476098.16460.65.camel@x61.thuisdomein>
 <51363A9E.6090507@gmail.com>
Message-ID: <1362514637.16460.117.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5b03df9ace680d7cdd34a69dfd85ca5f74159d18 ("ARM: dove: switch to
DT clock providers") added "select COMMON_CLK_DOVE" to Marvell Dove's
Kconfig entry. But there's no Kconfig symbol COMMON_CLK_DOVE, which
makes this select statement a nop. It's probably a leftover of some
experimental code that never hit mainline. Drop it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) v2: Sebastian suggested to drop this select entirely.

1) Still untested.

 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..0c990b7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -556,7 +556,6 @@ config ARCH_IXP4XX
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLK_DOVE
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
-- 
1.7.11.7
