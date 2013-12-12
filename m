From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Dec 2013 09:18:48 +0800
Subject: [PATCH 0/3] regulator: act8865: add PMIC driver
Message-ID: <1386811131-2720-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liam and Mark,

The patch set is to add act8865 PMIC driver.

The active-semi act8865 is designed as a PMIC for Atmel sama5d3x and at91sam9 series.
Its datasheet is available at: http://www.active-semi.com/sheets/ACT8865_Datasheet.pdf.

The patches is based on the branch: for-next of git respository, 
	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
and [PATCH] regulator: read low power states configuration from device tree from Vincent Palatin
	https://patchwork.kernel.org/patch/2833667/

Thanks.

Best Regards,
Wenyou Yang

Wenyou Yang (3):
  regulator: act8865: add PMIC(Power Management IC) driver
  regulator: act8865: add device tree binding doc
  ARM: dts: sama5d3xcm: add the regulator device node

 .../bindings/regulator/act8865-regulator.txt       |   58 +++
 arch/arm/boot/dts/sama5d3xcm.dtsi                  |   47 ++
 drivers/regulator/Kconfig                          |    7 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/act8865-regulator.c              |  516 ++++++++++++++++++++
 include/linux/regulator/act8865.h                  |   56 +++
 6 files changed, 685 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/act8865-regulator.txt
 create mode 100644 drivers/regulator/act8865-regulator.c
 create mode 100644 include/linux/regulator/act8865.h

-- 
1.7.9.5
