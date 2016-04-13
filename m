From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 13 Apr 2016 15:20:24 +0800
Subject: [GIT PULL] i.MX clock updates for 4.7
Message-ID: <20160413072001.GM28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following i.MX clock updates I queued for 4.7, and keep
the branch stable.  Thanks.

Shawn

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-4.7

for you to fetch changes up to 69c542e8022ca53c5fee664548163809eb1777c3:

  clk: imx: vf610: fix whitespace in vf610-clock.h (2016-04-12 09:31:08 +0800)

----------------------------------------------------------------
The i.MX clock update for 4.7:
 - Register SAI clk as shared clocks to support SAI audio on i.MX6SX
 - Add the missing ckil clock for i.MX7
 - Update clk-gate2 and vf610 clock driver to prepare for suspend
   support on VF610
 - Fix DCU clock configurations and add TCON ipg clock to support DRM
   display on VF610

----------------------------------------------------------------
Fabio Estevam (1):
      clk: imx6sx: Register SAI clocks as shared clocks

Gary Bisson (1):
      clk: imx: add ckil clock for i.MX7

Shawn Guo (1):
      clk: imx: vf610: fix whitespace in vf610-clock.h

Stefan Agner (6):
      clk: imx: clk-gate2: allow custom gate configuration
      clk: imx: vf610: leave DDR clock on
      clk: imx: vf610: add WKPU unit
      clk: imx: vf610: add suspend/resume support
      clk: imx: vf610: fix DCU clock tree
      clk: imx: vf610: add TCON ipg clock

 drivers/clk/imx/clk-gate2.c             |  7 ++--
 drivers/clk/imx/clk-imx6sx.c            | 10 +++---
 drivers/clk/imx/clk-imx7d.c             |  3 +-
 drivers/clk/imx/clk-vf610.c             | 60 +++++++++++++++++++++++++++++++--
 drivers/clk/imx/clk.h                   | 13 +++++--
 include/dt-bindings/clock/imx7d-clock.h |  3 +-
 include/dt-bindings/clock/vf610-clock.h |  8 +++--
 7 files changed, 89 insertions(+), 15 deletions(-)
