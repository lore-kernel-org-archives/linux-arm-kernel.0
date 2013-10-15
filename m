From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 16 Oct 2013 01:06:42 +0200
Subject: [PATCH v2 0/5] pinctrl: rockchip: add rk3188 support
Message-ID: <201310160106.42329.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A patch series, finalizing support for the pin controller in the  rk3188.

As mentioned in the individual patches, the rk3188 makes it even more
complex due to its strange pull setting configuration. Therefore a bit
of reordering needed to take place to accomodate this.

changes since v1:
- remove the of_device_is_any_of nonsense, as of_match_node is perfectly
  capable to reach the same goal, as pointed out by Mark Rutland

Heiko Stuebner (5):
  pinctrl: rockchip: separate different sub-types more
  pinctrl: rockchip: add support for multiple bank types
  pinctrl: rockchip: remove redundant check
  pinctrl: rockchip: add rk3188 specifics
  pinctrl: rockchip: emulate both edge triggered interrupts

 .../bindings/pinctrl/rockchip,pinctrl.txt          |   46 ++-
 drivers/pinctrl/pinctrl-rockchip.c                 |  292 +++++++++++++++-----
 2 files changed, 274 insertions(+), 64 deletions(-)

-- 
1.7.10.4
