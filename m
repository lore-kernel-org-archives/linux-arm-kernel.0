From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 10 May 2014 17:30:04 +0530
Subject: [PATCH v2 0/6] usb: host: Cleanup for ioremap'ing hcd memory
Message-ID: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on 'usb-next' branch of Greg's usb tree.

devm_ioremap_resource() API is advantageous over devm_ioremap()
and should therefore be preferred to request any ioremap'ed address
for hcd.

Changes from v1:
 - Changed the way returned pointer is checked for error value
   as pointed out in the review comment in the mailing list.

Vivek Gautam (6):
  usb: host: ehci-exynos: Use devm_ioremap_resource instead of
    devm_ioremap
  usb: host: ehci-msm: Use devm_ioremap_resource instead of
    devm_ioremap
  usb: host: ehci-mv: Use devm_ioremap_resource instead of devm_ioremap
  usb: host: ehci-spear: Use devm_ioremap_resource instead of
    devm_ioremap
  usb: host: ehci-tegra: Use devm_ioremap_resource instead of
    devm_ioremap
  usb: host: ohci-exynos: Use devm_ioremap_resource instead of
    devm_ioremap

 drivers/usb/host/ehci-exynos.c |    7 +++----
 drivers/usb/host/ehci-msm.c    |    7 +++----
 drivers/usb/host/ehci-mv.c     |   16 ++++++----------
 drivers/usb/host/ehci-spear.c  |   13 +++----------
 drivers/usb/host/ehci-tegra.c  |    7 +++----
 drivers/usb/host/ohci-exynos.c |    7 +++----
 6 files changed, 21 insertions(+), 36 deletions(-)

-- 
1.7.10.4
