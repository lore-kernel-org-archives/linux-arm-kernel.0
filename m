From: gclement00@gmail.com (Gregory CLEMENT)
Date: Fri, 30 Nov 2012 08:27:23 +0100
Subject: [GIT PULL 5/5] ARM: mvebu: changes for v3.8
In-Reply-To: <20121126091652.GA13866@quad.lixom.net>
References: <50b056f7.8687e50a.170d.7c22SMTPIN_ADDED_MISSING@mx.google.com>
 <20121126091652.GA13866@quad.lixom.net>
Message-ID: <CADx9zJA-RsOtMvbeXVy-s-XAzRk3R2WJJYWNBA=tyosdvwa7vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/26 Olof Johansson <olof@lixom.net>:
> Hi,
>
> On Sat, Nov 24, 2012 at 05:11:14AM +0000, Jason Cooper wrote:
>> The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:
>>
>>   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.infradead.org/users/jcooper/linux.git tags/mvebu_everything_for_3.8
>>
>> for you to fetch changes up to 56580bb422e5f542da19c057f348dd39634138e7:
>>
>>   Merge branch 'mvebu-misc-fixes' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything (2012-11-24 04:08:49 +0000)
>>
>> ----------------------------------------------------------------
>>
>> mvebu everything for v3.8
>>  - due to the complex interdependencies of the received pull requests
>>    I decided to keep this in one branch the way they recommended merging it
>>  - this was their first attempt at doing pull requests, we'll work on it
>>    with them
>>
>>  - added SMP support for mvebu SoCs
>>  - added coherency fabric
>>  - added mdio and mvneta drivers
>>  - added mirabox board
>>  - added openblocks ax3-4 board
>>  - clock fixes and improvements
>>  - converted mv_xor driver to devicetree (extensive series in itself)
>>
>> merge conflicts with orion/*
>>  - arch/arm/mach-kirkwood/Kconfig
>>     - select everything
>>  - arch/arm/mach-kirkwood/board-dt.c
>>     - remove AUXDATA
>>     - keep all of_machine_is_compatible()
>>     - use of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL)
>>
>> ----------------------------------------------------------------
>> Andrew Lunn (3):
>>       ARM: Kirkwood: switch to DT clock providers
>>       dma: mv_xor: Add a device_control function
>>       arm: kirkwood: Convert XOR instantiation to DT.
>>
>> Gregory CLEMENT (17):
>>       arm: mvebu: support for the Globalscale Mirabox board
>>       clk: mvebu: add armada-370-xp CPU specific clocks
>>       clk: mvebu: armada 370/XP add clock gating control provider for DT
>>       clk: armada-370-xp: add support for clock framework
>>       clocksource: convert time-armada-370-xp to clk framework
>>       arm: mvebu: increase atomic coherent pool size for armada 370/XP
>>       arm: mvebu: SATA support: SoC-level DT data for Armada 370/XP
>>       arm: mvebu: SATA support: mvebu_defconfig update
>>       arm: mvebu: SATA support: board-level DT data for Armada 370/XP boards
>>       arm: mvebu: Add support for coherency fabric in mach-mvebu
>>       arm: mvebu: Add initial support for power managmement service unit
>>       arm: mvebu: Add IPI support via doorbells
>>       arm: mm: Add support for PJ4B cpu and init routines
>>       arm: mvebu: Add SMP support for Armada XP
>>       arm: dma mapping: Export a dma ops function arm_dma_set_mask
>>       arm: plat-orion: Add coherency attribute when setup mbus target
>>       arm: mvebu: Add hardware I/O Coherency support
>>
>> Jason Cooper (14):
>>       Merge tag 'marvell-mvebu-clk-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-sata-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-neta-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-boards-net-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-net-mdio-checkpatch-fixes-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-mvneta-fix-and-clk-support-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-neta-dt-clk-updates-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-xor-cleanup-dt-binding-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-xor-board-dt-changes-3.8-v2' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-net-xor-defconfig-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-armadaxp-smp-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-hwiocc-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge tag 'marvell-openblocks-i2c-sata-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>>       Merge branch 'mvebu-misc-fixes' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>
> Based on these merge commits, it looks like they organized things pretty well.
> With this amount of code, if you want to mostly expose this to us coming
> up to our level, that's fine.
>
> Looking at the actual tree (in gitk to get visalization), it looks like
> things held up well until the "test-the-merge" mergepoint which had some
> patches on top of it instead of in a separate branch, I think? Those
> merges are these:
>
>> Thomas Petazzoni (74):
>>       Merge tag 'marvell-mvebu-clk-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-sata-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-neta-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-boards-net-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
> [..]
>>       Merge tag 'marvell-mvebu-clk-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-sata-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-neta-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-boards-net-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-net-mdio-checkpatch-fixes-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-mvneta-fix-and-clk-support-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-neta-dt-clk-updates-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-xor-cleanup-dt-binding-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-xor-board-dt-changes-3.8-v2' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>>       Merge tag 'marvell-net-xor-defconfig-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge
>
>
> I'll take a closer look at the rest tomorrow, it's getting a bit late here and
> I have to call it a day.
>

Hello,
Olof, Arnd,
what is the current status of this pull?

If you had encountered any issues, don't hesitate to let me know.
If I can help on any points I will.

Thanks,

-- 
Gregory CLEMENT
