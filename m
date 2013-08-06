From: pawel.moll@arm.com (Pawel Moll)
Date: Tue,  6 Aug 2013 19:54:19 +0100
Subject: [PATCH 0/5] ARM: vexpress: TC2 MCPC/SPC again, the complete series
Message-ID: <1375815264-29414-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've folded all Olof's changes and my modification into the original
patches, hope it's fine. If not I'll push the branch out with
full history.

I haven't tested them yet and I really really have to go
home now, but the code builds fine. I'll test them tomorrow with
Lorenzo's help.

Lorenzo Pieralisi (1):
  ARM: vexpress/TC2: add Serial Power Controller (SPC) support

Nicolas Pitre (3):
  ARM: vexpress/dcscb: fix cache disabling sequences
  ARM: vexpress/TC2: basic PM support
  ARM: vexpress/TC2: implement PM suspend method

Pawel Moll (1):
  ARM: vexpress: Add SCC & SPC to V2P-CA15_A7's device tree

 .../devicetree/bindings/arm/vexpress-spc.txt       |  30 ++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  11 +
 arch/arm/mach-vexpress/Kconfig                     |   8 +
 arch/arm/mach-vexpress/Makefile                    |   1 +
 arch/arm/mach-vexpress/dcscb.c                     |  58 ++--
 arch/arm/mach-vexpress/spc.c                       | 246 +++++++++++++++++
 arch/arm/mach-vexpress/spc.h                       |  25 ++
 arch/arm/mach-vexpress/tc2_pm.c                    | 305 +++++++++++++++++++++
 drivers/platform/Kconfig                           |   1 -
 9 files changed, 663 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-spc.txt
 create mode 100644 arch/arm/mach-vexpress/spc.c
 create mode 100644 arch/arm/mach-vexpress/spc.h
 create mode 100644 arch/arm/mach-vexpress/tc2_pm.c

-- 
1.8.1.2
