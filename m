From: gclement00@gmail.com (Gregory CLEMENT)
Date: Tue, 27 Nov 2012 16:01:58 +0100
Subject: [GIT PULL 5/5] ARM: mvebu: changes for v3.8
In-Reply-To: <E1Tc82J-0001T0-7f@merlin.infradead.org>
References: <E1Tc82J-0001T0-7f@merlin.infradead.org>
Message-ID: <CADx9zJDCvHwKRQF77UJ8O==LOsyTb=dW7b4N3Wzu+Z6=k5oh+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/24 Jason Cooper <jason@lakedaemon.net>:
> The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:
>
>   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
>
> are available in the git repository at:
>
>   git://git.infradead.org/users/jcooper/linux.git tags/mvebu_everything_for_3.8
>
> for you to fetch changes up to 56580bb422e5f542da19c057f348dd39634138e7:
>
>   Merge branch 'mvebu-misc-fixes' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything (2012-11-24 04:08:49 +0000)
>
> ----------------------------------------------------------------
>
> mvebu everything for v3.8
>  - due to the complex interdependencies of the received pull requests
>    I decided to keep this in one branch the way they recommended merging it
>  - this was their first attempt at doing pull requests, we'll work on it
>    with them
>
>  - added SMP support for mvebu SoCs
>  - added coherency fabric
>  - added mdio and mvneta drivers
>  - added mirabox board
>  - added openblocks ax3-4 board
>  - clock fixes and improvements
>  - converted mv_xor driver to devicetree (extensive series in itself)
>
> merge conflicts with orion/*
>  - arch/arm/mach-kirkwood/Kconfig
>     - select everything
>  - arch/arm/mach-kirkwood/board-dt.c
>     - remove AUXDATA
>     - keep all of_machine_is_compatible()
>     - use of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL)
>
> ----------------------------------------------------------------
> Andrew Lunn (3):
>       ARM: Kirkwood: switch to DT clock providers
>       dma: mv_xor: Add a device_control function
>       arm: kirkwood: Convert XOR instantiation to DT.
>
> Gregory CLEMENT (17):
>       arm: mvebu: support for the Globalscale Mirabox board
>       clk: mvebu: add armada-370-xp CPU specific clocks
>       clk: mvebu: armada 370/XP add clock gating control provider for DT
>       clk: armada-370-xp: add support for clock framework
>       clocksource: convert time-armada-370-xp to clk framework
>       arm: mvebu: increase atomic coherent pool size for armada 370/XP
>       arm: mvebu: SATA support: SoC-level DT data for Armada 370/XP
>       arm: mvebu: SATA support: mvebu_defconfig update
>       arm: mvebu: SATA support: board-level DT data for Armada 370/XP boards
>       arm: mvebu: Add support for coherency fabric in mach-mvebu
>       arm: mvebu: Add initial support for power managmement service unit
>       arm: mvebu: Add IPI support via doorbells
>       arm: mm: Add support for PJ4B cpu and init routines
>       arm: mvebu: Add SMP support for Armada XP
>       arm: dma mapping: Export a dma ops function arm_dma_set_mask
>       arm: plat-orion: Add coherency attribute when setup mbus target
>       arm: mvebu: Add hardware I/O Coherency support

Hello Jason,

I have just realized that you seems to have forgot to add the 3
patches related to
L2 cache support. It is strange because it was part of you branch mvebu/boards.

Did I miss something?

Thanks,
-- 
Gregory CLEMENT
