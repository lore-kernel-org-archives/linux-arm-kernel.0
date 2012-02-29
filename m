From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 29 Feb 2012 23:33:36 +0100
Subject: [PATCH v5 00/13] ARM: OMAP3+: SmartReflex: bugfixes and clean-ups
Message-ID: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Integrate the latest SmartReflex bufixes from Felipe Balbi [1] and
Nishant Menon [2], plus misc bugfixesi and minor clean-ups.

Based on latest master branch of the mainline git tree (3.3.0-rc5) [3], commit
5ffca28a4ac7abb8a254fafe6bd03b2f83667df7

[1] http://marc.info/?l=linux-omap&m=132134699423547&w=2
[2] https://github.com/nmenon/linux-omap-ti-pm/commits/linux-omap-3.0
[3] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=shortlog


Revision history:
. v5:
  rebased on latest mainline
  fixed commits description after Kevin's review comments
  removed the unused name field from hwmod IRQ structs

. v4:
  include only the bugfixes and clean-up commits
  rebase on 3.3-rc2

. v3:
  fixed the error handling code

. v2:
  fixed the use of debugfs_create_* API
  minor fixes after comments on l-o ML: commits title, removed unneeded
   fields in descriptions
  removed the unneeded patches about the suspend/resume handlers

. v1:
  initial commits


Felipe Balbi (4):
  ARM: OMAP3+: SmartReflex: add missing platform_set_drvdata()
  ARM: OMAP3+: SmartReflex: move late_initcall() closer to its argument
  ARM: OMAP3+: SmartReflex: misc cleanups
  ARM: OMAP3+: SmartReflex: micro-optimization for sanity check

Jean Pihet (2):
  ARM: OMAP3+: SmartReflex: fix the use of debugfs_create_* API
  ARM: OMAP3+: SmartReflex: fix error handling

Nishanth Menon (6):
  ARM: OMAP3+: SmartReflex: fix err interrupt disable sequence
  ARM: OMAP3+: SmartReflex Class3: disable errorgen before disable VP
  ARM: OMAP3+: SmartReflex: Add a shutdown hook
  ARM: OMAP3+: SmartReflex: Fix status masking in ERRCONFIG register
  ARM: OMAP3+: SmartReflex: clear ERRCONFIG_VPBOUNDINTST only on a need
  ARM: OMAP3+: hwmod: add SmartReflex IRQs

Shweta Gulati (1):
  ARM: OMAP3+: SmartReflex: use voltage domain name in device
    attributes

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   31 +++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   19 ++-
 arch/arm/mach-omap2/smartreflex-class3.c     |    1 +
 arch/arm/mach-omap2/smartreflex.c            |  227 +++++++++++++++++++-------
 arch/arm/mach-omap2/smartreflex.h            |   10 +
 arch/arm/mach-omap2/sr_device.c              |   11 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 -
 7 files changed, 229 insertions(+), 72 deletions(-)

-- 
1.7.5.4
