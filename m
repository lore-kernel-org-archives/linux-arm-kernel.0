From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Nov 2016 17:17:10 +0100
Subject: [GIT PULL 1/10] mailbox: Add Tegra HSP driver
Message-ID: <20161118161719.24153-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-mailbox

for you to fetch changes up to 68050eb6c611527232fe5574c7306e97e47499ef:

  mailbox: tegra-hsp: Use after free in tegra_hsp_remove_doorbells() (2016-11-18 14:32:13 +0100)

Thanks,
Thierry

----------------------------------------------------------------
mailbox: Add Tegra HSP driver

This contains the device tree bindings and a driver for the Tegra HSP, a
hardware block that provides hardware synchronization primitives and is
the foundation for inter-processor communication between CPU and BPMP.

----------------------------------------------------------------
Dan Carpenter (1):
      mailbox: tegra-hsp: Use after free in tegra_hsp_remove_doorbells()

Joseph Lo (2):
      soc/tegra: Add Tegra186 support
      dt-bindings: mailbox: Add Tegra HSP binding

Thierry Reding (2):
      Merge branch 'for-4.10/soc' into for-4.10/mailbox
      mailbox: Add Tegra HSP driver

 .../bindings/mailbox/nvidia,tegra186-hsp.txt       |  52 +++
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/tegra-hsp.c                        | 479 +++++++++++++++++++++
 drivers/soc/tegra/Kconfig                          |  14 +
 include/dt-bindings/mailbox/tegra186-hsp.h         |  24 ++
 6 files changed, 580 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
 create mode 100644 drivers/mailbox/tegra-hsp.c
 create mode 100644 include/dt-bindings/mailbox/tegra186-hsp.h
