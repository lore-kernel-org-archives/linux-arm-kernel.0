From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 27 Nov 2015 10:52:21 +0800
Subject: [PATCH v1 0/5] Fix a trivial typo and support rk3228/rk3399 SoCs for
 thermal driver.
Message-ID: <1448592746-2129-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series pacthes to support the next soc for this thermal driver.
I don't add the dts thermal data since these SoCs have *_not_* land
in this mainline. I believe these SoCs dts will land in this mainline
lately,
then I will add the thermal data for Heiko.

This series patches can apply into Eduardo branch.
https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git

Also, this series pacthes have built on github branch.
https://github.com/rockchip-linux/kernel/commits/develop4.4

PATCH[1/5]:
That's bit ugly typo, sorry for sending again :(.

PATCH[2/5]:
To fix a build warning came from Dan Carpenter report smatch check,
Thanks. :)

PATCH[3/5]:
Add the rk3228/rk3399 SoCs compatible for dt-bindings.

PATCH[4/5]:
Add the rk3228 SoCs for thermal driver.

PATCH[5/5]:
Add the rk3399 SoCs for thermal driver based on PATCH[4/5].


Changes in v1:
- Search more trivial typo for me.
- As Heiko comments, fix a copy incorrect name.
- Add a Acked from Rob.
- fix a irq ack is similar with RK3228 SoCs.

Caesar Wang (5):
  thermal: rockchip: fix a trivial typo
  thermal: rockchip: fix a impossible condition caused by the warning
  dt-bindings: rockchip-thermal: Support the RK3228/RK3399 SoCs
    compatible
  thermal: rockchip: Support the RK3228 SoCs in thermal driver
  thermal: rockchip: Support the RK3399 SoCs in thermal driver

 .../bindings/thermal/rockchip-thermal.txt          |   2 +
 drivers/thermal/rockchip_thermal.c                 | 167 +++++++++++++++++++--
 2 files changed, 159 insertions(+), 10 deletions(-)

-- 
1.9.1
