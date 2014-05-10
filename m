From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 10 May 2014 15:26:57 +0530
Subject: [PATCH 0/6] usb: host: Cleanup for ioremap'ing hcd memory
Message-ID: <1399715823-19839-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on 'usb-next' branch of Greg's usb tree.

devm_ioremap_resource() API is advantageous over devm_ioremap()
and should therefore be preferred to request any ioremap'ed address
for hcd.

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

 drivers/usb/host/ehci-exynos.c |    3 +--
 drivers/usb/host/ehci-msm.c    |    3 +--
 drivers/usb/host/ehci-mv.c     |    8 ++------
 drivers/usb/host/ehci-spear.c  |    9 +--------
 drivers/usb/host/ehci-tegra.c  |    3 +--
 drivers/usb/host/ohci-exynos.c |    3 +--
 6 files changed, 7 insertions(+), 22 deletions(-)

-- 
1.7.10.4
