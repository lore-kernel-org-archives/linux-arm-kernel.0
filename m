From: pawel.moll@arm.com (Pawel Moll)
Date: Wed,  7 Aug 2013 16:09:43 +0100
Subject: [PATCH v2 0/5] ARM: vexpress: TC2 MCPM/SPC again, the complete series
Message-ID: <1375888188-30213-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

A couple of iterations later and it seems we have solution.
SCC bindings are back and SPC driver is simply getting
the base address from the TC2 PM code during the initialization.

That way we've got clean situation now, and can make proper
MFD driver for SCC in future. As I said - all your changes are folded
into the original patches.

Lorenzo tested the series and it still works, so this time (hopefully)
we're ready for 3.12...

The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git tags/tc2-pm

for you to fetch changes up to e607b0f985f5277324e3fdce5bb462ef4eac4bc9:

  ARM: vexpress/TC2: implement PM suspend method (2013-08-07 14:55:54 +0100)

----------------------------------------------------------------
>From Nicolas Pitre:
- Fixes to the existing Vexpress DCSCB backend.

- Lorenzo's minimal SPC driver required by the TC2 MCPM backend.

- The MCPM backend enabling SMP secondary boot and CPU hotplug
  on the VExpress TC2 big.LITTLE platform.

- MCPM suspend method to the TC2 backend allowing basic CPU
  idle/suspend.  The cpuidle driver that hooks into this will be
  submitted separately.

----------------------------------------------------------------
Lorenzo Pieralisi (1):
  ARM: vexpress/TC2: add Serial Power Controller (SPC) support

Nicolas Pitre (3):
  ARM: vexpress/dcscb: fix cache disabling sequences
  ARM: vexpress/TC2: basic PM support
  ARM: vexpress/TC2: implement PM suspend method

Pawel Moll (1):
  ARM: vexpress: Add SCC to V2P-CA15_A7's device tree

 .../devicetree/bindings/arm/vexpress-scc.txt       |  33 ++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   6 +
 arch/arm/mach-vexpress/Kconfig                     |   8 +
 arch/arm/mach-vexpress/Makefile                    |   1 +
 arch/arm/mach-vexpress/dcscb.c                     |  58 ++--
 arch/arm/mach-vexpress/spc.c                       | 180 +++++++++++
 arch/arm/mach-vexpress/spc.h                       |  24 ++
 arch/arm/mach-vexpress/tc2_pm.c                    | 344 +++++++++++++++++++++
 8 files changed, 633 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-scc.txt
 create mode 100644 arch/arm/mach-vexpress/spc.c
 create mode 100644 arch/arm/mach-vexpress/spc.h
 create mode 100644 arch/arm/mach-vexpress/tc2_pm.c

-- 
1.8.1.2
