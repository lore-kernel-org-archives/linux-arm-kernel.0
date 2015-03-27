From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Mar 2015 17:25:00 +0000
Subject: [GIT PULL] arm-cci PMU updates for 4.1
Message-ID: <20150327172500.GO1562@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Please can you pull the following ARM CCI PMU updates for 4.1? Suzuki
has reworked parts of the existing driver so that it can be used on CPUs
booting in non-secure mode (i.e. ARM64 systems) and also make it easier
to port over to new IP, such as CCI-500.

It's coming via me as $ARM_PERF_GUY, but Nico has Acked the core driver
(non-PMU) changes. Note that these have been in next for a bit, but I
can drop the branch once you've pulled.

Cheers,

Will

--->8

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-perf-4.1

for you to fetch changes up to 874c571414d5617f4042298986b6a826816ee885:

  arm-cci: Fix CCI PMU event validation (2015-03-27 13:45:02 +0000)

----------------------------------------------------------------
CCI-400 PMU updates

This series reworks some of the CCI-400 PMU code so that it can be used
on both ARM and ARM64-based systems, without the need to boot in secure
mode on the latter. This paves the way for CCI-500 support in future.

----------------------------------------------------------------
Suzuki K. Poulose (6):
      drivers: cci: reject groups spanning multiple HW PMUs
      arm-cci: Rearrange code for splitting PMU vs driver code
      arm-cci: Abstract the CCI400 PMU specific definitions
      arm-cci: Get rid of secure transactions for PMU driver
      arm-cci: Split the code for PMU vs driver support
      arm-cci: Fix CCI PMU event validation

 Documentation/devicetree/bindings/arm/cci.txt |   7 +-
 arch/arm/include/asm/arm-cci.h                |  42 +++
 arch/arm/mach-exynos/Kconfig                  |   2 +-
 arch/arm/mach-vexpress/Kconfig                |   4 +-
 arch/arm64/include/asm/arm-cci.h              |  27 ++
 drivers/bus/Kconfig                           |  28 +-
 drivers/bus/arm-cci.c                         | 517 +++++++++++++++-----------
 include/linux/arm-cci.h                       |   9 +-
 8 files changed, 399 insertions(+), 237 deletions(-)
 create mode 100644 arch/arm/include/asm/arm-cci.h
 create mode 100644 arch/arm64/include/asm/arm-cci.h
