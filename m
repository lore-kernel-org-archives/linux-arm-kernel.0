From: stefan@agner.ch (Stefan Agner)
Date: Sat,  4 Jun 2016 17:17:43 -0700
Subject: [PATCH 0/5] regulator: add Ricoh RN5T567 PMIC support
Message-ID: <20160605001749.4062-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds RN5T567 PMIC support which is used on the 
Toradex Colibri iMX7S/iMX7D modules. The existing RN5T618 is from
the same family, hence this patchset uses the same driver and adds
variant support.

The Colibris currently do not use the PMIC's power off capabilities,
hence this patchset also makes the use of system-power-controller
property mandatory if the power off capabilties are required.

Stefan Agner (5):
  ARM: dts: meson: minix-neo-x8: define PMIC as power controller
  mfd: add Ricoh RN5T567 PMIC support
  regulator: rn5t618: add RN5T567 PMIC support
  mfd: rn5t618: register power off callback optionally
  mfd: rn5t618: register restart handler

 Documentation/devicetree/bindings/mfd/rn5t618.txt | 19 +++---
 arch/arm/boot/dts/meson8-minix-neo-x8.dts         |  1 +
 drivers/mfd/Kconfig                               |  7 ++-
 drivers/mfd/rn5t618.c                             | 70 +++++++++++++++++++----
 drivers/regulator/Kconfig                         |  5 +-
 drivers/regulator/rn5t618-regulator.c             | 40 +++++++++++--
 include/linux/mfd/rn5t618.h                       | 13 +++++
 7 files changed, 126 insertions(+), 29 deletions(-)

-- 
2.8.3
