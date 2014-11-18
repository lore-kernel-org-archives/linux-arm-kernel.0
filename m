From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 18 Nov 2014 17:04:52 +0100
Subject: [PATCH 0/3] i2c: slave support framework for Linux devices
Message-ID: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finally, here is my take on the often desired feature that Linux can not only
be an I2C master, but also an I2C slave. Since RFC, most open issues have been
dealt with. Find details in the patch descriptions. Documentation is still
missing and will come later this or next week, but surely early enough for
the 3.19 release which this series wants to go in. Yet, I'd like to encourage
code-review and build-testing already.

Basically, an I2C slave is a standard I2C client providing a callback function.
When registering as a slave, the connection to the I2C adapter is made which
uses the callback when a slave event happens. That splits the HW support
(enabling slave mode on the adapter) and SW support (here a generic eeprom
simulator) nicely IMO.

The patches have been tested with a Renesas R8A7790 based Lager board. They are
based on top of 3.18-rc5, but will easily apply to renesas/devel. A git tree
can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/slave-support

Comments welcome! Thanks,

   Wolfram


Wolfram Sang (3):
  i2c: core changes for slave support
  i2c: slave-eeprom: add eeprom simulator driver
  i2c: rcar: add slave support

 drivers/i2c/Kconfig            |  10 +++
 drivers/i2c/Makefile           |   1 +
 drivers/i2c/busses/i2c-rcar.c  | 125 +++++++++++++++++++++++++++---
 drivers/i2c/i2c-core.c         |  49 ++++++++++++
 drivers/i2c/i2c-slave-eeprom.c | 170 +++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h            |  29 +++++++
 6 files changed, 375 insertions(+), 9 deletions(-)
 create mode 100644 drivers/i2c/i2c-slave-eeprom.c

-- 
2.1.1
