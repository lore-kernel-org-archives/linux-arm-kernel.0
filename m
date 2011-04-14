From: John.Linn@xilinx.com (John Linn)
Date: Thu, 14 Apr 2011 12:04:51 -0600
Subject: [GIT PULL] Xilinx ARM support for 2.6.40
Message-ID: <9724c3f0-d6dd-4132-a0b6-4c5809a490cf@VA3EHSMHS018.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Would you please consider pulling support for the Xilinx ARM platform
into your tree for
2.6.40?

I think everything's been done to get ready. The patches have been sent
to the mailing lists
multiple times with reviews completed and comments incorporated. The
patches have been in 
linux-next for a while now also.

I realize that the tree I reference below is based on a commit after
39-rc1.  If I need to rebase
the tree to be based on a specific rc I can do that also.

Thanks for your help,
John

The following changes since commit
d7c764c4c7b782c660b4600b0bff2e3509892a4d:
  Linus Torvalds (1):
        Merge branch 'x86-fixes-for-linus' of
git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://git.xilinx.com/linux-2.6-xlnx arm-next

John Linn (4):
      ARM: Xilinx: Adding Xilinx board support
      ARM: Xilinx: Adding timer support to the platform
      ARM: Xilinx: base header files and assembly macros
      ARM: Xilinx: Adding Xilinx platform infrastructure support

 arch/arm/Kconfig                              |   14 ++
 arch/arm/Makefile                             |    1 +
 arch/arm/mach-zynq/Kconfig                    |   14 ++
 arch/arm/mach-zynq/Makefile                   |    7 +
 arch/arm/mach-zynq/Makefile.boot              |    3 +
 arch/arm/mach-zynq/board_ep107.c              |   85 +++++++
 arch/arm/mach-zynq/common.c                   |  114 ++++++++++
 arch/arm/mach-zynq/common.h                   |   30 +++
 arch/arm/mach-zynq/include/mach/clkdev.h      |   33 +++
 arch/arm/mach-zynq/include/mach/debug-macro.S |   36 +++
 arch/arm/mach-zynq/include/mach/entry-macro.S |   30 +++
 arch/arm/mach-zynq/include/mach/hardware.h    |   18 ++
 arch/arm/mach-zynq/include/mach/io.h          |   33 +++
 arch/arm/mach-zynq/include/mach/irqs.h        |   29 +++
 arch/arm/mach-zynq/include/mach/memory.h      |   23 ++
 arch/arm/mach-zynq/include/mach/system.h      |   28 +++
 arch/arm/mach-zynq/include/mach/timex.h       |   23 ++
 arch/arm/mach-zynq/include/mach/uart.h        |   25 ++
 arch/arm/mach-zynq/include/mach/uncompress.h  |   51 +++++
 arch/arm/mach-zynq/include/mach/vmalloc.h     |   20 ++
 arch/arm/mach-zynq/include/mach/zynq_soc.h    |   48 ++++
 arch/arm/mach-zynq/timer.c                    |  297
+++++++++++++++++++++++++
 arch/arm/mm/Kconfig                           |    2 +-
 23 files changed, 963 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-zynq/Kconfig
 create mode 100644 arch/arm/mach-zynq/Makefile
 create mode 100644 arch/arm/mach-zynq/Makefile.boot
 create mode 100644 arch/arm/mach-zynq/board_ep107.c
 create mode 100644 arch/arm/mach-zynq/common.c
 create mode 100644 arch/arm/mach-zynq/common.h
 create mode 100644 arch/arm/mach-zynq/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-zynq/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-zynq/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-zynq/include/mach/hardware.h
 create mode 100644 arch/arm/mach-zynq/include/mach/io.h
 create mode 100644 arch/arm/mach-zynq/include/mach/irqs.h
 create mode 100644 arch/arm/mach-zynq/include/mach/memory.h
 create mode 100644 arch/arm/mach-zynq/include/mach/system.h
 create mode 100644 arch/arm/mach-zynq/include/mach/timex.h
 create mode 100644 arch/arm/mach-zynq/include/mach/uart.h
 create mode 100644 arch/arm/mach-zynq/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-zynq/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-zynq/include/mach/zynq_soc.h
 create mode 100644 arch/arm/mach-zynq/timer.c

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
