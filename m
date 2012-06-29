From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 29 Jun 2012 16:35:24 +0530
Subject: [RFC PATCH 0/3] I2C: Report the actual transferred bytes 
Message-ID: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the I2C core reports only a negative number on errors.
However some of the users in case of errors want to re-transfer only
the remaining bytes.

The patch series tries to add a actual field to the msg which
can be checked by the user.

Also a patch to implement the actual bytes transferred in case of
i2c-omap.


Felipe Balbi (1):
  i2c: omap: implement handling for 'actual' bytes transferred

Shubhrajyoti D (2):
  i2c: add 'actual' field to struct i2c_msg
  i2c: inititalise the actual transferred to zero

 drivers/i2c/busses/i2c-omap.c |    5 +++++
 drivers/i2c/i2c-core.c        |    4 ++--
 include/linux/i2c.h           |    1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
1.7.5.4
