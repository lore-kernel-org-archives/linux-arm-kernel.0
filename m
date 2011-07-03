From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon,  4 Jul 2011 02:45:23 +0400
Subject: [PATCH V3 0/2] Suspend for gpio-vbus
Message-ID: <1309733125-10869-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V1 version of these patches generated quite a lot of comments.
Now I'd like to present an updated version of this patchset.

Changes since V2:
* Really include all promised features. Blaming git format-patch :(

Changes since V1:
* Switch to using dev_pm_ops instead of platform_driver hooks
* Move suspend/resume to _noirq (LATE) to be sure that otg transceiver
 suspends after the main UDC driver.

Dmitry Eremin-Solenikov (2):
      gpio-vbus: support disabling D+ pullup on suspend
      mioa701: move gpio-pullup functionality to gpio-vbus

 arch/arm/mach-pxa/mioa701.c   |    8 +-----
 drivers/usb/otg/gpio_vbus.c   |   42 +++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/gpio_vbus.h |    1 +
 3 files changed, 45 insertions(+), 6 deletions(-)
