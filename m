From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 15 Mar 2018 23:20:53 +0100
Subject: [GIT PULL 1/4] Rockchip driver changes for 4.17
Message-ID: <12470502.BUvxkRrZk8@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below the main Rockchip-related changes for 4.17.
The individual tags should explain things nicely but overall it's a pretty
standard set of changes without anything special standing out.

So if things look ok, please pull!

Thanks
Heiko


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.17-rockchip-drivers-1

for you to fetch changes up to b1271993aa3855bda5073c6061a095fd6e6febc6:

  soc: rockchip: power-domain: Add a sanity check on pd->num_clks (2018-03-05 19:42:29 +0100)

----------------------------------------------------------------
Rockchip soc drivers containing conversion of the power-domain driver
to use the clk-bulk APIs and two more socs to disable jtag-switching.
On the plus-side the issue we see with that are _supposed_ to be fixed
in hardware in upcoming socs, so maybe this can be the last of those.

----------------------------------------------------------------
Jeffy Chen (2):
      soc: rockchip: power-domain: use clk_bulk APIs
      soc: rockchip: power-domain: Add a sanity check on pd->num_clks

Shawn Lin (1):
      soc: rockchip: disable jtag switching for RK3228/RK3229 SoCs

Xiao Yao (1):
      soc: rockchip: disable jtag switching for RK3128 SoCs

 drivers/soc/rockchip/grf.c        | 28 ++++++++++++
 drivers/soc/rockchip/pm_domains.c | 95 +++++++++++++++++++--------------------
 2 files changed, 75 insertions(+), 48 deletions(-)
