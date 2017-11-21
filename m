From: awallis@codeaurora.org (Adam Wallis)
Date: Tue, 21 Nov 2017 12:18:08 -0500
Subject: [PATCH 0/2] usb: xhci: addition of timing quirk
Message-ID: <1511284690-3878-1-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems that allow CPUs to run at an extremely reduced frequency,
it is possible to create an "interrupt" storm by USB settings that are not
ideal at these speeds. This patch series introduces a quirk bit that currently
only touches the Interrupt Control register but might be used in the future
with other similar registers. This change allows for firmware (or scripts)
to set these registers as required in place of using hard-coded values
which might not be ideal for all platforms.

Adam Wallis (2):
  usb: xhci: add relaxed timing quirk bit
  usb: host: xhci-plat: check relaxed timing quirk bit

 Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
 drivers/usb/host/xhci-plat.c                       |  3 +++
 drivers/usb/host/xhci.c                            | 25 +++++++++++++++-------
 drivers/usb/host/xhci.h                            |  1 +
 4 files changed, 22 insertions(+), 8 deletions(-)

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
