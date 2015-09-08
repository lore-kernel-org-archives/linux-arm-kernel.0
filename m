From: emilio.lopez@collabora.co.uk (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue,  8 Sep 2015 09:07:43 -0300
Subject: [PATCH 0/3] platform/chrome: vboot context support
Message-ID: <1441714066-5599-1-git-send-email-emilio.lopez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for reading and writing the verified boot context
nvram space on the EC using the cros_ec sysfs interface.

The first patch fixes is_visible() functionality, making it work for binary
attributes as well as normal ones. This is needed so the sysfs group
can be hidden when the EC doesn't offer any space for the context.

The second patch is the actual code implementing the interface to read
and write the context data.

The third patch adds the DT properties on peach boards which, judging by
the vendor tree, use the EC to store the verified boot context.

The series was tested on a peach pi and was found to work OK there. As
always, all comments and further tests are welcome :)

Cheers!
Emilio

Emilio L?pez (3):
  sysfs: Fix is_visible() support for binary attributes
  platform/chrome: Support reading/writing the vboot context
  ARM: dts: Enable EC vboot context support on Peach boards

 Documentation/devicetree/bindings/mfd/cros-ec.txt |   4 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts        |   1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts         |   1 +
 drivers/platform/chrome/Makefile                  |   5 +-
 drivers/platform/chrome/cros_ec_dev.c             |   1 +
 drivers/platform/chrome/cros_ec_vbc.c             | 137 ++++++++++++++++++++++
 fs/sysfs/group.c                                  |  22 +++-
 include/linux/mfd/cros_ec.h                       |   1 +
 8 files changed, 167 insertions(+), 5 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_vbc.c

-- 
2.1.4
