From: dhdang@apm.com (Duc Dang)
Date: Fri, 16 Sep 2016 00:01:28 -0700
Subject: [GIT PULL 2/2] arm64: X-Gene platforms DTS changes queued for 4.9
Message-ID: <CADaLNDk7uP8Gv+YB6oJfLqyRgjVVY82jQoPrQMk6y8xXGokyUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the DTS changes for X-Gene platforms targeted for 4.9.

The changes include:
+ X-Gene Soc PMU DTS entry from X-Gene PMU patch set of Tai Nguyen [1]
+ Follow up patch to enable DTS entry for SoC PMU on X-Gene v2
+ Correct PCIe legacy interrupt mode to level-active high
+ DTS entry for X-Gene hwmon (v4 acked by Guenter, DT binding document
and driver is in linux-next now [2])
+ DTS entries for X-Gene v2 CPU clock from X-Gene PMD clock patch set
(v3 already accepted by Stephen into clk-next [3])

Regards,
Duc Dang.

[1]: https://lkml.org/lkml/2016/7/15/563
[2]: http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=893485e74c37669aeecf0b648dbfbd8e2f0471c3
[3]: https://lkml.org/lkml/2016/9/12/907
-------

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.9

for you to fetch changes up to 39936ae1ab1dee28cc1479294bd76d16f3ea7792:

  arm64: dts: apm: Add DT node for APM X-Gene 2 CPU clocks (2016-09-15
11:19:39 -0700)

----------------------------------------------------------------
X-gene DTS changes queued for v4.9

This change set includes:
+ DTS entry to enable SoC PMU for X-Gene v1 SoC
+ DTS entry to enable SoC PMU for X-Gene v2 SoC
+ PCIe legacy interrupt polarity fix for X-Gene
+ X-Gene SoC hwmon DTS entry
+ DTS entries for X-Gene v2 CPU clock

----------------------------------------------------------------
Duc Dang (2):
      arm64: dts: apm: Add APM X-Gene v2 SoC PMU DTS entries
      arm64: dts: apm: Fix interrupt polarity for X-Gene PCIe legacy interrupts

Tai Nguyen (1):
      arm64: dts: apm: Add APM X-Gene SoC PMU DTS entries

hotran (2):
      arm64: dts: apm: Add X-Gene SoC hwmon to device tree
      arm64: dts: apm: Add DT node for APM X-Gene 2 CPU clocks

 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 135 +++++++++++++++++++++++++++--
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 103 +++++++++++++++++-----
 2 files changed, 210 insertions(+), 28 deletions(-)
