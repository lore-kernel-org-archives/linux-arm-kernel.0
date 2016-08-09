From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  9 Aug 2016 10:52:14 +0200
Subject: [PATCH 0/3] Add Platform MHU mailbox driver for Amlogic GXBB
Message-ID: <1470732737-18391-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support Mailbox links for the Amlogic GXBB SoC, add a generic
platform MHU driver based on arm_mhu.c.

This patchset follows a RFC thread along the GXBB SCPI support at :
http://lkml.kernel.org/r/1466503374-28841-1-git-send-email-narmstrong at baylibre.com
And specific MHU discussions at :
http://lkml.kernel.org/r/CABb+yY3HqJG2+GMWCWF9PomxobrwWGZ=TZe5NvXPcHMDdLhkcQ at mail.gmail.com

Changes since RFC v2 :
 - Rename to platform_mhu
 - Sync all link functions with arm_mhu

Neil Armstrong (3):
  mailbox: Add Platform Message-Handling-Unit variant driver
  dt-bindings: mailbox: Add Amlogic Meson MHU Bindings
  ARM64: dts: meson-gxbb: Add Meson MHU Node

 .../devicetree/bindings/mailbox/meson-mhu.txt      |  33 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   8 +
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/platform_mhu.c                     | 203 +++++++++++++++++++++
 5 files changed, 256 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.txt
 create mode 100644 drivers/mailbox/platform_mhu.c

-- 
2.7.0
