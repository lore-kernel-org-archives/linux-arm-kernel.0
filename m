From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 19 Nov 2012 10:39:52 +0100
Subject: [PATCH 0/4] Dove pinctrl fixes and DT enabling
Message-ID: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With other Orion SoCs moving to DT enabled pinctrl and gpio drivers,
now also move Dove to them. This patch set first fixes some issues
introduced during the first release of dove pinctrl and now. Then it
moves Dove to DT pinctrl and gpio and enables a gpio led pinhog for
CuBox.

This patch relies on a patch set for mvebu pinctrl taken through
Linus' pinctrl branch. As there is no other platform than Dove 
involved, I suggest to take it though Jason's tree to avoid any
further conflicts.

Axel Lin (1):
  pinctrl: mvebu: Fix dove_audio1_ctrl_set function

Sebastian Hesselbarth (3):
  pinctrl: mvebu: fix iomem pointer for dove pinctrl
  ARM: Dove: Convert to DT GPIO and pinctrl
  ARM: Dove: Add CuBox pinhog for led

 arch/arm/Kconfig                     |    2 ++
 arch/arm/boot/dts/dove-cubox.dts     |   10 ++++++++++
 arch/arm/boot/dts/dove.dtsi          |   20 +++++++++++++++++---
 drivers/pinctrl/mvebu/pinctrl-dove.c |   22 +++++++++++++++-------
 4 files changed, 44 insertions(+), 10 deletions(-)
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Axel Lin <axel.lin@ingics.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.7.10.4
