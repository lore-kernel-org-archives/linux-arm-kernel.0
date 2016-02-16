From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 16 Feb 2016 14:45:57 +0000
Subject: [GIT PULL] firmware: SCPI driver updates for v4.6
Message-ID: <56C33625.5030903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Here is the set of minor updates to SCPI firmware driver for v4.6
There's a change in HWMON driver which Guenter Roeck has Acked and
agreed to take it via arm-soc tree.

-- 
Regards,
Sudeep

-->8

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/scpi-for-v4.6/updates

for you to fetch changes up to fb3b07ef399bd6984f3361a709829618b75e98d8:

   hwmon: (scpi) add energy meter support (2016-02-16 09:26:27 +0000)

----------------------------------------------------------------
SCPI updates and fixes for v4.6

1. Minor fix to restore functionality in big-endian mode

2. Fix race by decreasing Tx timeout to 20ms

3. Adds support for 64-bit sensor values and energy meter

----------------------------------------------------------------
Sudeep Holla (4):
       firmware: arm_scpi: fix send_message and sensor_get_value for 
big-endian
       firmware: arm_scpi: decrease Tx timeout to 20ms
       firmware: arm_scpi: add support for 64-bit sensor values
       hwmon: (scpi) add energy meter support

  drivers/firmware/arm_scpi.c   | 17 ++++++++++-------
  drivers/hwmon/scpi-hwmon.c    | 14 +++++++++++---
  include/linux/scpi_protocol.h |  3 ++-
  3 files changed, 23 insertions(+), 11 deletions(-)
