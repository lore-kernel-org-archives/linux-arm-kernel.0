From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 9 Sep 2012 22:41:50 -0400
Subject: [PATCH v3 0/6] ARM: dove: DT support for Marvell Dove
In-Reply-To: <1345050455-32643-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344681326-17946-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345050455-32643-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20120910024149.GU4575@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 07:07:29PM +0200, Sebastian Hesselbarth wrote:
> This patch set adds DT support for Marvell Dove SoC and three boards
> equipped with this SoC. The work is based on device tree support for
> Marvell Orion based SoCs introduced in 3.6-rc1.
> 
> The first three patches move mach-dove closer to Marvell Kirkwood's
> setup code by unifying the clock setup routines, adding clock gating
> control, and support for Marvell's crypto engine to mach-dove.
> 
> Patches 4 and 5 add a generic DT machine descriptor to mach-dove and
> corresponding DT descriptors for the SoC and already supported boards.
> 
> Finally, the last patch adds a DT descriptor for the SolidRun CuBox,
> a plug computer based on Marvell Dove.
> 
> This patch set relies on a DT support patch for sdhci-dove that has
> been accepted on mmc-next for 3.7 as commit
> b2293055c1e1200acbb46523976852d1686fdfa4.
> 
> Changes:
> v2: removed clk_prepare_enable for tclk and updated subsequent patches
> v3: fixed a typo in clk_gate name for pex0
>     removed device name macros from clk gate names
> 
> Sebastian Hesselbarth (6):
>   ARM: dove: unify clock setup
>   ARM: dove: add clock gating control
>   ARM: dove: add crypto engine
>   ARM: dove: add device tree based machine descriptor
>   ARM: dove: add device tree descriptors
>   ARM: dove: SolidRun CuBox DT
> 
>  arch/arm/boot/dts/dove-cm-a510.dts   |   38 +++++++++
>  arch/arm/boot/dts/dove-cubox.dts     |   42 +++++++++
>  arch/arm/boot/dts/dove-dove-db.dts   |   38 +++++++++
>  arch/arm/boot/dts/dove.dtsi          |  143 +++++++++++++++++++++++++++++++
>  arch/arm/mach-dove/Kconfig           |    7 ++
>  arch/arm/mach-dove/Makefile.boot     |    4 +
>  arch/arm/mach-dove/common.c          |  156 +++++++++++++++++++++++++++++++---
>  arch/arm/mach-dove/include/mach/pm.h |   54 ++++++++----
>  8 files changed, 452 insertions(+), 30 deletions(-)
>  create mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
>  create mode 100644 arch/arm/boot/dts/dove-cubox.dts
>  create mode 100644 arch/arm/boot/dts/dove-dove-db.dts
>  create mode 100644 arch/arm/boot/dts/dove.dtsi
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Whole series applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/boards

thx,

Jason.
