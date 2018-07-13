From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Fri, 13 Jul 2018 23:09:12 +0200
Subject: [PATCH/RFT 0/6] i2c: recovery: fix GPIO usage for recovery
Message-ID: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have sent the last patch of this series before, but then I realized I need to
convert all users of GPIO recovery before. I needed to make sure they all set
the SDA GPIO to output, this is what patches 3-5 are doing. Which is also good
for them because then they can send STOP at apropriate places when doing
recovery.

Then, I noticed that two drivers were not using the open drain mode for SCL
which seems like a bug to me. So, patches 1+2 address that. I'd think those two
are stable material.

Due to no hardware, I could only build test these patches. I'd be really
looking forward to comments or tests of these patches.

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/recovery-sda-output

Thanks,

   Wolfram


Wolfram Sang (6):
  i2c: designware: use open drain for recovery GPIO
  i2c: imx: use open drain for recovery GPIO
  i2c: designware: set SDA as output for recovery
  i2c: davinci: set SDA as output for recovery
  i2c: imx: set SDA as output for recovery
  i2c: recovery: remove bogus check if SDA GPIO is set to output

 drivers/i2c/busses/i2c-davinci.c           | 3 ++-
 drivers/i2c/busses/i2c-designware-master.c | 4 ++--
 drivers/i2c/busses/i2c-imx.c               | 4 ++--
 drivers/i2c/i2c-core-base.c                | 4 +---
 4 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.11.0
