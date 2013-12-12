From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 15:38:38 -0600
Subject: [PATCH 0/7] usb: dwc3: pm_runtime implementation
Message-ID: <1386884325-11440-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all,

these patches add pm_runtime support for all glue layers.

I plan to add pm_runtime support for dwc3 after these
patches are merged upstream.

Please test.

Felipe Balbi (7):
  usb: dwc3: keystone: add basic PM support
  usb: dwc3: omap: add basic pm_runtime support
  usb: dwc3: pci: add pm_runtime support
  usb: dwc3: omap: fix pm_runtime usage
  usb: dwc3: omap: fix order of pm_runtime vs child removal
  usb: dwc3: exynos: remove DEV_PM_OPS hackery
  usb: dwc3: exynos: add pm_runtime support

 drivers/usb/dwc3/dwc3-exynos.c   | 73 +++++++++++++++++++++++-------
 drivers/usb/dwc3/dwc3-keystone.c | 97 ++++++++++++++++++++++++++++++++++++++--
 drivers/usb/dwc3/dwc3-omap.c     | 45 +++++++++++++++----
 drivers/usb/dwc3/dwc3-pci.c      | 66 ++++++++++++++++++++-------
 4 files changed, 239 insertions(+), 42 deletions(-)

-- 
1.8.4.GIT
