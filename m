From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 21 Sep 2016 14:16:13 +0800
Subject: [GIT PULL] i.MX legacy board changes for 4.9
Message-ID: <20160921061613.GI3744@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

I know this is late for 4.9 merge window, but the patch series fixes a
regression for i.MX legacy board support on linux-next [1].  So please
pull it for 4.9 merge window.  Otherwise, we will need to get them in
during 4.9-rc cycles.

Thanks,
Shawn

[1] http://www.gossamer-threads.com/lists/linux/kernel/2529845


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-legacy-4.9

for you to fetch changes up to 23fe1fd01c1e065907fdcd5cbfd35c02e5a418a2:

  ARM: imx legacy: pca100: move peripheral initialization to .init_late (2016-09-20 22:39:07 +0800)

----------------------------------------------------------------
i.MX legacy board file changes for 4.9:

It includes a patch series that moves registrations and initializations
of all peripherals which are GPIO line consumers for all legacy boards
from .init_machine to .init_late init level. This is needed to
proactively prevent boot time issues on the legacy boards due to the
deprioritized init level of the GPIO controller driver (set lower than
IOMUX controller driver init level), which is shared among all i.MX
SoCs.

----------------------------------------------------------------
Vladimir Zapolskiy (17):
      ARM: imx legacy: kzm: move peripheral initialization to .init_late
      ARM: imx legacy: mx31lite: move peripheral initialization to .init_late
      ARM: imx legacy: mx31ads: move peripheral initialization to .init_late
      ARM: imx legacy: mx31lilly: move peripheral initialization to .init_late
      ARM: imx legacy: pcm037: move peripheral initialization to .init_late
      ARM: imx legacy: mx31-3ds: move peripheral initialization to .init_late
      ARM: imx legacy: qong: move peripheral initialization to .init_late
      ARM: imx legacy: armadillo5x0: move peripheral initialization to .init_late
      ARM: imx legacy: mx31moboard: move peripheral initialization to .init_late
      ARM: imx legacy: vpr200: move peripheral initialization to .init_late
      ARM: imx legacy: imx27-visstrim-m10: move peripheral initialization to .init_late
      ARM: imx legacy: mx27-3ds: move peripheral initialization to .init_late
      ARM: imx legacy: mx35-3ds: move peripheral initialization to .init_late
      ARM: imx legacy: pcm043: move peripheral initialization to .init_late
      ARM: imx legacy: mx21ads: move peripheral initialization to .init_late
      ARM: imx legacy: mx27ads: move peripheral initialization to .init_late
      ARM: imx legacy: pca100: move peripheral initialization to .init_late

 arch/arm/mach-imx/mach-armadillo5x0.c       | 39 ++++++++++-------
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c | 24 +++++++---
 arch/arm/mach-imx/mach-kzm_arm11_01.c       |  9 +++-
 arch/arm/mach-imx/mach-mx21ads.c            | 13 ++++--
 arch/arm/mach-imx/mach-mx27_3ds.c           | 30 ++++++++-----
 arch/arm/mach-imx/mach-mx27ads.c            | 13 ++++--
 arch/arm/mach-imx/mach-mx31_3ds.c           | 39 ++++++++++-------
 arch/arm/mach-imx/mach-mx31ads.c            | 18 ++++----
 arch/arm/mach-imx/mach-mx31lilly.c          | 50 +++++++++++++++------
 arch/arm/mach-imx/mach-mx31lite.c           | 68 ++++++++++++++++++++---------
 arch/arm/mach-imx/mach-mx31moboard.c        | 23 ++++++----
 arch/arm/mach-imx/mach-mx35_3ds.c           | 15 ++++---
 arch/arm/mach-imx/mach-pca100.c             | 26 ++++++-----
 arch/arm/mach-imx/mach-pcm037.c             | 67 ++++++++++++++--------------
 arch/arm/mach-imx/mach-pcm043.c             | 10 ++++-
 arch/arm/mach-imx/mach-qong.c               |  2 +-
 arch/arm/mach-imx/mach-vpr200.c             | 29 +++++++-----
 arch/arm/mach-imx/mx31lilly-db.c            | 20 ---------
 arch/arm/mach-imx/mx31lite-db.c             | 33 --------------
 19 files changed, 301 insertions(+), 227 deletions(-)
