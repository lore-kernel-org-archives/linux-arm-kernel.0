From: sangwook.lee@linaro.org (Sangwook Lee)
Date: Wed, 29 Feb 2012 12:41:21 +0000
Subject: [PATCH 0/2] add ehci-s5p AHB burst function
Message-ID: <1330519283-4722-1-git-send-email-sangwook.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable burst transfer from AHB for EHCI.
This fixes data transfer issue of USB Ethernet with EHCI.
Without this patch, ping works and network utilities such as scp hardly works.

It was tested on Origen board with the following configs.
root at linaro-alip:~# lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=s5p-ehci/3p, 480M
   |__ Port 1: Dev 2, If 0, Class=vend., Driver=MOSCHIP usb-ethernet driver, 480M


Sangwook Lee (2):
  ARM: EXYNOS: Add EHCI AHB burst function
  USB: ehci-s5p: add function for burst

 arch/arm/mach-exynos/setup-usb-phy.c      |    6 ++++++
 arch/arm/plat-samsung/devs.c              |    2 ++
 arch/arm/plat-samsung/include/plat/ehci.h |   19 +++++++++++++++++++
 drivers/usb/host/ehci-s5p.c               |    3 +++
 4 files changed, 30 insertions(+), 0 deletions(-)

-- 
1.7.4.1
