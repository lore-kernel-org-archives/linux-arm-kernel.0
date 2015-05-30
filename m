From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 May 2015 16:04:41 +0000
Subject: [GIT PULL] ARM: mvebu: drivers changes for v4.2
In-Reply-To: <5569D913.4030406@free-electrons.com>
References: <5568DF81.1090300@free-electrons.com>
 <20150530141210.GE13641@io.lakedaemon.net>
 <5569D913.4030406@free-electrons.com>
Message-ID: <20150530160440.GF13641@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 30, 2015 at 05:36:51PM +0200, Gregory CLEMENT wrote:
> Hi Jason,
> 
> On 30/05/2015 16:12, Jason Cooper wrote:
> > Hey Gregory,
> > 
> > On Fri, May 29, 2015 at 11:52:01PM +0200, Gregory CLEMENT wrote:
> >> Hi,
> >>
> >> Here is the first pull request for drivers for mvebu for v4.2.
> >> It depends on the mvebu/fixes branch which have been merged in the
> >> mvebu/drivers branch
> >>
> >> Gregory
> >>
> >> The following changes since commit 885dbd154b2f2ee305cec6fd0a162e1a77ae2b06:
> >>
> >>   Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window" (2015-05-28 11:14:31 +0200)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-4.2
> >>
> >> for you to fetch changes up to bfa1ce5f38938cc9e6c7f2d1011f88eba2b9e2b2:
> >>
> >>   bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap() (2015-05-28 12:21:08 +0200)
> >>
> >> ----------------------------------------------------------------
> >> mvebu drivers change for 4.2
> >>
> >> mvebu-mbus: add mv_mbus_dram_info_nooverlap() needed for the new
> >> Marvell crypto driver
> >>
> >> ----------------------------------------------------------------
> >> Thomas Petazzoni (1):
> >>       bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap()
> >>
> >>  drivers/bus/mvebu-mbus.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/mbus.h     |   5 +++++
> >>  2 files changed, 122 insertions(+)
> >>
> > 
> > I don't see this in mvebu/for-next...  Not earth shattering, just mentioning
> > it.  This commit is adding a new function with no callers, so the chances of
> > conflicts / build failures is minimal.
> 
> Usually as soon as I apply a patch set, I also merge the branch in
> mvebu/for-next and I push it on infradead. However it is still possible
> that I forgot to push it. So I checked and this patch is part of mvebu/for-next:
> http://git.infradead.org/linux-mvebu.git/commit/bfa1ce5f38938cc9e6c7f2d1011f88eba2b9e2b2
> 
> And it was even pulled in linux-next:
> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=bfa1ce5f38938cc9e6c7f2d1011f88eba2b9e2b2
> 

Hmm, well it's academic, but here's what I get:

$ git log --graph --oneline --decorate v4.1-rc1^..remotes/mvebu/for-next
*   4c7675d00ca9 (mvebu/for-next) Merge branch 'mvebu/dt' into mvebu/for-next
|\  
| * 2d2959286017 (mvebu/mvebu/dt) ARM: mvebu: use improved armada spi device tree compatible name for each SoC
| * 16b79921e300 ARM: mvebu: dts: Add dts file for DLink DNS-327L
| * e9f3ed4ac464 ARM: mvebu: add "jedec,spi-nor" flash compatible binding
| * 943d45aafd1f ARM: kirkwood: add "jedec,spi-nor" flash compatible binding
| * 3abdd583312a ARM: mvebu: add support for the new Armada 385 based Linksys boards
| * 973ed08377f6 (tag: mvebu-dt-4.2, arm-soc/mvebu/dt) ARM: mvebu: add alias for mdio on Armada 38x
| * 1c1534d94288 ARM: dts: dove: Add Compulab SBC-A510 to Makefile
| * 896dd2728ff2 ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510
| * aa532007561e ARM: dts: dove: Remove Compulab CM-A510 from Makefile
| * 7ec7e546c0f7 ARM: dts: dove: Add internal i2c multiplexer node
* | 987dbc820618 ARM: mvebu: armada-xp-linksys-mamba: Disable internal RTC
* | 31c17ac98fc0 (tag: mvebu-fixes-4.1-2) MAINTAINERS: Add dts entries for some of the Marvell SoCs
* | ba0a1ff85376 ARM: dove: Add clock-names to CuBox Si5351 clk generator
* | ae142bd99765 ARM: mvebu: Fix the main PLL frequency on Armada 375, 38x and 39x SoCs
* | 750e30d4076a (tag: mvebu-fixes-4.1) ARM: mvebu: armada-xp-openblocks-ax3-4: Disable internal RTC
|/  
* b787f68c36d4 (tag: v4.1-rc1, hesselba/master) Linux 4.1-rc1


And after I forcibly update the remote (which a cron job *should* be doing
every night...) I get:

$ git log --graph --oneline --decorate v4.1-rc1^..remotes/mvebu/for-next
*   96a9fef8a7fa (mvebu/for-next) Merge branch 'mvebu/dt' into mvebu/for-next
|\  
| * 2d2959286017 (tag: mvebu-dt-4.2-2, mvebu/mvebu/dt) ARM: mvebu: use improved armada spi device tree compatible name for each SoC
| * 16b79921e300 ARM: mvebu: dts: Add dts file for DLink DNS-327L
| * e9f3ed4ac464 ARM: mvebu: add "jedec,spi-nor" flash compatible binding
| * 943d45aafd1f ARM: kirkwood: add "jedec,spi-nor" flash compatible binding
| * 3abdd583312a ARM: mvebu: add support for the new Armada 385 based Linksys boards
| * 973ed08377f6 (tag: mvebu-dt-4.2, arm-soc/mvebu/dt) ARM: mvebu: add alias for mdio on Armada 38x
| * 1c1534d94288 ARM: dts: dove: Add Compulab SBC-A510 to Makefile
| * 896dd2728ff2 ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510
| * aa532007561e ARM: dts: dove: Remove Compulab CM-A510 from Makefile
| * 7ec7e546c0f7 ARM: dts: dove: Add internal i2c multiplexer node
* | bfa1ce5f3893 (tag: mvebu-drivers-4.2, mvebu/mvebu/drivers) bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap()
* | 885dbd154b2f (tag: mvebu-fixes-4.1-3, mvebu/mvebu/fixes) Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window"
* | 8c9e06e64768 bus: mvebu-mbus: do not set WIN_CTRL_SYNCBARRIER on non io-coherent platforms.
* | 2ff9ab4c7b6d ARM: mvebu: armada-xp-linksys-mamba: Disable internal RTC
* | 31c17ac98fc0 (tag: mvebu-fixes-4.1-2) MAINTAINERS: Add dts entries for some of the Marvell SoCs
* | ba0a1ff85376 ARM: dove: Add clock-names to CuBox Si5351 clk generator
* | ae142bd99765 ARM: mvebu: Fix the main PLL frequency on Armada 375, 38x and 39x SoCs
* | 750e30d4076a (tag: mvebu-fixes-4.1) ARM: mvebu: armada-xp-openblocks-ax3-4: Disable internal RTC
|/  
* b787f68c36d4 (tag: v4.1-rc1, hesselba/master) Linux 4.1-rc1

So it seems my cron job isn't updating like I think it is :-/  Sorry for the
noise.

thx,

Jason.
