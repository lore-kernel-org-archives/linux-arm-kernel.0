From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Jul 2014 10:57:15 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v3.16
Message-ID: <cover.1406162627.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC fixes for v3.16.

The first round of fixes was prior to the release of v3.16-rc1 so
this pull-request is based on v3.16-rc1.

I would like this change considered for v3.15-stable.
I can handle submitting it there if you like.

I do not think it is necessary to consider it for v3.14-stable
as although the incorrect code is present there it is not exercised
in that release.


The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v3.16

for you to fetch changes up to c9b227723d051184b9e78f20c75ae2f9d44a6ea2:

  ARM: shmobile: r8a7791: Fix SD2CKCR register address (2014-07-23 08:55:12 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Fixes for v3.16

* Fix SD2CKCR register address of r8a7791 (R-Car M2) SoC

  This corrects a bug introduced in v3.14 by
  59e79895b9589286 ("ARM: shmobile: r8a7791: Add clocks").

  However, it does not manifest in mainline code until
  SDHI devices were enabled on the Koelsch board in v3.15 by
  2c60a7df72711fb8 ("ARM: shmobile: Add SDHI devices for Koelsch DTS").

  It also manifests on the Henninger board when
  SDHI devices were enabled in v3.16-rc1 by
  1299df03d7191ab4 ("ARM: shmobile: henninger: add SDHI0/2 DT support")

----------------------------------------------------------------
Shinobu Uehara (1):
      ARM: shmobile: r8a7791: Fix SD2CKCR register address

 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
