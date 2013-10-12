From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 12 Oct 2013 17:09:34 +0800
Subject: [PATCH 00/12] Add power management support for MXS PHY
Message-ID: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

The serial adds power management support for MXS PHY, it includes:

- Add three common PHY API, .set_wakeup, .notify_suspend, notify_resume.
- Related above API implementation at mxs phy driver
- misc changes for mxs phy to support low power mode and wakeup.

Hi Shawn,

The last four are devicetree related patches to support above
mxs phy features.

Peter Chen (12):
  usb: phy-mxs: Add auto clock and power setting
  usb: phy-mxs: Enable IC fixes for mx6 SoC serial
  usb: phy-mxs: Add anatop regmap
  usb: phy: add notify suspend and resume callback
  usb: phy-mxs: Add implementation of nofity_suspend and notify_resume
  usb: phy: Add set_wakeup API
  usb: phy-mxs: Add implementation of set_wakeup
  usb: phy-mxs: Add system suspend/resume API
  usb: phy-mxs: update binding for adding anatop phandle
  ARM: dts: imx6: add anatop phandle for usbphy
  usb: phy-mxs: update binding for adding disconnect line property
  ARM: dts: imx6: Add disconnect_line_without_vbus property for usbphy

 Documentation/devicetree/bindings/usb/mxs-phy.txt |    6 +
 arch/arm/boot/dts/imx6qdl.dtsi                    |    3 +
 drivers/usb/phy/phy-mxs-usb.c                     |  247 ++++++++++++++++++++-
 include/linux/usb/phy.h                           |   39 ++++
 4 files changed, 291 insertions(+), 4 deletions(-)
