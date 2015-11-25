From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 25 Nov 2015 15:59:32 +0800
Subject: [PATCH 0/5] Fix a trivial typo and support rk3228/rk3399 SoCs for
 thermal driver.
Message-ID: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series pacthes to support the next soc for this thermal driver.
I don't have add the dts thermal data since these SoCs have *_not_* land
in this mailline. I believe these SoCs dts will land in this mainline,
then add the thermal data for Heiko.

This series patches can apply into Eduardo branch.
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git

Also, this series pacthes have build on github branch.
https://github.com/rockchip-linux/kernel/commits/develop4.4

PATCH[1/5]:
That's bit ugly typo, sorry for sending again :(.

PATCH[2/5]:
To fix a build warning came from Dan Carpenter report smatch check,
Thanks. :)

PATCH[3/5]:
Add the rk3228/rk339 SoCs compatible for dt-bindings.

PATCH[4/5]:
Add the rk3228 SoCs for thermal driver.

PATCH[5/5]:
Add the rk3399 SoCs for thermal driver.



Caesar Wang (5):
  thermal: rockchip: fix a trivial typo
  thermal: rockchip: fix a impossible condition caused by the warning
  dt-bindings: rockchip-thermal: Support the RK3228/RK3399 SoCs
    compatible
  thermal: rockchip: Support the RK3228 SoCs in thermal driver
  thermal: rockchip: Support the RK3399 SoCs in thermal driver

 .../bindings/thermal/rockchip-thermal.txt          |   2 +
 drivers/thermal/rockchip_thermal.c                 | 159 ++++++++++++++++++++-
 2 files changed, 155 insertions(+), 6 deletions(-)

-- 
1.9.1
