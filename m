From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 21:13:31 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Match Updates for v4.10
Message-ID: <cover.1479928995.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC match updates for v4.10.

This pull request is based on the pull request "soc_device_match()
interface for matching against soc_bus attributes" sent by Geert
Uytterhoeven which corresponds to the soc-device-match-tag1 tag in his
renesas-driver's tree. It provides infrastructure used by changes in this
pull request.

This pull request is broken out of an earlier pull request,
"Second Round of Renesas ARM Based SoC Drivers Updates for v4.10".
The motivation for breaking up the pull request is to provide
branches with minimal dependencies.

This pull request is targeted at the next/drivers branch of the arm-soc tree.

It introduces some minor merge conflicts in drivers/soc/renesas/Makefile.
The resolution is to take both sides.  A sample merge resolution is
provided in the renesas-next-20161123v2-v4.9-rc1 tag of the renesas tree.


The following changes since commit da65a1589dacc7ec44ea0557a14d70a39d991f32:

  base: soc: Provide a dummy implementation of soc_device_match() (2016-11-10 10:10:37 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-match-for-v4.10

for you to fetch changes up to 8d6799a9ba23acd675f3243580ee6f1756fb4381:

  soc: renesas: Identify SoC and register with the SoC bus (2016-11-23 20:22:21 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Match Updates for v4.10

* Identify SoC and register with the SoC bus

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: Document DT bindings for Product Register
      soc: renesas: Identify SoC and register with the SoC bus

 Documentation/devicetree/bindings/arm/shmobile.txt |  18 ++
 arch/arm/mach-shmobile/Kconfig                     |   1 +
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/soc/renesas/Makefile                       |   2 +
 drivers/soc/renesas/renesas-soc.c                  | 257 +++++++++++++++++++++
 5 files changed, 279 insertions(+)
 create mode 100644 drivers/soc/renesas/renesas-soc.c
