From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 May 2016 11:48:02 +0100
Subject: [PATCH 0/3] Clean up svc mode register state
Message-ID: <20160513104802.GU19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Three patches to clean up the saved register state for SW PAN:

* get rid of S_FRAME_SIZE, replacing it with PT_REGS_SIZE (which
  is what all cases of this constant actually was describing).
* provide svc_pt_regs to describe the SVC mode stack layout, which
  may contain the additional DACR register above the pt_regs.
* get rid of the horrid saved DACR access in __show_regs

 arch/arm/include/asm/assembler.h |  4 ++--
 arch/arm/include/asm/ptrace.h    | 10 ++++++++++
 arch/arm/kernel/asm-offsets.c    |  4 +++-
 arch/arm/kernel/entry-armv.S     | 12 ++++++------
 arch/arm/kernel/entry-common.S   |  2 +-
 arch/arm/kernel/entry-header.S   |  8 ++++----
 arch/arm/kernel/entry-v7m.S      |  2 +-
 arch/arm/kernel/process.c        |  2 +-
 8 files changed, 28 insertions(+), 16 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
