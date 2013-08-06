From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 6 Aug 2013 13:06:12 -0400
Subject: [PATCH 0/5] ARM: dove: switch to DT MBus
In-Reply-To: <1375101114-28858-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1375101114-28858-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130806170612.GW19280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 02:31:49PM +0200, Sebastian Hesselbarth wrote:
> This patch set converts DT based Dove boards to DT probed MBus to be
> introduced with v3.12.
> 
> The first two patches prepare Dove DT nodes for MBus ID remapping by using
> preprocessor includes and adding the MBUS_ID macro. The third patch adds a
> MBus DT node to Dove SoC dtsi with required ranges for internal MBus and
> AXI registers, and PCIe mem and I/O apertures. The forth patch relocates
> the nodes for the internal devices to the new MBus node. Also, internal-regs
> ranges are updated to allow proper translation of MBus children's reg
> properties. Finally, legacy MBus init is replaced by DT based MBus init
> for DT based Dove.
> 
> The patch set depends on the MBus device tree patches that should appear
> in v3.12. Currently, it is based on v3.11-rc2 with Dove DT cleanup patches
> and MBus patch set v8 applied.

Grrr.  It also depends on the mv643xx_eth and irqchip/clocksource
changes.  I caught it, so no big deal.  In the future, please try to
make each series stand alone unless absolutely necessary.

> The patch set is _not_ sent to devicetree mainling list, because the MBus
> binding will be discussed there on the MBus patches itself.
> 
> Sebastian Hesselbarth (5):
>   ARM: dove: use preprocessor on device tree files
>   ARM: dove: add MBUS_ID macro to Dove DT
>   ARM: dove: add MBus DT node
>   ARM: dove: relocate internal registers device nodes
>   ARM: dove: switch to DT probed mbus address windows
> 
>  arch/arm/boot/dts/dove-cm-a510.dts |    2 +-
>  arch/arm/boot/dts/dove-cubox.dts   |    2 +-
>  arch/arm/boot/dts/dove-d2plug.dts  |    2 +-
>  arch/arm/boot/dts/dove-dove-db.dts |    2 +-
>  arch/arm/boot/dts/dove.dtsi        |  958 ++++++++++++++++++------------------
>  arch/arm/mach-dove/board-dt.c      |   10 +-
>  6 files changed, 491 insertions(+), 485 deletions(-)

whole series applied to mvebu/dove_mbus with dependencies on
mvebu/dove_dt, mvebu/mbus_dt, and mvebu/boards.  I may redo this to
merge mvebu/dove_dt back into mvebu/boards.  I haven't decided yet.

thx,

Jason.
