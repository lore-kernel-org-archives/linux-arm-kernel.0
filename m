From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 25 May 2016 11:47:44 +0800
Subject: [PATCH v3 0/5] Thermal: Support for hardware-tracked trip points
Message-ID: <1464148069-26254-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The history patches come from Mikko and Sascha.
    http://thread.gmane.org/gmane.linux.power-management.general/59451

Now, I pick them up to continue upstream.
Nevermind!

This series history patches:
v2: https://lkml.org/lkml/2016/5/3/220
v1: https://lkml.org/lkml/2016/4/24/227

This series adds support for hardware trip points. It picks up earlier
work from Mikko Perttunen. Mikko implemented hardware trip points as part
of the device tree support. It was suggested back then to move the
functionality to the thermal core instead of putting more code into the
device tree support. This series does exactly that.

This series patches rebase the conflicts.
Note that the hardware-tracked trip points are very well tested currently.

Verified and tested on https://github.com/Caesar-github/rockchip/tree/wip/fixes-thermal-0525
That's based on linux-kernel 20160524.


Changes in v3:
- as Javi comments on https://patchwork.kernel.org/patch/9001281/.
- add the lock for preventing the called from multi placce
- add the note for pre_low/high_trip.
- as the Javi comments on https://patchwork.kernel.org/patch/9001311/.
- add the select if they set the option for devicetree.
- Add the peter's ACK.

Changes in v2:
- update the sysfs-api.txt for set_trips.
- add the commit in patch[v2 2/5].
- Update the commit for patch[v2 4/5].

Caesar Wang (1):
  thermal: rockchip: add the set_trips function

Sascha Hauer (4):
  thermal: Add support for hardware-tracked trip points
  thermal: of: implement .set_trips for device tree thermal zones
  thermal: streamline get_trend callbacks
  thermal: bang-bang governor: act on lower trip boundary

 Documentation/thermal/sysfs-api.txt                |  7 +++
 drivers/thermal/gov_bang_bang.c                    |  2 +-
 drivers/thermal/of-thermal.c                       | 30 ++++++++-----
 drivers/thermal/rockchip_thermal.c                 | 39 ++++++++++++++++
 drivers/thermal/thermal_core.c                     | 52 ++++++++++++++++++++++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 ++++-------
 include/linux/thermal.h                            | 13 +++++-
 7 files changed, 139 insertions(+), 29 deletions(-)

-- 
1.9.1
