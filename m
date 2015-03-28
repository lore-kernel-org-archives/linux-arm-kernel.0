From: tony@atomide.com (Tony Lindgren)
Date: Sat, 28 Mar 2015 09:02:30 -0700
Subject: [GIT PULL 2/2] omap soc changes for v4.1
In-Reply-To: <pull-1427494738-793290>
References: <pull-1427494738-793290>
Message-ID: <pull-1427494738-793290-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/v4.1-soc

for you to fetch changes up to a6b188e50a6ad6fa4d2da163a44f21280cea01c2:

  Merge tag 'for-v4.1/omap-hwmod-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.1/soc (2015-03-27 10:42:16 -0700)

----------------------------------------------------------------
SoC related changes for omaps. Mostly hwmod related changes via
Paul Walmsley <paul@pwsan.com>:

OMAP hwmod data changes for AM43xx and DRA7xx for v4.1

Add support for the AM43xx HDQ/1-wire driver and fix the GPTIMER data
for DRA7xx.

Note that I do not have AM43xx nor DRA7xx boards, and cannot test these
patches on those platforms.

Basic build, boot, and PM test logs are available at:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.1/20150324185246/

----------------------------------------------------------------
Grygorii Strashko (1):
      ARM: omap-device: add missed callback for suspend-to-disk

Sourav Poddar (1):
      ARM: OMAP2: hwmod: AM43XX: Add hwmod support for HDQ-1W

Suman Anna (2):
      ARM: DRA7: hwmod: Add data for GPTimers 13 through 16
      ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4

Tony Lindgren (1):
      Merge tag 'for-v4.1/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.1/soc

 arch/arm/mach-omap2/omap_device.c          |   3 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  36 +++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 113 +++++++++++++++++++++++++----
 arch/arm/mach-omap2/prcm43xx.h             |   1 +
 4 files changed, 137 insertions(+), 16 deletions(-)
