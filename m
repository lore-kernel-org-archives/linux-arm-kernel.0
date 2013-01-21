From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 21 Jan 2013 09:56:51 +0800
Subject: [RESEND PATCH v5 0/7] Add fully tested id switch and vbus connect
 detect support for Chipidea
Message-ID: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only one typo suggestion from Marek Vasut (change "d" to "D") is added.
At this v5 version.
Anyone who have tested this patchset, please give a tested-by, thanks.

This patchset adds fully tested otg id switch function and
vbus connect/disconnect detection for chipidea driver.
The mainly design of id/vbus handling follows msm otg driver.
I hope the msm usb maintainer can have a look of this patchset,
and give some comments, and move the whole msm usb driver to
chipidea framework if possible in the future.

This patchset is fully tested at i.mx6Q saberlite board.

There is github repo for my chipdiea work:
https://github.com/hzpeterchen/linux-usb.git
branch: master

Peter Chen (7):
  Revert "USB: chipidea: add vbus detect for udc"
  usb: chipidea: add otg file
  usb: chipidea: add otg id switch and vbus connect/disconnect detect
  usb: chipidea: consolidate ci_role_driver's API for both roles
  usb: chipidea: udc: add pullup/pulldown dp at hw_device_state
  usb: chipidea: udc: retire the flag CI13_PULLUP_ON_VBUS
  usb: chipidea: imx: add internal vbus regulator control

 drivers/usb/chipidea/Makefile      |    2 +-
 drivers/usb/chipidea/bits.h        |   10 ++
 drivers/usb/chipidea/ci.h          |   30 ++++++-
 drivers/usb/chipidea/ci13xxx_imx.c |   81 +++++++++++++----
 drivers/usb/chipidea/ci13xxx_msm.c |    1 -
 drivers/usb/chipidea/core.c        |  178 +++++++++++++++++++++++++++++++-----
 drivers/usb/chipidea/host.c        |    2 +
 drivers/usb/chipidea/otg.c         |   68 ++++++++++++++
 drivers/usb/chipidea/otg.h         |    9 ++
 drivers/usb/chipidea/udc.c         |  101 ++++++++++-----------
 include/linux/usb/chipidea.h       |    1 -
 11 files changed, 382 insertions(+), 101 deletions(-)
 create mode 100644 drivers/usb/chipidea/otg.c
 create mode 100644 drivers/usb/chipidea/otg.h
