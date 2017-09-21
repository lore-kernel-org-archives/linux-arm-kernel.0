From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 21 Sep 2017 18:12:59 +0200
Subject: [GIT PULL] Reset controller fixes for v4.14
Message-ID: <1506010379.10081.15.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc-maintainers,

please consider merging this tag for v4.14. It removes the "v1" suffix
from the newly merged HSDK reset driver, fixes its Kconfig dependencies,
and adds back the DT binding documentation that I accidentally dropped
onto the floor when applying the original patch.

regards
Philipp

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-fixes-for-4.14

for you to fetch changes up to 544e3bf4f0e8278400f19ca7918a3cdf2548b4eb:

  reset: Restrict RESET_HSDK to ARC_SOC_HSDK or COMPILE_TEST (2017-09-21 12:44:01 +0200)

----------------------------------------------------------------
Reset controller fixes for v4.14

- Remove misleading HSDK v1 suffix, as there is no v2 planned
- Add missing DT binding documentation for HSDK reset driver
- Fix HSDK reset driver dependencies

----------------------------------------------------------------
Eugeniy Paltsev (1):
      ARC: reset: add missing DT binding documentation for HSDKv1 reset driver

Geert Uytterhoeven (1):
      reset: Restrict RESET_HSDK to ARC_SOC_HSDK or COMPILE_TEST

Thomas Meyer (1):
      ARC: reset: Only build on archs that have IOMEM

Vineet Gupta (1):
      ARC: reset: remove the misleading v1 suffix all over

 .../devicetree/bindings/reset/snps,hsdk-reset.txt  | 28 ++++++++++++++
 MAINTAINERS                                        |  6 +--
 drivers/reset/Kconfig                              |  9 +++--
 drivers/reset/Makefile                             |  2 +-
 drivers/reset/{reset-hsdk-v1.c => reset-hsdk.c}    | 44 +++++++++++-----------
 include/dt-bindings/reset/snps,hsdk-reset.h        | 17 +++++++++
 include/dt-bindings/reset/snps,hsdk-v1-reset.h     | 17 ---------
 7 files changed, 76 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt
 rename drivers/reset/{reset-hsdk-v1.c => reset-hsdk.c} (72%)
 create mode 100644 include/dt-bindings/reset/snps,hsdk-reset.h
 delete mode 100644 include/dt-bindings/reset/snps,hsdk-v1-reset.h
