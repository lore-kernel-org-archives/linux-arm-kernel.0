From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 23 Feb 2014 16:22:43 -0800
Subject: [GIT PULL] clk: mvebu driver changes for v3.15
In-Reply-To: <20140222054513.GW7862@titan.lakedaemon.net>
References: <20140222054513.GW7862@titan.lakedaemon.net>
Message-ID: <20140224002243.22529.6866@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jason Cooper (2014-02-21 21:45:13)
> Mike,
> 
> Here's some driver changes/additions for the v3.15 window.  Marvell,
> through free-electrons, is adding support for their new line of SoCs.
> The Armada 375, 380, and the 385.
> 
> This pull request adds support for the corediv, core, and gating
> clocks.
> 
> These changes have been in -next for several days.  Please pull.

Taken into clk-next.

Thanks!
Mike

> 
> thx,
> 
> Jason.
> 
> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/clk-mvebu-3xx-3.15
> 
> for you to fetch changes up to e9646fe1169de0162d461472df7ed19e0c729b61:
> 
>   dt: Update binding information for mvebu gating clocks with Armada 380/385 (2014-02-17 02:34:08 +0000)
> 
> ----------------------------------------------------------------
> clock: mvebu new SoC changes for v3.15
> 
>  - mvebu (Armada 375/380/385)
>     - extend corediv clock driver to support new SoCs
>     - add core and gating clock drivers for new SoCs
> 
> ----------------------------------------------------------------
> Gregory CLEMENT (4):
>       clk: mvebu: add clock support for Armada 375
>       dt: Update binding information for mvebu core clocks with Armada 375
>       dt: Update binding information for mvebu gating clocks with Armada 375
>       clk: mvebu: add clock support for Armada 380/385
> 
> Thomas Petazzoni (6):
>       clk: mvebu: do not copy the contents of clk_corediv_desc
>       clk: mvebu: add a little bit of documentation about data structures
>       clk: mvebu: refactor corediv driver to support more SoC
>       clk: mvebu: add Armada 375 support to the corediv clock driver
>       dt: Update binding information for mvebu core clocks with Armada 380/385
>       dt: Update binding information for mvebu gating clocks with Armada 380/385
> 
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |  14 ++
>  .../bindings/clock/mvebu-gated-clock.txt           |  65 +++++++-
>  drivers/clk/mvebu/Kconfig                          |   8 +
>  drivers/clk/mvebu/Makefile                         |   2 +
>  drivers/clk/mvebu/armada-375.c                     | 184 +++++++++++++++++++++
>  drivers/clk/mvebu/armada-38x.c                     | 167 +++++++++++++++++++
>  drivers/clk/mvebu/clk-corediv.c                    | 131 +++++++++++----
>  7 files changed, 536 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/clk/mvebu/armada-375.c
>  create mode 100644 drivers/clk/mvebu/armada-38x.c
