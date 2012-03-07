From: khilman@ti.com (Kevin Hilman)
Date: Wed, 07 Mar 2012 12:14:38 -0800
Subject: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for v3.4
Message-ID: <877gywjhht.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following support for using regulators to control the
on-chip VC/VP managed voltage domains.

The regulator driver support for this is already queued in the regulator
tree, and this is the supporting core work.

This combined with the CPUfreq changes to use the regulator framework
will finally result in MPU DVFS working in mainline.

Kevin


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/pm/smps-regulator

for you to fetch changes up to c15f1d84bb3ddd668593e9bca53221a2f82e9e99:

  ARM: OMAP2+: voltage: ensure voltage used is exact voltage from OPP table (2012-03-06 17:37:14 -0800)

----------------------------------------------------------------
Kevin Hilman (1):
      ARM: OMAP2+: voltage: ensure voltage used is exact voltage from OPP table

Tero Kristo (4):
      arm: omap3: voltage: fix channel configuration
      arm: omap3: add common twl configurations for vdd1 and vdd2
      arm: omap3: twl: add external controllers for core voltage regulators
      arm: omap4: add common twl configurations for vdd1, vdd2 and vdd3

 arch/arm/mach-omap2/twl-common.c  |  147 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc3xxx_data.c |    1 +
 arch/arm/mach-omap2/voltage.c     |   21 +++++-
 3 files changed, 166 insertions(+), 3 deletions(-)
