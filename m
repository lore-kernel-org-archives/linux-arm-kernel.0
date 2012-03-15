From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 20:36:35 +0000
Subject: [GIT PULL v2] DaVinci DM644x video display support
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6317F13DB@DBDE01.ent.ti.com>
References: <DF0F476B391FA8409C78302C7BA518B6317F13DB@DBDE01.ent.ti.com>
Message-ID: <201203152036.36133.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 March 2012, Nori, Sekhar wrote:
> Hi Arnd, Olof,
> 
> Can you please pull these two patches adding support
> for DaVinci DM644x V4L2 display support for v3.4.
> 
> These patches heavily depend on the clean-up series sent
> earlier. I have re-generated the pull request against
> v3.4/cleanup branch of my tree (already pulled earlier
> and unchanged since) as suggested by Olof.
> 
> Let me know if this works for you.

Looks good, applied to the next/drivers branch now.
Sorry for missing the pull request earlier, that was my fault
and I should have pulled it already.

I got a small merge conflict, see the resolution below.

	Arnd

commit e594a97c8c74533ec105b2ac9194217e918f172f
Merge: f66f9bd d5be5f5
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Mar 15 20:33:47 2012 +0000

    Merge branch 'v3.4/features' of git://gitorious.org/linux-davinci/linux-davinci into next/drivers
    
    * 'v3.4/features' of git://gitorious.org/linux-davinci/linux-davinci:
      ARM: davinci: dm644x evm: add support for VPBE display
      ARM: davinci: dm644x: add support for v4l2 video display
    
    * included from the davinci/cleanup branch:
      ARM: davinci: dm644x: don't force vpfe registeration on all boards
      ARM: davinci: dm644x: fix inconsistent variable naming
      ARM: davinci: dm644x: improve readability using macro
      ARM: davinci: streamline sysmod access
      ARM: davinci: create new common platform header for davinci
      ARM: davinci: dm646x: move private definitions to C file
      ARM: davinci: dm365: move private definitions to C file
      ARM: davinci: dm644x: move private definitions to C file
    
    Conflicts:
    	arch/arm/mach-davinci/board-dm644x-evm.c
    	arch/arm/mach-davinci/board-neuros-osd2.c
    	arch/arm/mach-davinci/board-sffsdr.c
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --cc arch/arm/mach-davinci/board-dm644x-evm.c
index 1247ecd,3854235..3683306
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@@ -40,7 -39,9 +39,9 @@@
  #include <mach/usb.h>
  #include <mach/aemif.h>
  
+ #include "davinci.h"
+ 
 -#define DM644X_EVM_PHY_ID		"0:01"
 +#define DM644X_EVM_PHY_ID		"davinci_mdio-0:01"
  #define LXT971_PHY_ID	(0x001378e2)
  #define LXT971_PHY_MASK	(0xfffffff0)
  
diff --cc arch/arm/mach-davinci/board-neuros-osd2.c
index 8d34f51,3d12a3a..a772bb4
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@@ -39,7 -38,9 +38,9 @@@
  #include <mach/mmc.h>
  #include <mach/usb.h>
  
+ #include "davinci.h"
+ 
 -#define NEUROS_OSD2_PHY_ID		"0:01"
 +#define NEUROS_OSD2_PHY_ID		"davinci_mdio-0:01"
  #define LXT971_PHY_ID			0x001378e2
  #define LXT971_PHY_MASK			0xfffffff0
  
diff --cc arch/arm/mach-davinci/board-sffsdr.c
index 31da3c5,897cec5..76e67509
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@@ -42,7 -41,9 +41,9 @@@
  #include <mach/mux.h>
  #include <mach/usb.h>
  
+ #include "davinci.h"
+ 
 -#define SFFSDR_PHY_ID		"0:01"
 +#define SFFSDR_PHY_ID		"davinci_mdio-0:01"
  static struct mtd_partition davinci_sffsdr_nandflash_partition[] = {
  	/* U-Boot Environment: Block 0
  	 * UBL:                Block 1
