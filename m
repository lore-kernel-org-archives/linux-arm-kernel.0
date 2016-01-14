From: david.wu@rock-chips.com (David Wu)
Date: Thu, 14 Jan 2016 20:31:35 +0800
Subject: [PATCH v3 0/4] Add rk3399 i2c clocks calculated method
Message-ID: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3399 have updated a new way to calculate i2c timing information to slove
"repeat start" timing issue. So it needs to integrate existing method, use
different ops to seperate them.  

After picking this series, pmic-rk818 and touchscreen-ts could work well
on the rk3368 sdk board. 100k, 400k and 1.7M i2c clk rates were tested on
the rk3399 fpga board, where i2c0 connected to pmic-ti65910. But 3.4M clk
rate was not tested, because of the scl rise time is 60ns, it could not
meet the i2c spec, the scl rise time is hard to reduce on fpga board.

David Wu (4):
  i2c: rk3x: switch to i2c generic dt parsing
  i2c: rk3x: add ops to caculate i2c clocks
  i2c: rk3x: new method to caculate i2c clocks
  i2c: rk3x: support I2C Highspeed Mode

 drivers/i2c/busses/i2c-rk3x.c | 405 +++++++++++++++++++++++++++++++++---------
 1 file changed, 319 insertions(+), 86 deletions(-)

-- 
1.9.1
