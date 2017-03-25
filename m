From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 24 Mar 2017 18:04:58 -0600
Subject: [PATCH 0/7] dwc3 - bug fixes and use meaningful goto labels
Message-ID: <cover.1490387086.git.shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series consists of two fixes and changes to goto labels
to use meaningful names.

While working on goto label changes, I noticed  put_sync calls without
successful get_sync in error legs.  The first two patches are the fixes
and the rest of the patches are goto label changes.


Shuah Khan (7):
  usb: dwc3: core: fix dwc3_probe() to not do put_sync when get_sync
    fails
  usb: dwc3: dwc3-omap: fix dwc3_omap_probe() do put_sync when get_sync
    works
  usb: dwc3: core: change goto labels to meaningful names
  usb: dwc3: exynos: change goto labels in this file to meaningful names
  usb: dwc3: omap: change goto labels in this file to meaningful names
  usb: dwc3: gadget: change goto labels in this file to meaningful names
  usb: dwc3: host: change goto labels in this file to meaningful names

 drivers/usb/dwc3/core.c        | 64 +++++++++++++++++++++---------------------
 drivers/usb/dwc3/dwc3-exynos.c | 16 +++++------
 drivers/usb/dwc3/dwc3-omap.c   | 11 ++++----
 drivers/usb/dwc3/gadget.c      | 56 ++++++++++++++++++------------------
 drivers/usb/dwc3/host.c        | 10 +++----
 5 files changed, 79 insertions(+), 78 deletions(-)

-- 
2.7.4
