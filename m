From: robherring2@gmail.com (Rob Herring)
Date: Sat,  4 Aug 2012 20:23:55 -0500
Subject: [PATCH v2 0/5] Use more asm-generic headers
Message-ID: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Inspired by the AArgh64 claim that it should be separate from ARM and one
reason was being able to use more asm-generic headers. Doing a diff of
arch/arm/include/asm and include/asm-generic there are numerous asm
headers which are functionally identical to their asm-generic counterparts
and others which can use more of the generic versions.

V2 separates unaligned.h and termios.h changes to separate patches. Also,
it adds a fix for build failures on non-gzip decompressor compile.

Rob

Rob Herring (5):
  ARM: use generic version of identical asm headers
  ARM: add strstr declaration for decompressors
  ARM: use generic unaligned.h
  ARM: use generic termios.h
  ARM: convert asm/irqflags.h to use asm-generic/irqflags.h

 arch/arm/boot/compressed/decompress.c |    3 +
 arch/arm/include/asm/Kbuild           |   17 +++
 arch/arm/include/asm/current.h        |   15 ---
 arch/arm/include/asm/exec.h           |    6 -
 arch/arm/include/asm/ipcbuf.h         |    1 -
 arch/arm/include/asm/irqflags.h       |  131 ++++++++--------------
 arch/arm/include/asm/msgbuf.h         |   31 ------
 arch/arm/include/asm/param.h          |   31 ------
 arch/arm/include/asm/parport.h        |   18 ---
 arch/arm/include/asm/segment.h        |   11 --
 arch/arm/include/asm/sembuf.h         |   25 -----
 arch/arm/include/asm/serial.h         |   19 ----
 arch/arm/include/asm/shmbuf.h         |   42 -------
 arch/arm/include/asm/socket.h         |   72 ------------
 arch/arm/include/asm/sockios.h        |   13 ---
 arch/arm/include/asm/termbits.h       |  198 ---------------------------------
 arch/arm/include/asm/termios.h        |   92 ---------------
 arch/arm/include/asm/timex.h          |    6 +-
 arch/arm/include/asm/types.h          |   16 ---
 arch/arm/include/asm/unaligned.h      |   19 ----
 20 files changed, 67 insertions(+), 699 deletions(-)
 delete mode 100644 arch/arm/include/asm/current.h
 delete mode 100644 arch/arm/include/asm/exec.h
 delete mode 100644 arch/arm/include/asm/ipcbuf.h
 delete mode 100644 arch/arm/include/asm/msgbuf.h
 delete mode 100644 arch/arm/include/asm/param.h
 delete mode 100644 arch/arm/include/asm/parport.h
 delete mode 100644 arch/arm/include/asm/segment.h
 delete mode 100644 arch/arm/include/asm/sembuf.h
 delete mode 100644 arch/arm/include/asm/serial.h
 delete mode 100644 arch/arm/include/asm/shmbuf.h
 delete mode 100644 arch/arm/include/asm/socket.h
 delete mode 100644 arch/arm/include/asm/sockios.h
 delete mode 100644 arch/arm/include/asm/termbits.h
 delete mode 100644 arch/arm/include/asm/termios.h
 delete mode 100644 arch/arm/include/asm/types.h
 delete mode 100644 arch/arm/include/asm/unaligned.h

-- 
1.7.9.5
