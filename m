From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 15 Jun 2017 12:28:59 +0100
Subject: [GIT PULL] firmware: arm_scpi: updates for v4.13
Message-ID: <56eb6b7c-decb-ade3-2d74-d03f7d35c25d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC,

The cpufreq change is acked by maintainer and Rafael agreed to take it
via ARM-SoC[1]. Please pull !

Regards,
Sudeep

--

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/scpi-updates-4.13

for you to fetch changes up to c0f2e21953324def9e2f8394406b557d7cb5af64:

  cpufreq: scpi: use new scpi_ops functions to remove duplicate code
(2017-06-05 11:14:35 +0100)

----------------------------------------------------------------
SCPI update for v4.13

Adds support to get DVFS transition latency and OPP for any device whose
DVFS are managed by SCPI. This avoids code duplication in both cpufreq
and devfreq SCPI drivers.

----------------------------------------------------------------
Sudeep Holla (2):
      firmware: arm_scpi: add support to populate OPPs and get
transition latency
      cpufreq: scpi: use new scpi_ops functions to remove duplicate code

 drivers/cpufreq/scpi-cpufreq.c | 38 ++++---------------
 drivers/firmware/arm_scpi.c    | 63 +++++++++++++++++++++++++++++++++++
 include/linux/scpi_protocol.h  |  3 ++
 3 files changed, 72 insertions(+), 32 deletions(-)
