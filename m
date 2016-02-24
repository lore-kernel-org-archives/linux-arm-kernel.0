From: johnyoun@synopsys.com (John Youn)
Date: Tue, 23 Feb 2016 19:54:54 -0800
Subject: [PATCH v2 0/2] usb: dwc2: Remove host and gadget only code from core
Message-ID: <cover.1456285777.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series moves the host/gadget-specific code from core.c to hcd.c
and gadget.c so that they will be compiled only when their respective
configurations are selected, or in DRD.

This is mostly just a straight move of the code. I have also added
some comments to group related functions together.

Compiled and tested in all three modes.

This should also solve the issue reported here:
http://marc.info/?l=linux-usb&m=145591813410106&w=2

Although I wasn't able to test it... couldn't figure out how to
disable CONFIG_USB and enable DWC2 in gadget mode.

Felipe,

This should be applied after Doug's series on your testing/next
branch.

Regards,
John

v2:
* Addressed issues from Douglas Anderson
* Restored comments on dwc2_calc_frame_interval()
* Made some functions static and removed their prototypes from headers
* Added tags

John Youn (2):
  usb: dwc2: Move register save and restore functions
  usb: dwc2: Move host-specific core functions into hcd.c

 drivers/usb/dwc2/core.c   | 1959 ---------------------------------------------
 drivers/usb/dwc2/core.h   |   37 +-
 drivers/usb/dwc2/gadget.c |  102 +++
 drivers/usb/dwc2/hcd.c    | 1959 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/usb/dwc2/hcd.h    |    8 +
 5 files changed, 2033 insertions(+), 2032 deletions(-)

-- 
2.6.3
