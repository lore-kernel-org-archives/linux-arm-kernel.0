From: noralf@tronnes.org (=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=)
Date: Tue, 27 Sep 2016 13:56:58 +0200
Subject: [PATCH v2 0/8] i2c: bcm2835: Bring in changes from downstream
Message-ID: <1474977426-3272-1-git-send-email-noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset tries to bring in the lessons learned in the downstream
driver i2c-bcm2708. The downstream clock stretcing timeout patch has
been left out since clock stretching is broken/unreliable on this
controller, so no point in setting it.

This second version of the patchset has been expanded to try and
encompass all the differences between mainline and downstream.
Hopefully downstream can now start using this driver.

Thanks to Martin for jogging my memory with his comments which led to
the discovery that interrupt could be used instead of polling for the
Transfer Active state.

Noralf.


Noralf Tr?nnes (8):
  i2c: bcm2835: Fix hang for writing messages larger than 16 bytes
  i2c: bcm2835: Protect against unexpected TXW/RXR interrupts
  i2c: bcm2835: Use ratelimited logging on transfer errors
  i2c: bcm2835: Can't support I2C_M_IGNORE_NAK
  i2c: bcm2835: Add support for Repeated Start Condition
  i2c: bcm2835: Support i2c-dev ioctl I2C_TIMEOUT
  i2c: bcm2835: Add support for dynamic clock
  ARM: bcm2835: Disable i2c2 in the Device Tree

 arch/arm/boot/dts/bcm2835-rpi.dtsi |   4 -
 drivers/i2c/busses/i2c-bcm2835.c   | 210 +++++++++++++++++++++++--------------
 2 files changed, 131 insertions(+), 83 deletions(-)

--
2.8.2
