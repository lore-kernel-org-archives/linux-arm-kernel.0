From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2012 19:54:20 +0000
Subject: [PATCH 00/20] SA1111 cleanups
Message-ID: <20120203195419.GH14129@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another patch series - this time it's SA1111's turn for some attention.
This has been broken, but more recently than Neponset, by a half cooked
change to the IRQ support.

The first two patches are trivial fixes for problems I noticed with the
Neponset board.

Most of the patches speak for themselves.  It's worth noting that the
final patch in this series (which removes the static mapping for the
SA1111) conflicts with the patches in the SA1100 series posted before
this.  The conflict resolution leaves neponset without any mapio hooks
at all.

Obviously, posting this stuff as patch series doesn't lend itself to
providing a conflict resolution in patch form that people can apply with
GNU patch, so that's left out.

 arch/arm/common/sa1111.c               |  281 +++++++++++++++++++++-----------
 arch/arm/include/asm/hardware/sa1111.h |  156 +++---------------
 arch/arm/mach-pxa/lubbock.c            |    1 +
 arch/arm/mach-sa1100/badge4.c          |   21 ++-
 arch/arm/mach-sa1100/jornada720.c      |    6 +-
 arch/arm/mach-sa1100/neponset.c        |    6 +-
 drivers/input/serio/sa1111ps2.c        |   59 +++++--
 drivers/pcmcia/sa1111_generic.c        |   55 ++++++-
 drivers/usb/host/ohci-sa1111.c         |   61 +++++---
 9 files changed, 355 insertions(+), 291 deletions(-)
