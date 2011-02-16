From: john.linn@xilinx.com (John Linn)
Date: Wed, 16 Feb 2011 09:11:52 -0700
Subject: [PATCH V3 0/4] ARM: Basic Xilinx Support
Message-ID: <e195bee2-8509-43a8-bc1c-cf6136866dd9@VA3EHSMHS025.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


V3

I incorporated more feedback from Russell King.
Primarily clean up of the license header to remove
the address. 

Also minor cleanup of the Kconfig and Makefile for the board
to match the MACH_XILINX entry in the machine ID database.

These changes were tested on 2.6.38-rc4 and rc5.

V2

I incorporated review comments from Russell King and Jamie Iles.

Each patch has V2 comments describing the details. The order of
each patch in the series did change.

Thanks a lot to them for the detailed review as this patch set
is much cleaner and improved (I think anyway).  

Thanks for comments from Arnd and Grant also.

This was tested against 2.6.38-rc4.

----

This patch series adds very basic support for the Xilinx ARM platform.
The entire patch set must be used, I only broke it up into logical 
pieces to make the review easier (I hope). 

I would like to get the review feedback and make any changes, but after
that I need to change mach-xilinx to the real product name.  The real
product name is expected to be released by marketing very soon.

There's always the option of keeping mach-xilinx and then only 
documenting the product name in the Kconfig. I'm less in favor of that
but it could be ok.

This code has been tested against 2.6.38-rc2, r3, and against head. The
only checkpatch warnings are about volatile in the uncompress.h file
and this method I used seems normal.

Thanks,
John

 arch/arm/Kconfig                                |   13 +
 arch/arm/Makefile                               |    1 
 arch/arm/mach-xilinx/Kconfig                    |   14 +
 arch/arm/mach-xilinx/Makefile                   |    9 
 arch/arm/mach-xilinx/Makefile.boot              |    3 
 arch/arm/mach-xilinx/board_ep107.c              |   82 ++++++
 arch/arm/mach-xilinx/common.c                   |  113 ++++++++
 arch/arm/mach-xilinx/common.h                   |   31 ++
 arch/arm/mach-xilinx/include/mach/clkdev.h      |   33 ++
 arch/arm/mach-xilinx/include/mach/debug-macro.S |   36 ++
 arch/arm/mach-xilinx/include/mach/entry-macro.S |   30 ++
 arch/arm/mach-xilinx/include/mach/hardware.h    |   18 +
 arch/arm/mach-xilinx/include/mach/io.h          |   33 ++
 arch/arm/mach-xilinx/include/mach/irqs.h        |   29 ++
 arch/arm/mach-xilinx/include/mach/memory.h      |   23 +
 arch/arm/mach-xilinx/include/mach/system.h      |   28 ++
 arch/arm/mach-xilinx/include/mach/timex.h       |   24 +
 arch/arm/mach-xilinx/include/mach/uart.h        |   31 ++
 arch/arm/mach-xilinx/include/mach/uncompress.h  |   47 +++
 arch/arm/mach-xilinx/include/mach/vmalloc.h     |   20 +
 arch/arm/mach-xilinx/include/mach/xilinx_soc.h  |   47 +++
 arch/arm/mach-xilinx/timer.c                    |  302 +++++++++++++++++++++++-
 arch/arm/mm/Kconfig                             |    3 
 23 files changed, 964 insertions(+), 6 deletions(-)

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
