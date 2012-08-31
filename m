From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 31 Aug 2012 09:52:53 +0200
Subject: [PATCH 0/2] dts for i2c-omap: fix incorrect adapter id
Message-ID: <1346399575-7285-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset fixes the i2c adapter id on OMAP3 and OMAP4/AM33xx when booting
from a device tree.

Currently, pdev->id is used, regardless of the boot method. The first patch
checks for of_node, and get the id from the alias if a device tree is found.
The boot message is updated accordingly.

The second patch add the necessary aliases for OMAP3, OMAP4 and AM33xx.

This patchset applies on 3.6-rc3 and has been tested on OMAP3 (Gumstix Overo).

Regards,

Florian


Florian Vaussard (2):
  i2c-omap: Fix incorrect adapter id when booting from a device tree
  arm/dts: Add i2c aliases for OMAP3 and OMAP4/AM33xx

 arch/arm/boot/dts/am33xx.dtsi |    3 +++
 arch/arm/boot/dts/omap3.dtsi  |    3 +++
 arch/arm/boot/dts/omap4.dtsi  |    4 ++++
 drivers/i2c/busses/i2c-omap.c |   19 +++++++++++++++----
 4 files changed, 25 insertions(+), 4 deletions(-)

-- 
1.7.5.4
