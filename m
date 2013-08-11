From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 11 Aug 2013 15:26:48 +0100
Subject: [PATCH 0/2] Convert power recovery pin to a fixed regulator
Message-ID: <1376231210-6484-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform code to pull the power recovery pin high is broken, since
it's called too early for to register the GPIO. This has probably been
the case for some time and I'd not noticed.

This was the last bit of platform-specific code, so the second patch
tidies up.

I don't really like using a regulator for this, it's a configuration
option that's only vaguely related to power. However, this does at
least work. A separate driver could be written, but the code noise that
generates seems even worse.

This is based on mevbu's for-next (git://git.infradead.org/linux-mvebu.git
for-next), and tested on a DNS-320.

Jamie Lentin (2):
  Convert power recovery pin to a fixed regulator
  Remove all remaining trace of DNS-320/325 platform code

 arch/arm/boot/dts/kirkwood-dnskw.dtsi | 13 +++++++++++++
 arch/arm/configs/kirkwood_defconfig   |  1 -
 arch/arm/mach-kirkwood/Kconfig        |  8 --------
 arch/arm/mach-kirkwood/Makefile       |  1 -
 arch/arm/mach-kirkwood/board-dnskw.c  | 36 -----------------------------------
 arch/arm/mach-kirkwood/board-dt.c     |  3 ---
 arch/arm/mach-kirkwood/common.h       |  6 ------
 7 files changed, 13 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/board-dnskw.c

-- 
1.8.3.1
