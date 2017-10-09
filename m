From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Mon, 09 Oct 2017 14:00:49 +0200
Subject: [PATCHv4 0/2] dwc3 on XU3
In-Reply-To: <6de8a17a-745b-0fa2-c39d-cdeb28fc9489@ti.com>
References: <6de8a17a-745b-0fa2-c39d-cdeb28fc9489@ti.com>
 <CGME20171009120100eucas1p2400a1ee4a7c70eed37c653de780b715d@eucas1p2.samsung.com>
Message-ID: <1507550451-21324-1-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the fourth version of patches in this thread.

The series fixes problems with enumerating of SuperSpeed devices
on an Odroid XU3. There was a patch series from Vivek Gautam in
circulation, but it got lost somehow. Please see:

https://lkml.org/lkml/2014/9/2/166
https://lkml.org/lkml/2015/2/2/257

I adapted his patch so that it does not use a hacky solution to force
additional initialization in order for calibration to happen.
With this patch enumeration happens correctly and a super speed device
is recognized as such.

Changes since v3:

- improved the commit message in phy_calibrate() commit
  (as suggested by Kishon)
- rebased onto v4.14-rc4

Changes since v2:

- exported the "calibrate_phy" symbol

Changes since v1:

- added calibrate() callback to phy
- used calibrate() instead of reset() to trigger the calibration

Andrzej Pietrasiewicz (1):
  drivers: phy: add calibrate method

Vivek Gautam (1):
  phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800

 drivers/phy/phy-core.c                   |  15 +++
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 183 +++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.c                  |   7 +-
 include/linux/phy/phy.h                  |  10 ++
 4 files changed, 213 insertions(+), 2 deletions(-)

-- 
1.9.1
