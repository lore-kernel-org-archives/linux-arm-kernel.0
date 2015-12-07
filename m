From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:13 +0000
Subject: [PATCH 00/19] mfd: Lots of clean-ups
Message-ID: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Over the next few months, I plan to run some of our protection systems;
Checkpatch, Smatch, Sparse and Coccinelle etc on the subsystem and do my
best to eliminate some of the issues unearthed.

This is the first submission that takes care of some (reasonable)
Checkpatch warnings/errors on files [A-D].

If MAINTAINERS lists file maintainers, they have been Cc'ed.

Lee Jones (19):
  mfd: aat2870-core: Remove unnecessary 'out of memory' message
  mfd: ab3100-core.c: Fix multiple warnings reported by Checkpatch
  mfd: ab2100-otp: Remove pointless 'out of memory' error message
  mfd: ab8500-core: Fix many warnings reported by Checkpatch
  mfd: ab8500-debugfs: Clean-up non-conforming commenting and print
    formatting
  mfd: ab8500-gpadc: Squash a whole bunch of Checkpatch warnings and one
    error
  mfd: ab8500-sysctrl: Fix Constify, printk => pr_info and formatting
    issues
  mfd: adp5520: Some trivial 'no space before tab' fixes
  mfd: arizona-core: msleep() is unreliable for anything <20ms use
    usleep_range() instead
  mfd: arizona-i2c: Add blank line formatting after declaration
  mfd: as3711: Repair OOM and 'line over 80 chars' formatting warnings
  mfd: asic3: Fix a plethora of Checkpatch errors and warnings
  mfd: cros_ec_i2c: Fix trivial 'tabs before spaces' whitespace issue.
  mfd: cros_ec_spi: Repair comparison ordering issue
  mfd: cs5535-mfd: Add missing line spacing and make local array static
  mfd: da903x: Fix white space and split string issues
  mfd: da9052-i2c: Fix tabbing/whitespace issue
  mfd: da9052-irq: Fix trivial 'space before comma' error
  mfd: davinci_voicecodec: Remove pointless 'out of memory' error
    message

 drivers/mfd/aat2870-core.c       |   5 +-
 drivers/mfd/ab3100-core.c        |  23 +++----
 drivers/mfd/ab3100-otp.c         |   5 +-
 drivers/mfd/ab8500-core.c        |  24 +++----
 drivers/mfd/ab8500-debugfs.c     |  25 ++++---
 drivers/mfd/ab8500-gpadc.c       | 145 ++++++++++++++++++++-------------------
 drivers/mfd/ab8500-sysctrl.c     |  13 ++--
 drivers/mfd/adp5520.c            |   6 +-
 drivers/mfd/arizona-core.c       |   8 +--
 drivers/mfd/arizona-i2c.c        |   2 +
 drivers/mfd/as3711.c             |  28 ++++----
 drivers/mfd/asic3.c              |  27 ++++----
 drivers/mfd/cros_ec_i2c.c        |   2 +-
 drivers/mfd/cros_ec_spi.c        |   4 +-
 drivers/mfd/cs5535-mfd.c         |   6 +-
 drivers/mfd/da903x.c             |  10 +--
 drivers/mfd/da9052-i2c.c         |   2 +-
 drivers/mfd/da9052-irq.c         |   2 +-
 drivers/mfd/davinci_voicecodec.c |   5 +-
 19 files changed, 170 insertions(+), 172 deletions(-)

-- 
1.9.1
