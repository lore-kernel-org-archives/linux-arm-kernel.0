From: dhdang@apm.com (Duc Dang)
Date: Fri, 2 Sep 2016 11:46:31 -0700
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for 4.9 - part1
Message-ID: <CADaLNDkZdAipxx6cfLJ6yrzTrcLPS_Ciw8+T5EUFVcRRw+fjPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the first part of DTS changes for X-Gene platforms targeted for 4.9.

The changes include:
+ X-Gene Soc PMU support patch set from Tai Nguyen (v10 reviewed by
Mark, DT binding document acked by Rob [1] and was suggested to merge
via am-soc tree by Will [2])
+ Follow up patch to enable DT entry for SoC PMU on X-Gene v2
+ Correct PCIe legacy interrupt mode to level-active high
+ DTS entry for X-Gene hwmon (v4 acked by Guenter, DT binding document
and driver is in linux-next now [3])

Regards,
Duc Dang.

[1]: https://lkml.org/lkml/2016/7/15/563
[2]: https://lkml.org/lkml/2016/7/20/224
[3]: http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=893485e74c37669aeecf0b648dbfbd8e2f0471c3
------

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.9-part1

for you to fetch changes up to 1c983fc9369420748192712bde2429af3e580390:

  arm64: dts: apm: Add X-Gene SoC hwmon to device tree (2016-09-02
10:43:41 -0700)

----------------------------------------------------------------
X-Gene DTS changes queued for v4.9 - part 1

This patch set includes:
+ X-Gene v1 SoC Performance Monitoring Unit (PMU) support
+ DTS entry to enable SoC PMU for X-Gene v2 SoC
+ PCIe legacy interrupt polarity fix for X-Gene
+ X-Gene SoC hwmon DTS entry

----------------------------------------------------------------
Duc Dang (2):
      arm64: dts: apm: Add APM X-Gene v2 SoC PMU DTS entries
      arm64: dts: apm: Fix interrupt polarity for X-Gene PCIe legacy interrupts

Tai Nguyen (4):
      MAINTAINERS: Add entry for APM X-Gene SoC PMU driver
      Documentation: Add documentation for APM X-Gene SoC PMU DTS binding
      perf: xgene: Add APM X-Gene SoC Performance Monitoring Unit driver
      arm64: dts: apm: Add APM X-Gene SoC PMU DTS entries

hotran (1):
      arm64: dts: apm: Add X-Gene SoC hwmon to device tree

 .../devicetree/bindings/perf/apm-xgene-pmu.txt     |  112 ++
 Documentation/perf/xgene-pmu.txt                   |   48 +
 MAINTAINERS                                        |    7 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |   79 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  103 +-
 drivers/perf/Kconfig                               |    7 +
 drivers/perf/Makefile                              |    1 +
 drivers/perf/xgene_pmu.c                           | 1398 ++++++++++++++++++++
 8 files changed, 1727 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 create mode 100644 Documentation/perf/xgene-pmu.txt
 create mode 100644 drivers/perf/xgene_pmu.c
