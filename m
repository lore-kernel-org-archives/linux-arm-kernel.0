From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 15 Apr 2013 22:53:17 +0530
Subject: [GIT PULL 1/3] ARM: davinci: DT updates for v3.10 (part 2)
Message-ID: <1366046599-6590-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull these DaVinci DT updates for v3.10?
The SPI patches were waiting for Grant's ack. Grant hasn't
responded but the changes are pretty non-controversial.

One patch removes wild-cards in binding names and ties
them to complete part numbers. Another patch documents
the bindings. This patch should have gone in last merge
window itself since the bindings were accepted in v3.9
itself. Rest of the patches just make use of accepted
bindings.

Thanks,
Sekhar

The following changes since commit db4c8fa7c0214c83cbbc990ba630b3b613fcf7c5:

  ARM: davinci: da850: override mmc DT node device name (2013-04-04 16:58:10 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.10/dt-2

for you to fetch changes up to 24a1415d10718d10231e2284fb8fbeff44d3641d:

  ARM: davinci: da850-evm: add SPI flash support (2013-04-15 12:16:52 +0530)

----------------------------------------------------------------
v3.10 DT updates for DaVinci

This set of patches adds support for PWMs and SPI
controller present on DA850 and for SPI flash present on
DA850 EVM.

----------------------------------------------------------------
Manjunathappa, Prakash (4):
      spi/davinci: no wildcards in DT compatible property
      ARM: davinci: da850: add SPI1 DT node
      ARM: davinci: da850: override SPI DT node device name
      ARM: davinci: da850-evm: add SPI flash support

Murali Karicheri (1):
      spi/davinci: add DT binding documentation

Philip Avinash (1):
      ARM: davinci: da850: add EHRPWM & ECAP DT node

 .../devicetree/bindings/spi/spi-davinci.txt        |   51 +++++++++++
 arch/arm/boot/dts/da850-evm.dts                    |   40 +++++++++
 arch/arm/boot/dts/da850.dtsi                       |   94 ++++++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c                   |    6 ++
 drivers/spi/spi-davinci.c                          |    4 +-
 5 files changed, 193 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt
