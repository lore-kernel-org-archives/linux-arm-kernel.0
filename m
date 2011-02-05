From: john.linn@xilinx.com (John Linn)
Date: Sat, 5 Feb 2011 09:17:13 -0700
Subject: [PATCH 0/4] ARM: Basic Xilinx Support (resend)
Message-ID: <795cbe53-f7e9-42b0-9995-47bde4137a57@VA3EHSMHS005.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


My apologies for the resend, hosed up the main kernel list (doh).

This patch series adds very basic support for the Xilinx ARM platform.
The entire patch set must be used. I only broke it up into logical 
pieces to make the review easier (I hope). 

I would like to get the review feedback and make any changes, but after
that I would like to change mach-xilinx to the real product name.  The real product name is expected to be released by marketing very soon.

There's always the option of keeping mach-xilinx and then only 
documenting the product name in the Kconfig. I'm less in favor of that
but it could be ok.

This code has been tested against 2.6.38-rc2, r3, and against head. The
only checkpatch warnings are about volatile in the uncompress.h file
and this method I used seems normal.

Thanks,
John

 arch/arm/Kconfig                                |   13 
 arch/arm/Makefile                               |    1 
 arch/arm/mach-xilinx/Kconfig                    |   14 
 arch/arm/mach-xilinx/Makefile                   |    6 
 arch/arm/mach-xilinx/Makefile.boot              |    3 
 arch/arm/mach-xilinx/board_ep107.c              |   81 ++++
 arch/arm/mach-xilinx/common.c                   |  132 +++++++
 arch/arm/mach-xilinx/common.h                   |   32 +
 arch/arm/mach-xilinx/include/mach/clkdev.h      |   33 +
 arch/arm/mach-xilinx/include/mach/debug-macro.S |   36 +
 arch/arm/mach-xilinx/include/mach/entry-macro.S |   87 ++++
 arch/arm/mach-xilinx/include/mach/hardware.h    |   44 ++
 arch/arm/mach-xilinx/include/mach/io.h          |   27 +
 arch/arm/mach-xilinx/include/mach/irqs.h        |   28 +
 arch/arm/mach-xilinx/include/mach/memory.h      |   23 +
 arch/arm/mach-xilinx/include/mach/system.h      |   28 +
 arch/arm/mach-xilinx/include/mach/timex.h       |   22 +
 arch/arm/mach-xilinx/include/mach/uart.h        |   30 +
 arch/arm/mach-xilinx/include/mach/uncompress.h  |   46 ++
 arch/arm/mach-xilinx/include/mach/vmalloc.h     |   20 +
 arch/arm/mach-xilinx/timer.c                    |  452 ++++++++++++++++++++++++
 arch/arm/mm/Kconfig                             |    4 
 22 files changed, 1160 insertions(+), 2 deletions(-)

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
