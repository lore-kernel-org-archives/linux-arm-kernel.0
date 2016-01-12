From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 12 Jan 2016 14:37:20 +0100
Subject: [PATCH v2 0/2] regulator: Add support for parallel regulators
Message-ID: <1452605842-9317-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On some boards, devices consuming a lot of power cannot use a single
regulator, but few of them in parallel to spread the consumption.

In such a case, we must ensure that all these regulators are kept in
sync.

Since this is something that is totally board specific, it should
obviously not be handle by each and every customer drivers that might
be driving a device wired this way on a particular board.

Instead, we implemented a regulator driver that just aggregates
several parent regulators and just forwards the regulators calls to
them.

Let me know what you think,
Maxime

Changes from v1:
  - Added documentation
  - Fixed an error in the is_enabled callback returned value
  - Unwind the enable and disable callbacks in case of a failure
  - Added a depency on CONFIG_OF
  - Added the missing module device table

Maxime Ripard (2):
  regulator: Add coupled regulator
  ARM: sunxi: chip: Add Wifi chip

 .../bindings/regulator/coupled-voltage.txt         |  18 ++
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  44 ++-
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/coupled-voltage-regulator.c      | 299 +++++++++++++++++++++
 5 files changed, 369 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/coupled-voltage.txt
 create mode 100644 drivers/regulator/coupled-voltage-regulator.c

-- 
2.6.4
