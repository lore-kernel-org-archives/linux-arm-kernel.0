From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Nov 2016 17:17:11 +0100
Subject: [GIT PULL 2/10] firmware: Add Tegra IVC and BPMP support
In-Reply-To: <20161118161719.24153-1-thierry.reding@gmail.com>
References: <20161118161719.24153-1-thierry.reding@gmail.com>
Message-ID: <20161118161719.24153-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-firmware

for you to fetch changes up to b704ed8095ee91af5f3f7343bb3be23aae1cb26d:

  dt-bindings: firmware: Allow child nodes inside the Tegra BPMP (2016-11-18 14:33:44 +0100)

Thanks,
Thierry

----------------------------------------------------------------
firmware: Add Tegra IVC and BPMP support

IVC is an inter-processor communication protocol that uses shared memory
to exchange data between processors. The BPMP driver makes use of this
to communicate with the Boot and Power Management Processor (BPMP) and
uses an additional hardware synchronization primitive from the HSP block
to signal availability of new data (doorbell).

Firmware running on the BPMP implements a number of services such as the
control of clocks and resets within the system, or the ability to ungate
or gate power partitions.

----------------------------------------------------------------
Dan Carpenter (1):
      mailbox: tegra-hsp: Use after free in tegra_hsp_remove_doorbells()

Joseph Lo (3):
      soc/tegra: Add Tegra186 support
      dt-bindings: mailbox: Add Tegra HSP binding
      dt-bindings: firmware: Add bindings for Tegra BPMP

Stephen Warren (2):
      dt-bindings: Add power domains to Tegra BPMP firmware
      dt-bindings: firmware: Allow child nodes inside the Tegra BPMP

Thierry Reding (5):
      Merge branch 'for-4.10/soc' into for-4.10/mailbox
      mailbox: Add Tegra HSP driver
      Merge branch 'for-4.10/mailbox' into for-4.10/firmware
      firmware: tegra: Add IVC library
      firmware: tegra: Add BPMP support

 .../bindings/firmware/nvidia,tegra186-bpmp.txt     |  108 ++
 .../bindings/mailbox/nvidia,tegra186-hsp.txt       |   52 +
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/tegra/Kconfig                     |   25 +
 drivers/firmware/tegra/Makefile                    |    2 +
 drivers/firmware/tegra/bpmp.c                      |  868 +++++++++++
 drivers/firmware/tegra/ivc.c                       |  695 +++++++++
 drivers/mailbox/Kconfig                            |    9 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/tegra-hsp.c                        |  479 ++++++
 drivers/soc/tegra/Kconfig                          |   14 +
 include/dt-bindings/clock/tegra186-clock.h         |  940 ++++++++++++
 include/dt-bindings/mailbox/tegra186-hsp.h         |   24 +
 include/dt-bindings/power/tegra186-powergate.h     |   39 +
 include/dt-bindings/reset/tegra186-reset.h         |  217 +++
 include/soc/tegra/bpmp-abi.h                       | 1601 ++++++++++++++++++++
 include/soc/tegra/bpmp.h                           |  141 ++
 include/soc/tegra/ivc.h                            |  109 ++
 19 files changed, 5327 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
 create mode 100644 drivers/firmware/tegra/Kconfig
 create mode 100644 drivers/firmware/tegra/Makefile
 create mode 100644 drivers/firmware/tegra/bpmp.c
 create mode 100644 drivers/firmware/tegra/ivc.c
 create mode 100644 drivers/mailbox/tegra-hsp.c
 create mode 100644 include/dt-bindings/clock/tegra186-clock.h
 create mode 100644 include/dt-bindings/mailbox/tegra186-hsp.h
 create mode 100644 include/dt-bindings/power/tegra186-powergate.h
 create mode 100644 include/dt-bindings/reset/tegra186-reset.h
 create mode 100644 include/soc/tegra/bpmp-abi.h
 create mode 100644 include/soc/tegra/bpmp.h
 create mode 100644 include/soc/tegra/ivc.h
