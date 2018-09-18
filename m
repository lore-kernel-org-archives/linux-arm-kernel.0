From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 18 Sep 2018 12:17:17 +0100
Subject: [GIT PULL] firmware: scmi: updates for v4.20
Message-ID: <20180918111716.GA23868@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

I have based this one on v4.19-rc3 in order to avoid conflicts with the
driver fix that went in after -rc2. Please pull !

Regards,
Sudeep

--
The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-updates-4.20

for you to fetch changes up to 1a63fe9a2b1f47af5b2b7436b41824b14999c17a:

  firmware: arm_scmi: add a getter for power of performance states (2018-09-10 17:37:06 +0100)

----------------------------------------------------------------
SCMI updates for v4.20

1. Addition of interface to fetch estimated power from the firmware
   corresponding to each OPP of a device

2. Cleanup using strlcpy to ensure NULL-terminated strings for name
   strings instead of relying on the firmware to do the same

----------------------------------------------------------------
Quentin Perret (1):
      firmware: arm_scmi: add a getter for power of performance states

Sudeep Holla (1):
      firmware: arm_scmi: use strlcpy to ensure NULL-terminated strings

 drivers/firmware/arm_scmi/base.c    |  2 +-
 drivers/firmware/arm_scmi/clock.c   |  2 +-
 drivers/firmware/arm_scmi/perf.c    | 30 +++++++++++++++++++++++++++++-
 drivers/firmware/arm_scmi/power.c   |  2 +-
 drivers/firmware/arm_scmi/sensors.c |  2 +-
 include/linux/scmi_protocol.h       |  4 ++++
 6 files changed, 37 insertions(+), 5 deletions(-)
