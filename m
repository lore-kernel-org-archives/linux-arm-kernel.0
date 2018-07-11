From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 12 Jul 2018 00:32:37 +0800
Subject: [RFC PATCH 0/2] mailbox: imx-mailbox: add SCU protocol support
Message-ID: <1531326759-20556-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is per Sascha's reques to implemented SCU protocol support
based on Oleksij's generic mailbox driver for communicate with M4.

That driver is also still under review.
https://www.spinics.net/lists/arm-kernel/msg659013.html

Due to the protocol is totally different, most of code can
not be reused for SCU. So we implement a separate mbox_chan_ops
for SCU protocol to avoid mixing the difference.

Dong Aisheng (2):
  dt-bindings: arm: fsl: add mu binding doc
  mailbox: imx-mailbox: add scu protocol support

 .../devicetree/bindings/mailbox/fsl,mu.txt         |  34 +++
 drivers/mailbox/Kconfig                            |   6 +-
 drivers/mailbox/imx-mailbox.c                      | 252 ++++++++++++++++++---
 3 files changed, 257 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt

-- 
2.7.4
