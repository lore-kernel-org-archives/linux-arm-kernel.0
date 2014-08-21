From: nm@ti.com (Nishanth Menon)
Date: Thu, 21 Aug 2014 11:02:13 -0500
Subject: [PATCH V2 0/2] Input: palmas: add support for palmas power button
In-Reply-To: <1408392810-16011-1-git-send-email-nm@ti.com>
References: <1408392810-16011-1-git-send-email-nm@ti.com>
Message-ID: <1408636935-29515-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many Palmas PMIC variants have support for power button feature. This
feature depends on certain One Time Program (OTP) and board pull
configurations (POWERHOLD signal). However, on many platforms such
as DRA72-evm, OMAP5-uevm, this may be used to generate input events
similar to twl4030-pwrbutton.c

Series is based on v3.17-rc1

V2 of the series incorporating comments from http://marc.info/?l=linux-input&m=140839287431882&w=2

Nishanth Menon (2):
  doc: dt/bindings: input: introduce palmas power button description
  Input: misc: introduce palmas-pwrbutton

 .../bindings/input/ti,palmas-pwrbutton.txt         |   36 ++
 drivers/input/misc/Kconfig                         |   10 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/palmas-pwrbutton.c              |  356 ++++++++++++++++++++
 4 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
 create mode 100644 drivers/input/misc/palmas-pwrbutton.c

-- 
1.7.9.5
