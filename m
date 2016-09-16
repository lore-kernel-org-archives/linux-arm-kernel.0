From: dhdang@apm.com (Duc Dang)
Date: Fri, 16 Sep 2016 00:01:26 -0700
Subject: [GIT PULL 1/2] arm64: X-Gene driver updates queued for 4.9
Message-ID: <CADaLNDnbuQWrV6myasn2k5Mi7=jdg7FAjbdbS3GrbXY34cBfNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the driver updates for X-Gene platforms targeted for 4.9.

The change set includes:
+ X-Gene Soc PMU support patch set from Tai Nguyen (v10 reviewed by
Mark, DT binding document acked by Rob [1] and was suggested to merge
via am-soc tree by Will [2])

As we discussed, the X-Gene Soc PMU will go through arm-soc tree this
time because we don't have a dedicated tree for PMU drivers yet.
Starting from v4.10, PMU drivers will be collected by Will/Mark before
sending to arm-soc tree [3].

Regards,
Duc Dang.

[1]: https://lkml.org/lkml/2016/7/15/563
[2]: https://lkml.org/lkml/2016/7/20/224
[3]: http://www.spinics.net/lists/arm-kernel/msg532044.html
------

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-drivers-for-4.9

for you to fetch changes up to 832c927d119b5be3a01376b8e3033286eb5797e1:

  perf: xgene: Add APM X-Gene SoC Performance Monitoring Unit driver
(2016-09-15 11:20:55 -0700)

----------------------------------------------------------------
X-Gene driver changes queued for v4.9

This patch set includes:
+ X-Gene SoC Performance Monitoring Unit (PMU) driver

----------------------------------------------------------------
Tai Nguyen (3):
      MAINTAINERS: Add entry for APM X-Gene SoC PMU driver
      Documentation: Add documentation for APM X-Gene SoC PMU DTS binding
      perf: xgene: Add APM X-Gene SoC Performance Monitoring Unit driver

 .../devicetree/bindings/perf/apm-xgene-pmu.txt     |  112 ++
 Documentation/perf/xgene-pmu.txt                   |   48 +
 MAINTAINERS                                        |    7 +
 drivers/perf/Kconfig                               |    7 +
 drivers/perf/Makefile                              |    1 +
 drivers/perf/xgene_pmu.c                           | 1398 ++++++++++++++++++++
 6 files changed, 1573 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 create mode 100644 Documentation/perf/xgene-pmu.txt
 create mode 100644 drivers/perf/xgene_pmu.c
