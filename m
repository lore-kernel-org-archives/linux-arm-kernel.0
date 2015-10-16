From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Oct 2015 23:09:44 +0800
Subject: [GIT PULL] i.MX clock updates for 4.4
Message-ID: <20151016150944.GG584@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please consider to pull the following i.MX clock updates for 4.4.  And
please keep it stable, as we will merge it into i.MX DT branch as a
dependency.  Thanks.

Shawn

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-4.4

for you to fetch changes up to 84a87250ee4e4f7cf5865be9757e2ea758e5cae3:

  clk: imx6: Add SPDIF_GCLK clock in clock tree (2015-10-12 21:55:59 +0800)

----------------------------------------------------------------
The i.MX clock updates for 4.4:
 - A couple of fixes on i.MX31 and i.MX35 clock initialization functions
   which makes mxc_timer_init() currently be called twice for DT boot.
 - Increase i.MX6UL AXI bus clock rate to 264MHz which is the optimal
   design target.
 - Add a few missing clocks, ADC clock for i.MX7D, OCOTP clock for
   Vybrid, and SPDIF_GCLK for i.MX6.
 - A series from Lucas to fix early debug UART clock setup.  This is
   currently a one-off fix for i.MX platform, and can be extended to
   become a generic solution later.

----------------------------------------------------------------
Alexander Stein (2):
      clk: imx35: Do not call mxc_timer_init twice when booting with DT
      clk: imx31: Do not call mxc_timer_init twice when booting with DT

Anson Huang (1):
      clk: imx: increase AXI clock rate to 264MHz for i.MX6UL

Haibo Chen (1):
      clk: imx7d: add ADC root clock

Lucas Stach (8):
      clk: imx: add common logic to detect early UART usage
      clk: imx25: retain early UART clocks during kernel init
      clk: imx27: retain early UART clocks during kernel init
      clk: imx31: retain early UART clocks during kernel init
      clk: imx35: retain early UART clocks during kernel init
      clk: imx5: retain early UART clocks during kernel init
      clk: imx6: retain early UART clocks during kernel init
      clk: imx7d: retain early UART clocks during kernel init

Sanchayan Maity (1):
      clk: clk-vf610: Add clock for Vybrid OCOTP controller

Shengjiu Wang (1):
      clk: imx6: Add SPDIF_GCLK clock in clock tree

 drivers/clk/imx/clk-imx25.c               | 12 +++++++
 drivers/clk/imx/clk-imx27.c               | 13 +++++++
 drivers/clk/imx/clk-imx31.c               | 35 ++++++++++++++----
 drivers/clk/imx/clk-imx35.c               | 59 +++++++++++++++++++------------
 drivers/clk/imx/clk-imx51-imx53.c         | 16 +++++++++
 drivers/clk/imx/clk-imx6q.c               | 12 ++++++-
 drivers/clk/imx/clk-imx6sl.c              | 12 ++++++-
 drivers/clk/imx/clk-imx6sx.c              |  9 +++++
 drivers/clk/imx/clk-imx6ul.c              | 18 ++++++++++
 drivers/clk/imx/clk-imx7d.c               | 14 ++++++++
 drivers/clk/imx/clk-vf610.c               |  1 +
 drivers/clk/imx/clk.c                     | 38 ++++++++++++++++++++
 drivers/clk/imx/clk.h                     |  1 +
 include/dt-bindings/clock/imx6qdl-clock.h |  3 +-
 include/dt-bindings/clock/imx6sl-clock.h  |  3 +-
 include/dt-bindings/clock/imx6sx-clock.h  |  3 +-
 include/dt-bindings/clock/imx7d-clock.h   |  3 +-
 include/dt-bindings/clock/vf610-clock.h   |  3 +-
 18 files changed, 219 insertions(+), 36 deletions(-)
