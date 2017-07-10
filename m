From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 10 Jul 2017 10:01:34 +0200
Subject: [PATCH v2 0/2] media: Add Amlogic Meson AO CEC Controller support
Message-ID: <1499673696-21372-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic SoC embeds a standalone CEC controller, this patch adds a driver
for such controller.
The controller does not need HPD to be active, and could support up to max
5 logical addresses, but only 1 is handled since the Suspend firmware can
make use of this unique logical address to wake up the device.

The Suspend firmware configuration will be added in an other patchset.

Changes since v1 at [1] :
 - add timeout to wait busy, with error return
 - handle busy error in all read/write operations
 - add CEC_CAP_PASSTHROUGH
 - add bindings ack

[1] https://lkml.kernel.org/r/1499336870-24118-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (2):
  platform: Add Amlogic Meson AO CEC Controller driver
  dt-bindings: media: Add Amlogic Meson AO-CEC bindings

 .../devicetree/bindings/media/meson-ao-cec.txt     |  28 +
 drivers/media/platform/Kconfig                     |  11 +
 drivers/media/platform/Makefile                    |   2 +
 drivers/media/platform/meson/Makefile              |   1 +
 drivers/media/platform/meson/ao-cec.c              | 781 +++++++++++++++++++++
 5 files changed, 823 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/meson-ao-cec.txt
 create mode 100644 drivers/media/platform/meson/Makefile
 create mode 100644 drivers/media/platform/meson/ao-cec.c

-- 
1.9.1
