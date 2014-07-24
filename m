From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Jul 2014 04:43:49 -0700
Subject: [GIT PULL] Few regression fixes for omaps for v3.16-rc series
Message-ID: <20140724114348.GA29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1d29a0722f6c38f79785c9ffb911730598de84e2:

  ARM: OMAP2+: Remove non working OMAP HDMI audio initialization (2014-07-08 01:08:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/fixes-rc6

for you to fetch changes up to 33753cd2ba41c72a0756edc5dc094d91602deda5:

  ARM: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable() (2014-07-23 01:48:24 -0700)

----------------------------------------------------------------
Two regression fixes for omaps and one fix for device signaling:

- L2 cache regression fix for a warning about trying to access
  a read-only register

- GPMC ECC software fallback regression fix for omap3

- Fix for dra7 pinctrl pull-up direction that causes signal issues
  for anybody trying to use the internal pull up or down

----------------------------------------------------------------
Christoph Fritz (1):
      ARM: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable()

Nishanth Menon (1):
      pinctrl: dra: dt-bindings: Fix pull enable/disable

Sekhar Nori (1):
      ARM: OMAP2+: l2c: squelch warning dump on power control setting

 arch/arm/mach-omap2/gpmc-nand.c    | 18 ++++++++++--------
 arch/arm/mach-omap2/omap4-common.c |  4 ++++
 include/dt-bindings/pinctrl/dra.h  |  7 ++++---
 3 files changed, 18 insertions(+), 11 deletions(-)
