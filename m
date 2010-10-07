From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Thu,  7 Oct 2010 03:57:16 +0300
Subject: [PATCH 0/3] mxc: mx51: Add support for efikamx nettop
Message-ID: <cover.1286412080.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches add basic support for the Genesi EfikaMX nettop[1].
Serial port and OTG is enabled for now. Ethernet hangs off of OTG.

The new machine name has been agreed with Russell[2].

Regards,
Amit

[1] http://www.genesi-usa.com/
[2] http://www.spinics.net/lists/arm-kernel/msg98960.html


Amit Kucheria (3):
  mx51: add support for genesi efikamx nettop
  mx51: efikamx: add otg support
  mx51: Move OTG initialisation for all boards to a single file

 arch/arm/mach-mx5/Kconfig              |    7 ++
 arch/arm/mach-mx5/Makefile             |    3 +-
 arch/arm/mach-mx5/board-cpuimx51.c     |   25 +--------
 arch/arm/mach-mx5/board-mx51_babbage.c |   25 +--------
 arch/arm/mach-mx5/board-mx51_efikamx.c |  100 ++++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/usb.c                |   40 +++++++++++++
 6 files changed, 151 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-mx51_efikamx.c
 create mode 100644 arch/arm/mach-mx5/usb.c
