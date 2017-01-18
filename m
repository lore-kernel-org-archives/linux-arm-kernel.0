From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 18 Jan 2017 18:42:21 +0000
Subject: [GIT PULL v2] arm64: dts: juno: updates for v4.11
In-Reply-To: <dbfa1905-d937-7d02-7bbb-5f1a127896cf@arm.com>
References: <dbfa1905-d937-7d02-7bbb-5f1a127896cf@arm.com>
Message-ID: <20170118184221.GA21734@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

v1->v2:
	- Fixed device node names for coresight components as suggested by Olof
	- Removed nested dtsi inclusions(again Olof's suggestions - Thanks)
	- Added some minor cleanup and updates from Robin

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/juno-updates-4.11

for you to fetch changes up to 1492a864364ed46be2abeaaaf3b1a248f19e6644:

  arm64: dts: juno: remove motherboard USB node (2017-01-18 14:01:20 +0000)

----------------------------------------------------------------
ARMv8 Vexpress/Juno DT updates for v4.11

1. Addition of Coresight support on Juno R1 and R2 variants

2. Addition of STM(System Trace Macrocell) support on all Juno variants

3. Removed incorrect nesting of dtsi files

4. Removed untested USB hub only available on initial Juno R0 motherboard

5. Added ETR SMMU power domain and dma-ranges property

----------------------------------------------------------------
Mike Leach (2):
      arm64: dts: juno: add CoreSight support for Juno r1/r2 variants
      arm64: dts: juno: add missing CoreSight STM component

Robin Murphy (3):
      arm64: dts: juno: add dma-ranges property
      arm64: dts: juno: add ETR SMMU power domain
      arm64: dts: juno: remove motherboard USB node

Sudeep Holla (2):
      arm64: dts: juno: remove dtsi nesting inside tree structure
      arm64: dts: juno: refactor CoreSight support on Juno r0

 arch/arm64/boot/dts/arm/juno-base.dtsi        |  43 +++++++----
 arch/arm64/boot/dts/arm/juno-clocks.dtsi      |   3 +-
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi     | 100 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi |   7 --
 arch/arm64/boot/dts/arm/juno-r1.dts           |  16 ++++-
 arch/arm64/boot/dts/arm/juno-r2.dts           |  16 ++++-
 arch/arm64/boot/dts/arm/juno.dts              |  27 ++++++-
 7 files changed, 186 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
