From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Sep 2017 09:53:49 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.15
Message-ID: <cover.1506325468.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC drivers updates for v4.15.


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v4.15

for you to fetch changes up to bab9b2a74fe9da96e895e0919f625679a0a8c964:

  soc: renesas: rcar-sysc: add R8A77970 support (2017-09-18 09:46:50 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Drivers Updates for v4.15

Add basic support for R-Car V3M (R8A77970) SoC.

Sergei Shtylyov says:

* Add support for R-Car V3M (R8A77970) SoC power areas to the R-Car SYSC
  driver

* Add support for identifying the R-Car V3M (R8A77970) SoC

* Add support for R-Car V3M (R8A77970) to the R-Car RST driver -- this
  driver is  needed  for the clock driver to work

----------------------------------------------------------------
Sergei Shtylyov (3):
      soc: renesas: rcar-rst: add R8A77970 support
      soc: renesas: identify R-Car V3M
      soc: renesas: rcar-sysc: add R8A77970 support

 .../bindings/power/renesas,rcar-sysc.txt           |  1 +
 .../devicetree/bindings/reset/renesas,rst.txt      |  1 +
 drivers/soc/renesas/Kconfig                        |  8 ++++-
 drivers/soc/renesas/Makefile                       |  1 +
 drivers/soc/renesas/r8a77970-sysc.c                | 39 ++++++++++++++++++++++
 drivers/soc/renesas/rcar-rst.c                     |  1 +
 drivers/soc/renesas/rcar-sysc.c                    |  3 ++
 drivers/soc/renesas/rcar-sysc.h                    |  1 +
 drivers/soc/renesas/renesas-soc.c                  |  8 +++++
 9 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/renesas/r8a77970-sysc.c
