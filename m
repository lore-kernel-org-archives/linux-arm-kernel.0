From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Nov 2016 09:10:35 +0100
Subject: [GIT PULL] Integrator DTS and defconfig changes
Message-ID: <CACRpkdara5D=kvGVYu-WRh_JYK6Z9NKmQ-eniXsauxdzx-QJbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this adds DT-based cpufreq to the Integrator family.

The corresponding cpufreq changes are merged by Rafael to the
cpufreq tree, and can go in orthogonally.

However I have included the defconfig change turning on the feature
here as it makes all kind of logic sense to have these three patches
in succession: addin the DTS nodes and then turning on the DT
cpufreq.

If you insist, of course I can send the defconfig patch separately.
I just think it makes more sense like this.

Please pull it in so we get some rotation in linux-next for this!

Yours,
Linus Walleij

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/armsoc-integrator-dts

for you to fetch changes up to 023c8faf9bbc95b2d00768414f0f73076ca06dc9:

  ARM: defconfig: turn on the DT cpufreq for Integrator (2016-11-09
09:02:46 +0100)

----------------------------------------------------------------
This contains the DTS changes enabling DT-only cpufreq
scaling on the Integrator family.

----------------------------------------------------------------
Linus Walleij (3):
      ARM: dts: Add Integrator/AP cpus node and operating points
      ARM: dts: Add Integrator/CP cpus node and operating points
      ARM: defconfig: turn on the DT cpufreq for Integrator

 arch/arm/boot/dts/integratorap.dts    | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/integratorcp.dts    | 26 ++++++++++++++++++++++++++
 arch/arm/configs/integrator_defconfig |  1 +
 3 files changed, 62 insertions(+)
