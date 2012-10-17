From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Oct 2012 11:39:25 -0400
Subject: [PATCH V3 0/3]  Add clock framework for armada 370/XP
In-Reply-To: <1350303499-30868-1-git-send-email-gregory.clement@free-electrons.com>
References: <1350303499-30868-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121017153925.GR20922@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

On Mon, Oct 15, 2012 at 02:18:16PM +0200, Gregory CLEMENT wrote:
> Hello Mike,
> 
> The v3.7-rc1 was released yesterday. So here it is the updated version
> of my patch set. The rebase was flawless. An I have just fixed a typo
> in the device tree and warnings from checkpatch. I built and test it
> for the Armada 370 and Armada XP evaluation board.
> 
> The purpose of this patch set is to add support for clock framework
> for Armada 370 and Armada XP SoCs. All the support is done under the
> directory drivers/clk/mvebu/ as the support for other mvebu SoCs was
> in mind during the writing of the code.
> 
> Two kinds of clocks are added:
> 
> - The CPU clocks are only for Armada XP (which is multi-core)
> 
> - The core clocks are clocks which have their rate fixed during
>   reset.
> 
> Many thanks to Thomas Petazzoni and Sebastian Hesselbarth for their
> review and feedback. The device tree bindings were really improved
> with the advices of Sebastian.
> 
> Changelog:
> V2 -> V3:
> - Rebased on top of v3.7-rc1
> - Fixed a typo in device trees
> - Fixed warning from checkpatch
> 
> V1 -> V2:
> 
> - Improved the spelling and the wording of the documentation and the
>   1st commit log
> - Removed the "end_of_list" name which are unused here.
> - Fix the cpu clock by using of_clk_src_onecell_get in the same way it
>   was used for the core clocks
> 
> Regards,
> 
> 
> Gregory CLEMENT (3):
>   clk: mvebu: add armada-370-xp specific clocks
>   clk: armada-370-xp: add support for clock framework
>   clocksource: time-armada-370-xp converted to clk framework
> 
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |   40 +++
>  .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   21 ++
>  arch/arm/boot/dts/armada-370-db.dts                |    4 -
>  arch/arm/boot/dts/armada-370-xp.dtsi               |    1 +
>  arch/arm/boot/dts/armada-370.dtsi                  |   12 +
>  arch/arm/boot/dts/armada-xp.dtsi                   |   48 +++
>  arch/arm/mach-mvebu/Kconfig                        |    5 +
>  arch/arm/mach-mvebu/armada-370-xp.c                |    8 +-
>  arch/arm/mach-mvebu/common.h                       |    1 +
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/mvebu/Makefile                         |    2 +
>  drivers/clk/mvebu/clk-core.c                       |  312 ++++++++++++++++++++
>  drivers/clk/mvebu/clk-core.h                       |   19 ++
>  drivers/clk/mvebu/clk-cpu.c                        |  155 ++++++++++
>  drivers/clk/mvebu/clk-cpu.h                        |   19 ++
>  drivers/clk/mvebu/clk.c                            |   36 +++
>  drivers/clocksource/time-armada-370-xp.c           |   11 +-
>  17 files changed, 685 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
>  create mode 100644 drivers/clk/mvebu/Makefile
>  create mode 100644 drivers/clk/mvebu/clk-core.c
>  create mode 100644 drivers/clk/mvebu/clk-core.h
>  create mode 100644 drivers/clk/mvebu/clk-cpu.c
>  create mode 100644 drivers/clk/mvebu/clk-cpu.h
>  create mode 100644 drivers/clk/mvebu/clk.c

Would it be okay if we took this through the mvebu tree?  It looks like
the only potential merge conflict we would have would be in
drivers/clk/Makefile.  It would make dependency tracking easier.

Otherwise is fine as well, just let me know which you prefer.

Assuming, of course, everything looks good to you.

thx,

Jason.
