From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 20 Apr 2012 23:55:28 +0200
Subject: [PULL REQUEST] stmp devices
Message-ID: <20120420215440.GA24875@nekote.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

as requested, here is the pull request for the stmp-device-series which
makes STMP devices mach independent (they are found on mxs and mx6
currently). I have rebased them to 3.4-rc3 and dropped the rtc-patch,
since it does not have a maintainer ack. I kept the I2C patch since I do
maintain I2C myself and there are no conflicts.

Please pull.

Thanks,

   Wolfram

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/wsa/linux.git stmp_device

for you to fetch changes up to 6b866c151ad9ea44799b32c3a8c90a03c5b981da:

  i2c: mxs: use global reset function (2012-04-20 23:27:18 +0200)

----------------------------------------------------------------
Wolfram Sang (2):
      lib: add support for stmp-style devices
      i2c: mxs: use global reset function

 drivers/i2c/busses/Kconfig   |    1 +
 drivers/i2c/busses/i2c-mxs.c |    9 ++---
 include/linux/stmp_device.h  |   20 +++++++++++
 lib/Kconfig                  |    3 ++
 lib/Makefile                 |    2 ++
 lib/stmp_device.c            |   80 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 108 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/stmp_device.h
 create mode 100644 lib/stmp_device.c
