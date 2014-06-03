From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  3 Jun 2014 10:21:30 +0200
Subject: [RESEND PATCH v4 0/2] i2c: sunxi: add P2WI controller support
Message-ID: <1401783692-22358-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds support for the P2WI block used by some Allwinner boards
to interface with the AXP221 PMIC.

Wolfram, I sent the last version of this series almost a month ago and had
no feedback from you.

We need this code to support the "X-Powers' AXP221 PMIC + Allwinner's A31
SoC" solution (which, AFAICT, is used on most A31 boards), and the fact
that it's not merged or at least reviewed is really holding us back.

Best Regards,

Boris

Changes since v3:
- update the DT bindings doc
- fix a comment that was no longer true

Changes since v2:
- drop the initialization (switch from I2C to P2WI mode) part
- print devm_ioremap_resource err code

Changes since v1:
- implement P2WI initilization
- implement P2WI bus frequency configuration
- implement address consistency check
- fix devm_request_and_ioremap return check
- rework the macro definitions
- fix typos

[1] http://www.spinics.net/lists/linux-i2c/msg15066.html
[2] http://comments.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/8947
Boris BREZILLON (2):
  i2c: sunxi: add P2WI DT bindings documentation
  i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support

 .../devicetree/bindings/i2c/i2c-sunxi-p2wi.txt     |  41 +++
 drivers/i2c/busses/Kconfig                         |  12 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-sun6i-p2wi.c                | 349 +++++++++++++++++++++
 4 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi-p2wi.txt
 create mode 100644 drivers/i2c/busses/i2c-sun6i-p2wi.c

-- 
1.8.3.2
