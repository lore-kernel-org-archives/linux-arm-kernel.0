From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 19:22:56 +0000
Subject: [GIT PULL v2] Renesas ARM-based SoC board updates for v3.10
In-Reply-To: <201303211718.32981.arnd@arndb.de>
References: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
 <201303211718.32981.arnd@arndb.de>
Message-ID: <201303211922.57037.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013, Arnd Bergmann wrote:
> On Tuesday 19 March 2013, Simon Horman wrote:

> Pulled into next/boards.
> 
> Please verify that I have pulled everything you sent me. If not, it my mistake.

With everything applied, I now get one build failure and a new build warning:

==> build/mackerel_defconfig/faillog <==
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c: In function 'mackerel_init':
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1476:15: error: 'GPIO_FN_MMCD0_0' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1476:15: note: each undeclared identifier is reported only once for each function it appears in
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1477:15: error: 'GPIO_FN_MMCD0_1' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1478:15: error: 'GPIO_FN_MMCD0_2' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1479:15: error: 'GPIO_FN_MMCD0_3' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1480:15: error: 'GPIO_FN_MMCD0_4' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1481:15: error: 'GPIO_FN_MMCD0_5' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1482:15: error: 'GPIO_FN_MMCD0_6' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1483:15: error: 'GPIO_FN_MMCD0_7' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1484:15: error: 'GPIO_FN_MMCCMD0' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1485:15: error: 'GPIO_FN_MMCCLK0' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1489:15: error: 'GPIO_FN_SDHICMD2' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1490:15: error: 'GPIO_FN_SDHICLK2' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1491:15: error: 'GPIO_FN_SDHID2_3' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1492:15: error: 'GPIO_FN_SDHID2_2' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1493:15: error: 'GPIO_FN_SDHID2_1' undeclared (first use in this function)
/git/arm-soc/arch/arm/mach-shmobile/board-mackerel.c:1494:15: error: 'GPIO_FN_SDHID2_0' undeclared (first use in this function)
make[3]: *** [arch/arm/mach-shmobile/board-mackerel.o] Error 1
make[3]: Target `__build' not remade because of errors.
make[2]: *** [arch/arm/mach-shmobile] Error 2
make[2]: Target `_all' not remade because of errors.
make[1]: *** [sub-make] Error 2
make[1]: Target `_all' not remade because of errors.

==> build/marzen_defconfig/faillog <==
In file included from /git/arm-soc/arch/arm/mach-shmobile/setup-r8a7779.c:24:0:
/git/arm-soc/include/linux/of_platform.h:107:13: warning: 'struct of_device_id' declared inside parameter list [enabled by default]
/git/arm-soc/include/linux/of_platform.h:107:13: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
/git/arm-soc/include/linux/of_platform.h:107:13: warning: 'struct device_node' declared inside parameter list [enabled by default]


I have not tried bisecting the problems. Could you find out what is going on
and send bug fixes to apply on top?

	Arnd
