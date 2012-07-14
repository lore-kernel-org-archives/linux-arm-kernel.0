From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 14 Jul 2012 15:34:14 +0200
Subject: [GIT PULL] Renesas ARM-based boards updates for v3.6
In-Reply-To: <201207141529.21534.rjw@sisk.pl>
References: <201207112338.36939.rjw@sisk.pl> <201207141529.21534.rjw@sisk.pl>
Message-ID: <201207141534.15219.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull changes since commit 0df8fa46611abc56e39f541495d667e4bf4f1060

    Merge branch 'renesas-sh7377' into renesas-soc

with top-most commit 45c7a01f070146e08f5c838315ffca5ade6e3844

    Merge branch 'renesas-marzen' into renesas-board

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git board

to receive updates for Renesas ARM-based boards for v3.6.  Included are:

* Regulator support changes for multiple boards from Guennadi Liakhovetski.
* armadillo800eva and kzm9g support updates from Kuninori Morimoto
  and Tetsuyuki Kobayashi.
* GPIO support update for multiple boards from Kuninori Morimoto.
* defconfig updates from Magnus Damm and Simon Horman.

This is based on the 'soc' branch I've just sent a pull request for and on
the following topic branch from the Mark Brown's regulator tree:

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/topic/fixed

which is requisite for the merge.

Thanks!


 arch/arm/configs/armadillo800eva_defconfig     |  25 +-
 arch/arm/configs/kzm9d_defconfig               |  89 +++++
 arch/arm/configs/kzm9g_defconfig               |   8 +-
 arch/arm/mach-shmobile/Kconfig                 |  12 +
 arch/arm/mach-shmobile/board-ag5evm.c          |  82 ++++-
 arch/arm/mach-shmobile/board-ap4evb.c          |  48 ++-
 arch/arm/mach-shmobile/board-armadillo800eva.c | 454 ++++++++++++++++++++++++-
 arch/arm/mach-shmobile/board-bonito.c          |  10 +
 arch/arm/mach-shmobile/board-g4evm.c           |  52 ++-
 arch/arm/mach-shmobile/board-kota2.c           |  30 ++
 arch/arm/mach-shmobile/board-kzm9d.c           |  10 +
 arch/arm/mach-shmobile/board-kzm9g.c           | 320 +++++++++++++++++
 arch/arm/mach-shmobile/board-mackerel.c        |  59 ++--
 arch/arm/mach-shmobile/board-marzen.c          |  10 +
 drivers/regulator/fixed-helper.c               |  19 +-
 include/linux/regulator/fixed.h                |  11 +-
 16 files changed, 1135 insertions(+), 104 deletions(-)

---------------

Guennadi Liakhovetski (14):
      regulator: support multiple dummy fixed regulators
      regulator: extend the fixed dummy voltage regulator to accept voltage
      ARM: mach-shmobile: add 3.3V and 1.8V fixed regulators to mackerel
      ARM: mach-shmobile: add fixed voltage regulators to ag5evm
      ARM: mach-shmobile: add fixed voltage regulators to ap4evb
      ARM: mach-shmobile: add fixed voltage regulators to armadillo800eva
      ARM: mach-shmobile: add fixed voltage regulators to bonito
      ARM: mach-shmobile: add fixed voltage regulators to g4evm
      ARM: mach-shmobile: add fixed voltage regulators to kota2
      ARM: mach-shmobile: add fixed voltage regulators to kzm9d
      ARM: mach-shmobile: add fixed voltage regulators to kzm9g
      ARM: mach-shmobile: add fixed voltage regulators to marzen
      ARM: mach-shmobile: add SDHI2 to the 2.8V fixed regulator consumers on kzm9g
      ARM: mach-shmobile: select the fixed regulator driver on several boards

Kuninori Morimoto (19):
      ARM: shmobile: armadillo800eva: enable HDMI
      ARM: shmobile: kzm9g: enable FSI-AK4648
      ARM: shmobile: armadillo800eva: enable camera
      ARM: shmobile: armadillo800eva: enable FSI-WM8978 sound
      ARM: shmobile: armadillo800eva: enable FSI-HDMI sound
      ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
      ARM: shmobile: armadillo800eva: enable DMAEngine on SDHI
      ARM: shmobile: armadillo800eva: enable DMAEngine on USB
      ARM: shmobile: use common extra gpio functions on armadillo800eva
      ARM: shmobile: kzm9g: enable USB function
      ARM: shmobile: kzm9g: enable MicroSD
      ARM: shmobile: kzm9g: enable DMAEngine on FSI
      ARM: shmobile: kzm9g: enable DMAEngine on MMCIF
      ARM: shmobile: use common extra gpio functions on Mackerel
      ARM: shmobile: use common extra gpio functions on ap4evb
      ARM: shmobile: use common extra gpio functions on g4evm
      ARM: shmobile: armadillo800eva: USB Func enables external IRQ mode
      ARM: shmobile: armadillo800eva: A4LC domain includes LCDC
      ARM: shmobile: armadillo800eva: A3SP domain includes USB

Magnus Damm (1):
      ARM: mach-shmobile: kzm9d: Add defconfig

Simon Horman (2):
      ARM: mach-shmobile: armadillo800eva: defconfig Allow use of armhf userspace
      ARM: shmobile: kzm9g: defconfig enable INOTIFY_USER

Tetsuyuki Kobayashi (1):
      ARM: shmobile: kzm9g: Support Real Time Clock
