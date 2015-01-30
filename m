From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 30 Jan 2015 21:39:28 +0100
Subject: [GIT PULL] ARM: rockchip: third (and last) batch of dts updates for
 3.20
Message-ID: <1557277.LNNjscMhd1@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

if it is not to late, I have accumulated some more dts changes during the
last days.

The most interesting change is probably enabling the display nodes on
both the rk3288-firefly and rk3288-evb. I was sucessfully able to reach a
framebuffer console on both boards using the hdmi output.

To reach an actual X-session, a further patch to the drm driver is
necessary [0], but still the general framebuffer output is working
nonetheless.


Second most interesting change is the addition of cpu and gpu regulators
to the act8846 variant of the evb which I was able to realize and test with
the help of Daniel Lezcano yesterday.


And finally adding a clock node to the rk3288 watchdog, as the dw_wdt
driver needs to read the actual clock rate at times. This brings with it a
stable shared branch with the clock tree to hold the new dt clock ids,
which Mike merged into the clock-tree half an hour after I send the
second pull request some days ago.


So if it's not to late, please pull


Thanks
Heiko


[0] https://patchwork.kernel.org/patch/5747931/


The following changes since commit 11ff8c86d74002cb493407742fd1c128055e1abe:

  ARM: dts: rockchip: add dts for ChipSPARK Rayeager PX2 board (2015-01-26 02:15:36 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.20-rockchip-dts3

for you to fetch changes up to c25d8cbcd840b2c9774a285ea728e72dd56aea2e:

  ARM: dts: rockchip: move the hdmi ddc-i2c-bus property to the actual boards (2015-01-30 00:10:59 +0100)

----------------------------------------------------------------
Change are regulator nodes for the cpu and gpu regulators on the act8846
variant of the rk3288-evb and the setting of a clock for the watchdog.
Also the lcd and hdmi controllers on both the firefly and the evb get
enabled and let us now boot into fbcon console sucessfully.

----------------------------------------------------------------
Heiko Stuebner (7):
      clk: rockchip: add id for watchdog pclk on rk3288
      Merge branch 'v3.20-clk/new-ids' into v3.20-armsoc/dts
      ARM: dts: rockchip: add rk3288 watchdog clock
      ARM: dts: rockchip: add cpu and gpu regulators to rk3288-evb-act8846
      ARM: dts: rockchip: housekeeping off i2c0 on rk3288-evb boards
      ARM: dts: rockchip: enable vops and hdmi output on rk3288-firefly and -evb
      ARM: dts: rockchip: move the hdmi ddc-i2c-bus property to the actual boards

Huang Lin (1):
      clk: rockchip: add clock IDs for the PVTM clocks

Kever Yang (1):
      clk: rockchip: add clock ID for usbphy480m_src

 arch/arm/boot/dts/rk3288-evb-act8846.dts | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-evb-rk808.dts   |  1 -
 arch/arm/boot/dts/rk3288-evb.dtsi        | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi    | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi            |  2 +-
 include/dt-bindings/clock/rk3288-cru.h   |  4 ++++
 6 files changed, 80 insertions(+), 2 deletions(-)
