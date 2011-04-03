From: John.Linn@xilinx.com (John Linn)
Date: Sun, 3 Apr 2011 12:44:49 -0600
Subject: [GIT PULL] Xilinx ARM support for 2.6.40
Message-ID: <e090f8f9-edc6-47f9-9519-81b252262c64@VA3EHSMHS029.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This is a resend from last week as my new machine lost me email settings
and it was sent in html rather than plain text.  This should be better.

Please pull Xilinx ARM changes for the next merge window from the
following.

git://git.xilinx.com/linux-2.6-xlnx arm-next

This branch contains support for the Xilinx ARM platform on the EP107
board.

I got this tree into linux-next. If there's something else I need to do
please let me know.  

Thanks for your help,
John

The following changes since commit
0ce790e7d736cedc563e1fb4e998babf5a4dbc3d:
  Linus Torvalds (1):
        Linux 2.6.39-rc1

are available in the git repository at:

  git://git.xilinx.com/linux-2.6-xlnx arm-next

John Linn (4):
      ARM: Xilinx: Adding Xilinx board support
      ARM: Xilinx: Adding timer support to the platform
      ARM: Xilinx: base header files and assembly macros
      ARM: Xilinx: Adding Xilinx platform infrastructure support

arch/arm/Kconfig                                |   14 +
arch/arm/Makefile                               |    1 +
arch/arm/mach-xilinx/Kconfig                    |   14 +
arch/arm/mach-xilinx/Makefile                   |    7 +
arch/arm/mach-xilinx/Makefile.boot              |    3 +
arch/arm/mach-xilinx/board_ep107.c              |   85 +++++++
arch/arm/mach-xilinx/common.c                   |  114 +++++++++
arch/arm/mach-xilinx/common.h                   |   30 +++
arch/arm/mach-xilinx/include/mach/clkdev.h      |   33 +++
arch/arm/mach-xilinx/include/mach/debug-macro.S |   36 +++
arch/arm/mach-xilinx/include/mach/entry-macro.S |   30 +++
arch/arm/mach-xilinx/include/mach/hardware.h    |   18 ++
arch/arm/mach-xilinx/include/mach/io.h          |   33 +++
arch/arm/mach-xilinx/include/mach/irqs.h        |   29 +++
arch/arm/mach-xilinx/include/mach/memory.h      |   23 ++
arch/arm/mach-xilinx/include/mach/system.h      |   28 +++
arch/arm/mach-xilinx/include/mach/timex.h       |   23 ++
arch/arm/mach-xilinx/include/mach/uart.h        |   25 ++
arch/arm/mach-xilinx/include/mach/uncompress.h  |   51 ++++
arch/arm/mach-xilinx/include/mach/vmalloc.h     |   20 ++
arch/arm/mach-xilinx/include/mach/xilinx_soc.h  |   48 ++++
arch/arm/mach-xilinx/timer.c                    |  297
+++++++++++++++++++++++
arch/arm/mm/Kconfig                             |    2 +-
23 files changed, 963 insertions(+), 1 deletions(-)
create mode 100644 arch/arm/mach-xilinx/Kconfig
create mode 100644 arch/arm/mach-xilinx/Makefile
create mode 100644 arch/arm/mach-xilinx/Makefile.boot
create mode 100644 arch/arm/mach-xilinx/board_ep107.c
create mode 100644 arch/arm/mach-xilinx/common.c
create mode 100644 arch/arm/mach-xilinx/common.h
create mode 100644 arch/arm/mach-xilinx/include/mach/clkdev.h
create mode 100644 arch/arm/mach-xilinx/include/mach/debug-macro.S
create mode 100644 arch/arm/mach-xilinx/include/mach/entry-macro.S
create mode 100644 arch/arm/mach-xilinx/include/mach/hardware.h
create mode 100644 arch/arm/mach-xilinx/include/mach/io.h
create mode 100644 arch/arm/mach-xilinx/include/mach/irqs.h
create mode 100644 arch/arm/mach-xilinx/include/mach/memory.h
create mode 100644 arch/arm/mach-xilinx/include/mach/system.h
create mode 100644 arch/arm/mach-xilinx/include/mach/timex.h
create mode 100644 arch/arm/mach-xilinx/include/mach/uart.h
create mode 100644 arch/arm/mach-xilinx/include/mach/uncompress.h
create mode 100644 arch/arm/mach-xilinx/include/mach/vmalloc.h
create mode 100644 arch/arm/mach-xilinx/include/mach/xilinx_soc.h
create mode 100644 arch/arm/mach-xilinx/timer.c

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
