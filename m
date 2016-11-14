From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 14 Nov 2016 19:44:38 +0100
Subject: [GIT PULL] ARM: at91: drivers for 4.10
Message-ID: <20161114184438.k5ysd6pgcadlo5vw@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

A few fixes for the memory drivers and the support for the Secure SRAM
found on sama5d2.

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.10-drivers

for you to fetch changes up to 2ae2e28852f21ec9efc527c1f3ecc5f7c7e27e42:

  misc: sram: add Atmel securam support (2016-11-07 23:43:28 +0100)

----------------------------------------------------------------
Drivers for 4.10:

 - few fixes for the memory drivers
 - minimal security module driver
 - support for the Secure SRAM

----------------------------------------------------------------
Alexandre Belloni (4):
      Documentation: dt: atmel-at91: Document secumod bindings
      ARM: at91: add secumod register definitions
      misc: sram: document new compatible
      misc: sram: add Atmel securam support

Wei Yongjun (2):
      memory: atmel-ebi: fix return value check in at91_ebi_dev_disable()
      memory: atmel-sdramc: use builtin_platform_driver to simplify the code

 .../devicetree/bindings/arm/atmel-at91.txt         | 16 +++++++++
 Documentation/devicetree/bindings/sram/sram.txt    |  2 +-
 drivers/memory/atmel-ebi.c                         |  2 +-
 drivers/memory/atmel-sdramc.c                      |  6 +---
 drivers/misc/sram.c                                | 42 ++++++++++++++++++----
 include/soc/at91/atmel-secumod.h                   | 19 ++++++++++
 6 files changed, 73 insertions(+), 14 deletions(-)
 create mode 100644 include/soc/at91/atmel-secumod.h

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/287d05f1/attachment-0001.sig>
