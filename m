From: ayaka@soulik.info (Randy Li)
Date: Thu,  7 Jul 2016 02:22:57 +0800
Subject: [PATCH 0/3] ARM: dts: the dts support for rk3288 firefly reload
In-Reply-To: <3015470.z4L7UQJKa9@phil>
References: <3015470.z4L7UQJKa9@phil>
Message-ID: <1467829380-16242-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3288 firefly reload  is a Rockchip RK3288 based board be found by
core board and main board. The regulators are connected in a different
way to the previous version of firefly boards, it is necessary to
move some common code to uncommon place.

I only tested the ethernet and confirmed that works.
The usb in this board won't caused by the bugs in the driver.

This version follow the suggests from Heiko Stuebner,
except the duplicated supply name problem, I don't think
it could be fixed in that way.

Randy Li (3):
  ARM: dts: add label leds for rk3288-firefly.dtsi
  ARM: dts: move regulator settings from common to specifics
  ARM: dts: add rk3288-firefly-reload

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/rk3288-firefly-beta.dts   |  30 ++++++++
 arch/arm/boot/dts/rk3288-firefly-reload.dts | 109 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dts        |  30 ++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi       |  16 ++--
 5 files changed, 178 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload.dts

-- 
2.7.4
