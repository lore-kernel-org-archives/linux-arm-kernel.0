From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Thu,  7 Oct 2010 18:06:15 +0300
Subject: [PATCHv2 0/2] mxc: mx51: Add support for efikamx nettop
Message-ID: <cover.1286463146.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches add basic support for the Genesi EfikaMX nettop[1].
Serial port, USB OTG and Ethernet works.

The new machine name has been agreed with Russell[2].

Kernel tested on babbage 3.0 and efikamx boards.
Patches apply to the imx git tree.

Regards,
Amit

[1] http://www.genesi-usa.com/
[2] http://www.spinics.net/lists/arm-kernel/msg98960.html

Amit Kucheria (2):
  mx51: Move OTG initialisation for all boards to a single file
  mx51: add support for genesi efikamx nettop

 arch/arm/mach-mx5/Kconfig              |    8 +++
 arch/arm/mach-mx5/Makefile             |    3 +-
 arch/arm/mach-mx5/board-cpuimx51.c     |   30 +---------
 arch/arm/mach-mx5/board-mx51_babbage.c |   30 +---------
 arch/arm/mach-mx5/board-mx51_efikamx.c |   95 ++++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/usb.c                |   42 ++++++++++++++
 arch/arm/mach-mx5/usb.h                |    1 +
 7 files changed, 154 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-mx51_efikamx.c
 create mode 100644 arch/arm/mach-mx5/usb.c
 create mode 100644 arch/arm/mach-mx5/usb.h
