From: stefan@agner.ch (Stefan Agner)
Date: Fri, 28 Nov 2014 17:43:33 +0100
Subject: [PATCH 0/2] ARM: imx: src: vf610 system reset controller
Message-ID: <1417193015-6033-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a system reset controller handler for Vybrid SoC family.
There is already a driver for the SRC (system reset controller)
module for i.MX6, but since the module in Vybrid is a bit different
I descided to create a new file (there are several MISC registers
with various functionality in the Vybrid case).

I'm not sure if it is acceptable to have that code still in the
machine folder. However, since the current i.MX6 implementation
is located there too, and the module has various functionality
we need for instance from suspend/resume code (future pm-vf610.c),
I descided to put it into the machine folder. If it needs to go
under driver/, my question is how can I properly export the
functionality (e.g. DDR Reset control on standby in MISC_2 or
SRC_GPR), from the PM code located in the machine folder.

Stefan Agner (2):
  ARM: dts: vf610: add system reset controller (SRC)
  ARM: imx: src: support vf610 system reset controller

 arch/arm/boot/dts/vf500.dtsi   |  4 ++++
 arch/arm/boot/dts/vfxxx.dtsi   |  5 ++++
 arch/arm/mach-imx/Makefile     |  2 +-
 arch/arm/mach-imx/common.h     |  1 +
 arch/arm/mach-imx/mach-vf610.c |  8 +++++++
 arch/arm/mach-imx/src-vf610.c  | 53 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/src-vf610.c

-- 
2.1.3
