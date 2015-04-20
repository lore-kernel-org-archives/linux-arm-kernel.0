From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Apr 2015 11:58:16 -0700
Subject: [GIT PULL] urgent omap boot fix for v4.1 if MFD_SYSCON is not set
Message-ID: <20150420185816.GI5140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/prcm-dts-mfd-syscon-fix

for you to fetch changes up to da4d81453cf1eedfcd8b2cd1e7bfab230084bd87:

  ARM: OMAP2+: Fix booting with configs that don't have MFD_SYSCON (2015-04-20 10:36:31 -0700)

----------------------------------------------------------------
Urgent pull request for v4.1 to booting for custom kernel
.config files that do not have MFD_SYSCON set.

Omaps now have a dependency to MFD_SYSCON for system control
module generic register area and some clocks with the changes
done in omap-for-v4.1/prcm-dts branch.

This can be pulled on top of omap-for-v4.1/prcm-dts, or into
fixes for v4.1.

We already do have a slight MFD_SYSCON dependency for
REGULATOR_PBIAS for dual voltage MMC cards on the first MMC
bus for many devices, so from that point of view this can
also be merged separately from omap-for-v4.1/prcm-dts.

----------------------------------------------------------------
Tony Lindgren (1):
      ARM: OMAP2+: Fix booting with configs that don't have MFD_SYSCON

 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)
