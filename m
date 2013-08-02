From: jason@lakedaemon.net (Jason Cooper)
Date: Fri,  2 Aug 2013 15:51:07 +0000
Subject: [RFC PATCH V2 0/9] impedance-matcher generic improvements
In-Reply-To: <51F2A014.7000209@gmail.com>
References: <51F2A014.7000209@gmail.com>
Message-ID: <cover.1375457714.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

Here's a new version of my attempt to make this code generically useful.  I've
tested this on my dreamplug both using the commandline
'loadaddrs=appended,0x0700000' and appending all kirkwood*.dtb's.

It's still hacky and can't update the dtb yet.  But it definitely works.

To make it work for the Raumfeld boards, you'll need to change board-raumfeld.c
to use the proper compatible strings for the boards.  Then, in the Makefile,
change your uart address and MFG.

For folks interested in testing:

  git://git.infradead.org/users/jcooper/impedance-matcher.git generic

btw - this is the first time I've needed to tinker with linker scripts, so if
it looks wrong, please let me know!

thx,

Jason.

Jason Cooper (9):
  add cscope Makefile target
  separate common functions from board specific
  rename board.c to board-raumfeld.c
  s/.name/.compatible/
  directly include needed headers
  serial: split out 8250 code, configurable reg addr
  add generic board code
  make appending images/dtbs optional
  appended dtbs works!

 .gitignore        |   2 +-
 Makefile          |  59 +++++++++++++--------
 append_dtbs.sh    |   8 +++
 atags.h           |  10 ++++
 board-dreamplug.c |  28 ++++++++++
 board-generic.c   |  39 ++++++++++++++
 board-raumfeld.c  | 150 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 board.c           |  88 --------------------------------
 board.h           |  10 ++--
 dtbs.c            |  36 +++++++++++++
 dtbs.h            |   6 +++
 endian.h          |  12 +++++
 fdt.h             |  64 +++++++++++++++++++++++
 led.c             |  54 --------------------
 led.h             |   6 ---
 main.c            |  47 ++++++++---------
 matcher.lds       |   8 ++-
 print.c           |   8 +--
 print.h           |   2 +
 register.c        |  11 ++++
 register.h        |   9 ++++
 serial-8250.c     |  21 ++++++++
 serial.h          |  10 ++++
 string.c          |  99 +++++++++++++++++++++++++++++++++++
 string.h          |   9 ++++
 types.h           |   1 +
 26 files changed, 590 insertions(+), 207 deletions(-)
 create mode 100755 append_dtbs.sh
 create mode 100644 board-dreamplug.c
 create mode 100644 board-generic.c
 create mode 100644 board-raumfeld.c
 delete mode 100644 board.c
 create mode 100644 dtbs.c
 create mode 100644 dtbs.h
 create mode 100644 endian.h
 create mode 100644 fdt.h
 delete mode 100644 led.c
 delete mode 100644 led.h
 create mode 100644 register.c
 create mode 100644 register.h
 create mode 100644 serial-8250.c
 create mode 100644 serial.h
 create mode 100644 string.c
 create mode 100644 string.h

-- 
1.8.3.2
