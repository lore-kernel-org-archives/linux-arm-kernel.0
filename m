From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 Nov 2016 18:28:22 +0530
Subject: [GIT PULL] DaVinci additional driver support for v4.10
Message-ID: <fc11bfc7-e218-cd11-8e4e-c48e899d1cb5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/drivers

for you to fetch changes up to 8e7223fc8626db7c302136747bb68213100d290c:

  bus: davinci: add support for da8xx bus master priority control (2016-11-14 17:20:29 +0530)

----------------------------------------------------------------
This pull request adds two new drivers for better
support for LCD found on DaVinci DA8xx devices.

They allow configuration of memory interface and
bus priorities on the SoC to allow sufficient
bandwidth for the LCD and prevent underruns.

The DT bindings have been reviewed by Rob and
patches have been reviewed by Kevin.

----------------------------------------------------------------
Bartosz Golaszewski (2):
      memory: davinci: add support for da8xx DDR2/mDDR controller
      bus: davinci: add support for da8xx bus master priority control

 .../devicetree/bindings/bus/ti,da850-mstpri.txt    |  20 ++
 .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 ++
 drivers/bus/Kconfig                                |   9 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/da8xx-mstpri.c                         | 269 +++++++++++++++++++++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/da8xx-ddrctl.c                      | 175 ++++++++++++++
 8 files changed, 504 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
 create mode 100644 drivers/bus/da8xx-mstpri.c
 create mode 100644 drivers/memory/da8xx-ddrctl.c
