From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Jun 2013 17:53:03 +0900
Subject: [PATCH v4 0/4] Renesas sh-sci updates for v3.11
Message-ID: <1372236787-23342-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

This revised pull-request includes a build-warning fix by myself.
The build-warning was reported by Arnd and has been acked by Greg
Kroah-Hartman.

I apologise that this is now coming very late in the cycle, this is
mostly due to the time it took to address the build-warning.

I also apologise that I have not yet addressed your request to
drop your addresses from the CC list of the patch emails
that follow this one. I will do so before I start sending patches
for v3.12.


The following changes since commit 018222f5d32bc5ca9fd830aebfeed10f1be96c93:

  ARM: shmobile: r8a7790: add clock definitions and aliases for MMCIF and SDHI (2013-06-12 21:07:38 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-sci-for-v3.11

for you to fetch changes up to d4759ded3bdf3eb004d583011707fdc21aeda94e:

  serial: sh-sci: Initialise variables before access in sci_set_termios() (2013-06-26 17:41:16 +0900)

----------------------------------------------------------------
Renesas sh-sci updates for v3.11

HSCIF support by Ulrich Hecht.

----------------------------------------------------------------
Simon Horman (1):
      serial: sh-sci: Initialise variables before access in sci_set_termios()

Ulrich Hecht (3):
      serial: sh-sci: HSCIF support
      ARM: shmobile: r8a7790: HSCIF support
      ARM: shmobile: r8a7790: don't use external clock for SCIFs

 arch/arm/mach-shmobile/setup-r8a7790.c |  16 ++++-
 drivers/tty/serial/sh-sci.c            | 104 ++++++++++++++++++++++++++++++---
 include/linux/serial_sci.h             |  12 +++-
 include/uapi/linux/serial_core.h       |   3 +
 4 files changed, 121 insertions(+), 14 deletions(-)
