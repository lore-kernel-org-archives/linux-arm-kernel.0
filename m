From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 28 Oct 2016 12:30:03 +0100
Subject: [GIT PULL] ARM: vexpress: fixes for v4.10
Message-ID: <20161028113003.GC12241@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC team,

These couple of fixes help to boot TC2 in HYP mode with CONFIG_MCPM
enabled. This was not supported directly before and hence targeting for
v4.10. Currently those who want to boot in HYP mode have to disable
MCPM config in the build.

Please pull.

--
Regards,
Sudeep

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-fixes-4.10

for you to fetch changes up to 801f33be8e902d8cea75cb7ac056d07c4fdd25f8:

  drivers: cci: add missing CCI port availability firmware check (2016-10-17 14:27:54 +0100)

----------------------------------------------------------------
ARMv7 Vexpress fixes for v4.10

Couple of fixes to MCPM/CCI drivers to check and ensure that the kernel
is actually allowed to take control over CCI ports(i.e. running in
secure mode) before enabling MCPM.

This is needed to boot Linux in HYP mode (very useful for development
on virtualization) with CONFIG_MCPM enabled kernel.

----------------------------------------------------------------
Lorenzo Pieralisi (2):
      ARM: vexpress: refine MCPM smp operations override criteria
      drivers: cci: add missing CCI port availability firmware check

 arch/arm/mach-vexpress/platsmp.c | 34 ++++++++++++++++++++++++++--------
 drivers/bus/arm-cci.c            | 10 ++++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)
