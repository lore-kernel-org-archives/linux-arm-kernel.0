From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Feb 2017 22:24:19 +0100
Subject: [PATCH] [net-next] ARM: orion: remove unused wnr854t_switch_plat_data
Message-ID: <20170208212431.2924390-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The other instances of this structure got removed along with the MDIO
device change, but this one was left behind and needs to be removed
as well:

arch/arm/mach-orion5x/wnr854t-setup.c:109:44: error: 'wnr854t_switch_plat_data' defined but not used [-Werror=unused-variable]
 static struct dsa_platform_data __initdata wnr854t_switch_plat_data = {

Fixes: 575e93f7b5e6 ("ARM: orion: Register DSA switch as a MDIO device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-orion5x/wnr854t-setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index ac3376fc269f..d162d4c7f85d 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -106,11 +106,6 @@ static struct dsa_chip_data wnr854t_switch_chip_data = {
 	.port_names[7] = "lan2",
 };
 
-static struct dsa_platform_data __initdata wnr854t_switch_plat_data = {
-	.nr_chips	= 1,
-	.chip		= &wnr854t_switch_chip_data,
-};
-
 static void __init wnr854t_init(void)
 {
 	/*
-- 
2.9.0
