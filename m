From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:30:41 +0900
Subject: [GIT PULL] Renesas ARM Based SoC GIC Cleanup for v4.5
Message-ID: <cover.1450401902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC GIC cleanup for v4.5.

This pull-request includes staging-board changes which have been
acked by Greg Kroah-Hartman. They are bundled into this pull-request
as not-doing so would break the drivers they update.

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-gic-cleanup-for-v4.5

for you to fetch changes up to 1474136ce6a457a10a797b3de04adbb035e90901:

  staging: board: armadillo800eva: Use "arm,pl390" (2015-12-18 10:21:10 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC GIC Cleanup for v4.5

On several Renesas ARM SoCs, the GIC is described in DT as being a
Cortex A9 GIC, while it's actually a PL390. This is not only stated in
the documentation, but has been verified by reading the GICD_IIDR
register.

To correct this:
  1. Update the DT compatible value to match reality,
  2. Update the board staging drivers to match the above.

----------------------------------------------------------------
Geert Uytterhoeven (6):
      ARM: shmobile: r7s72100 dtsi: Use "arm,pl390" for GIC
      ARM: shmobile: r8a7740 dtsi: Use "arm,pl390" for GIC
      ARM: shmobile: emev2 dtsi: Use "arm,pl390" for GIC
      ARM: shmobile: r8a7778 dtsi: Use "arm,pl390" for GIC
      staging: board: kzm9d: Use "arm,pl390"
      staging: board: armadillo800eva: Use "arm,pl390"

 arch/arm/boot/dts/emev2.dtsi            | 2 +-
 arch/arm/boot/dts/r7s72100.dtsi         | 2 +-
 arch/arm/boot/dts/r8a7740.dtsi          | 2 +-
 arch/arm/boot/dts/r8a7778.dtsi          | 2 +-
 drivers/staging/board/armadillo800eva.c | 2 +-
 drivers/staging/board/kzm9d.c           | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)
