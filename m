From: user@jinso.co.jp (Nguyen Viet Dung)
Date: Mon,  1 Jul 2013 19:00:07 +0900
Subject: [PATCH 0/4] ARM: shmobile: r8a7790: add I2C support
Message-ID: <1372672810-20609-1-git-send-email-user@jinso.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nguyen Viet Dung <nv-dung@jinso.co.jp>

Hello,
CC Morimoto

Please consider the following patches for the r8a7790 Soc.
These patches add I2C support for the r8a7790 Soc.
These patches was developed base on the renesas-next-20130528 branch.
Input clock of I2C is peripheral module clock.
It is named peripheral_clk in clock code. 
These patches have tested on the lager board.

Thanks,
Nguyen viet Dung

Nguyen Viet Dung (4):
  i2c: rcar: modify I2C driver
  ARM: shmobile: r8a7790: add I2C setup
  ARM: shmobile: r8a7790: add I2C clock
  ARM: shmobile: lager: register channels of I2C

 arch/arm/mach-shmobile/board-lager.c          |   11 ++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c        |   11 ++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c        |   28 +++++++++++++++++++++++++
 drivers/i2c/busses/i2c-rcar.c                 |   17 +++++++++++++--
 include/linux/i2c/i2c-rcar.h                  |    4 ++++
 6 files changed, 72 insertions(+), 2 deletions(-)

-- 
1.7.9.5
