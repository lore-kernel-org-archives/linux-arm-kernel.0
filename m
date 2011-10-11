From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 11 Oct 2011 13:45:03 +0300
Subject: [PATCH v8 0/3] Add support for tegra2 based ventana board
Message-ID: <1318329909-32601-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the tegra2 based ventana development board.

Boot tested on ventana.                                                                                                                               

Uses a table based approach to select the correct init function.

Provoke kernel warning when no suitable pinmux table can be found.

Peter De Schrijver (3):
  arm/tegra: prepare Seaboard pinmux code for derived boards
  arm/tegra: add support for ventana pinmuxing
  arm/tegra: device tree support for ventana board

 arch/arm/boot/dts/tegra-ventana.dts         |   32 ++++++++++++++
 arch/arm/mach-tegra/Kconfig                 |    6 +++
 arch/arm/mach-tegra/Makefile                |    1 +
 arch/arm/mach-tegra/Makefile.boot           |    1 +
 arch/arm/mach-tegra/board-dt.c              |    5 ++-
 arch/arm/mach-tegra/board-seaboard-pinmux.c |   63 ++++++++++++++++++++++++---
 6 files changed, 101 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra-ventana.dts
