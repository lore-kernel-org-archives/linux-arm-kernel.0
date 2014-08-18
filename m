From: nm@ti.com (Nishanth Menon)
Date: Mon, 18 Aug 2014 11:56:53 -0500
Subject: [PATCH 0/2] clk: ti: Fix up error checks in set_rate (and div 0 error)
Message-ID: <1408381015-16042-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
The following patches are based on v3.17-rc1
Prior to this series: http://slexy.org/view/s20QH6PW4x (notice the /0 div error spam at initial boot log)
After this series: http://slexy.org/view/s20tPNXPf4

Nishanth Menon (2):
  clk: ti: divider: Provide error check for incoming parameters in
    set_rate
  clk: ti: dra7-atl: Provide error check for incoming parameters in
    set_rate

 drivers/clk/ti/clk-dra7-atl.c |    6 +++++-
 drivers/clk/ti/divider.c      |    7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
1.7.9.5
