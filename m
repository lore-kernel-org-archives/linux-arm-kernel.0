From: nm@ti.com (Nishanth Menon)
Date: Mon, 18 Aug 2014 15:13:28 -0500
Subject: [PATCH 0/2] Input: palmas: add support for palmas power button
Message-ID: <1408392810-16011-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many Palmas PMIC variants have support for power button feature. This
feature depends on certain One Time Program (OTP) and board pull configurations
(POWERHOLD signal). However, on many platforms such as DRA72-evm, OMAP5-uevm,
this may be used to generate input events similar to twl4030-pwrbutton.c

Series is based on v3.17-rc1
Nishanth Menon (2):
  doc: dt/bindings: input: introduce palmas power button description
  Input: misc: introduce palmas-pwrbutton

 .../bindings/input/ti,palmas-pwrbutton.txt         |   32 ++
 drivers/input/misc/Kconfig                         |   10 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/palmas-pwrbutton.c              |  313 ++++++++++++++++++++
 4 files changed, 356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
 create mode 100644 drivers/input/misc/palmas-pwrbutton.c

-- 
1.7.9.5
