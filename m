From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 28 Aug 2013 10:52:11 +0300
Subject: [GIT PULL] OMAPDSS: use new display drivers
Message-ID: <521DAC2B.4080100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here's a pull request for the board file changes to take the new display
drivers into use.

If there's an "early" pull request going to Linus during the merge window, it'd
be nice to have these in that request. That would give me time to send a pull
request to Linus containing removal of the old, no longer used, drivers.

 Tomi

The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:

  Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.12/linux-omap

for you to fetch changes up to d7b8eafbf513e414fa09dde61630b93be93a23a1:

  ARM: OMAP2+: Remove old display drivers from omap2plus_defconfig (2013-08-28 10:23:22 +0300)

----------------------------------------------------------------
Tomi Valkeinen (20):
      ARM: OMAP2+: Remove legacy DSS initialization for omap4
      ARM: OMAP2+: Add selected display drivers to omap2plus_defconfig
      ARM: OMAP: dss-common: use new display drivers
      ARM: OMAP: 4430SDP: remove picodlp device data
      ARM: OMAP: overo: use new display drivers
      ARM: OMAP: rx51: use new display drivers
      ARM: OMAP: beagle: use new display drivers
      ARM: OMAP: devkit8000: use new display drivers
      ARM: OMAP: 2430SDP: use new display drivers
      ARM: OMAP: LDP: use new display drivers
      ARM: OMAP: omap3stalker: use new display drivers
      ARM: OMAP: igep0020: use new display drivers
      ARM: OMAP: cm-t35: use new display drivers
      ARM: OMAP: H4: use new display drivers
      ARM: OMAP: 3430SDP: use new display drivers
      ARM: OMAP: OMAP3EVM: use new display drivers
      ARM: OMAP: Pandora: use new display drivers
      ARM: OMAP: Zoom: use new display drivers
      ARM: OMAP: AM3517EVM: use new display drivers
      ARM: OMAP2+: Remove old display drivers from omap2plus_defconfig

 arch/arm/configs/omap2plus_defconfig         |  12 +-
 arch/arm/mach-omap2/board-2430sdp.c          |  57 ++++---
 arch/arm/mach-omap2/board-3430sdp.c          |  83 +++++----
 arch/arm/mach-omap2/board-am3517evm.c        | 113 +++++++++----
 arch/arm/mach-omap2/board-cm-t35.c           | 100 +++++++----
 arch/arm/mach-omap2/board-devkit8000.c       |  96 +++++++----
 arch/arm/mach-omap2/board-h4.c               |  48 ++++--
 arch/arm/mach-omap2/board-igep0020.c         |  36 ++--
 arch/arm/mach-omap2/board-ldp.c              |  68 +++++---
 arch/arm/mach-omap2/board-omap3beagle.c      |  56 +++---
 arch/arm/mach-omap2/board-omap3evm.c         |  87 ++++++----
 arch/arm/mach-omap2/board-omap3pandora.c     |  48 +++---
 arch/arm/mach-omap2/board-omap3stalker.c     |  61 ++++---
 arch/arm/mach-omap2/board-overo.c            | 160 +++++++++++-------
 arch/arm/mach-omap2/board-rx51-peripherals.c |  12 ++
 arch/arm/mach-omap2/board-rx51-video.c       |  35 ++--
 arch/arm/mach-omap2/board-zoom-display.c     |  30 ++--
 arch/arm/mach-omap2/dss-common.c             | 244 ++++++++++++---------------
 arch/arm/mach-omap2/dss-common.h             |   2 -
 19 files changed, 787 insertions(+), 561 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130828/a217aa50/attachment.sig>
