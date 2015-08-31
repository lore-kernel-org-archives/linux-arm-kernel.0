From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 31 Aug 2015 21:09:07 +0530
Subject: [PATCH 0/2] AM437x: USB DWC3: save power during system sleep
Message-ID: <cover.1441029572.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series add support to DWC3 core to conserve
power during system sleep by setting the USB
DRVVBUS line to a lower power consuming state.

Tested to make sure USB host and device works on
AM437x with v4.2. Tested for power savings on v4.1
kernel where there is an implementation of suspend-
to-RAM for AM437x available.

Dave Gerlach (1):
  ARM: dts: am437x-gp-evm: Add pinctrl states for usb

Sekhar Nori (1):
  usb: dwc3: support for pinctrl state change during system sleep

 arch/arm/boot/dts/am437x-gp-evm.dts | 30 ++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.c             |  4 ++++
 2 files changed, 34 insertions(+)

-- 
2.4.4.408.g16da57c
