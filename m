From: noralf@tronnes.org (=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=)
Date: Mon,  3 Oct 2016 22:06:07 +0200
Subject: [PATCH v4 0/7] i2c: bcm2835: Bring in changes from downstream
Message-ID: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset tries to bring in the lessons learned in the downstream
driver i2c-bcm2708. The downstream clock stretcing timeout patch has
been left out since clock stretching is broken/unreliable on this
controller, so no point in setting it.

Changes since version 3:
- Add comment about I2C_C_CLEAR on error

Noralf.


Noralf Tr?nnes (7):
  i2c: bcm2835: Fix hang for writing messages larger than 16 bytes
  i2c: bcm2835: Protect against unexpected TXW/RXR interrupts
  i2c: bcm2835: Use dev_dbg logging on transfer errors
  i2c: bcm2835: Can't support I2C_M_IGNORE_NAK
  i2c: bcm2835: Add support for Repeated Start Condition
  i2c: bcm2835: Support i2c-dev ioctl I2C_TIMEOUT
  i2c: bcm2835: Add support for dynamic clock

 drivers/i2c/busses/i2c-bcm2835.c | 218 +++++++++++++++++++++++++--------------
 1 file changed, 139 insertions(+), 79 deletions(-)

--
2.8.2
