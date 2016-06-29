From: andi.shyti@gmail.com (andi.shyti at gmail.com)
Date: Wed, 29 Jun 2016 17:45:08 +0300
Subject: [PATCH v2 0/2] use the CLK_IS_CRITICAL flag for critical clocks
Message-ID: <1467211510-3485-1-git-send-email-andi@etezian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andi Shyti <andi@etezian.org>

Hi,

this patchset is the first of a series and it aims to remove
the handling of critical clock on the rockchip clock drivers.

Patch 32b9b10961860860268961d9aad0c56a73018c37 has added a
generic clock critical handling that can be used from the
drivers.

After a discussion with Heiko, the clock rockchip would need a
hand-off functionality, but this is getting delayed. Anyway,
because I have the patches ready I'll send them anyway, if the
hand-off property is going to come soon, then please feel free to
reject the patchset.

Thanks,
Andi

Andi Shyti (2):
  clk: clk-rk3*: set CLK_IS_CRITICAL flag to critical clocks
  clk: rockchip: remove unused rockchip_clk_protect_critical function

 drivers/clk/rockchip/clk-rk3036.c | 17 ++-------
 drivers/clk/rockchip/clk-rk3188.c | 25 +++---------
 drivers/clk/rockchip/clk-rk3228.c | 17 ++-------
 drivers/clk/rockchip/clk-rk3288.c | 17 ++-------
 drivers/clk/rockchip/clk-rk3368.c | 21 ++--------
 drivers/clk/rockchip/clk-rk3399.c | 80 +++++++++++----------------------------
 drivers/clk/rockchip/clk.c        | 14 -------
 drivers/clk/rockchip/clk.h        |  1 -
 8 files changed, 44 insertions(+), 148 deletions(-)

-- 
2.8.1
