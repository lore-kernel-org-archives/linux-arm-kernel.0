From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 07 Jul 2015 16:02:48 +0200
Subject: [PATCH 0/5] usb: gadget: miscellaneous fixes
Message-ID: <1436277773-14274-1-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set contains few small bugfixes found in usb gadget functions
and UDC drivers. The most important is the [1] as it fixes bug causing
BUG_ON() in f_fs driver. Remaining patches contain minor fixes.

Best regards,
Robert Baldyga

[1] usb: gadget: ffs: call functionfs_unbind() if _ffs_func_bind() fails

Robert Baldyga (5):
  usb: gadget: ffs: call functionfs_unbind() if _ffs_func_bind() fails
  usb: gadget: midi: avoid redundant f_midi_set_alt() call
  usb: isp1760: udc: add missing usb_ep_set_maxpacket_limit()
  staging: emxx_udc: add missing usb_ep_set_maxpacket_limit()
  usb: gadget: atmel_usba_udc: add missing ret value check

 drivers/staging/emxx_udc/emxx_udc.c     |  3 ++-
 drivers/usb/gadget/function/f_fs.c      | 10 +++++++++-
 drivers/usb/gadget/function/f_midi.c    |  4 ++++
 drivers/usb/gadget/udc/atmel_usba_udc.c |  4 ++++
 drivers/usb/isp1760/isp1760-udc.c       |  4 ++--
 5 files changed, 21 insertions(+), 4 deletions(-)

-- 
1.9.1
