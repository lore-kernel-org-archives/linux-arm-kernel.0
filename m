From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Thu, 05 Oct 2017 14:11:49 +0200
Subject: [PATCHv3 0/2] dwc3 on XU3
In-Reply-To: <6935498c-9788-14e6-844f-f9e8288026dc@samsung.com>
References: <6935498c-9788-14e6-844f-f9e8288026dc@samsung.com>
 <CGME20171005121201eucas1p2d8e7c3bf18b24ffaa0bf9593dcffe37e@eucas1p2.samsung.com>
Message-ID: <1507205511-23048-1-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the third version of patches in this thread.

The series fixes problems with enumerating of SuperSpeed devices
on an Odroid XU3. There was a patch series from Vivek Gautam in
circulation, but it got lost somehow. Please see:

https://lkml.org/lkml/2014/9/2/166
https://lkml.org/lkml/2015/2/2/257

I adapted his patch so that it does not use a hacky solution to force
additional initialization in order for calibration to happen.
With this patch enumeration happens correctly and a super speed device
is recognized as such.

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
