From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Oct 2013 21:23:45 +0200
Subject: [GIT PULL] ux500 devicetree patches, take 3
Message-ID: <CACRpkdYyazH9KevkA=qTho3okdKnKWcq_uMwRroa6=svacfJAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this is yet another pull request for ux500 device tree stuff. It should
go on top of the second pull request, I tested to pull it on top of
ux500/dt2 in the ARM SoC tree and it worked just fine.

These are fixes and additions found during testing of the switch to
full device tree on ux500. The clock fixes will go into the -rc:s if
you don't take this in as a whole.

There is one oneline patch to the clock driver that I have not had
an ACK from Mike on, but Lee checked it and I certainly don't
think Mike has anything against it. The last patch adds the SSP
and SPI devices that were strangely absent from the platform
after the conversion.

So: please pull this into ARM SoC as ux500/dt3 or something.

Yours,
Linus Walleij


The following changes since commit 741a6c4c59cfa1266bc75aca9f66bdc6e421b0d5:

  ARM: ux500: move BU21013 touchpad GPIOs into top-level DTS
(2013-10-03 10:29:24 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dt-for-v3.13-3

for you to fetch changes up to 6e1484c2761e56bb98ec95ccdd1d98d2f67852ae:

  ARM: ux500: register all SSP and SPI blocks (2013-10-18 14:55:44 +0200)

----------------------------------------------------------------
Five incremental device tree patches around the clock handling,
and adding SSP/SPI devices to the device tree.

----------------------------------------------------------------
Linus Walleij (5):
      ARM: ux500: fix clock for GPIO block 8
      clk: ux500: fix erroneous bit assignment
      ARM: ux500: fix clock for GPIO blocks 6 and 7
      ARM: ux500: fix I2C4 clock bit
      ARM: ux500: register all SSP and SPI blocks

 arch/arm/boot/dts/ste-dbx5x0.dtsi | 83 ++++++++++++++++++++++++++++++++++++---
 drivers/clk/ux500/u8500_of_clk.c  |  2 +-
 2 files changed, 79 insertions(+), 6 deletions(-)
