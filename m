From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Mon, 4 Mar 2013 18:29:11 +0530
Subject: [PATCH v2 0/4] Enable SPI flash support on da850-evm DT kernel
Message-ID: <1362401955-9616-1-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch enables support for m25p64 SPI flash support on
da850-EVM.

Testing information:
da850-evm comes with partitions specified in DT blob.
Able to mount/umount and create/delete files on filesystem partition.

Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
"spi/davinci: add OF support for the spi controller"

Applies on top of v3.9/dt-2 branch of linux_davinci tree:
git://gitorious.org/linux-davinci/linux-davinci.git

Since v1:
Look for m25p64 instead of m25p80 flash chip and correct partition information.

Dropping below accepted patch:
"spi/davinci: fix module build error"

Considered below missed out patch:
spi/davinci: add DT binding documentation

Manjunathappa, Prakash (3):
  ARM: davinci: da850: add SPI1 DT node
  ARM: davinci: da850: override SPI DT node device name
  ARM: davinci: da850-evm: add SPI flash support

Murali Karicheri (1):
  spi/davinci: add DT binding documentation

 .../devicetree/bindings/spi/spi-davinci.txt        |   51 ++++++++++++++++++++
 arch/arm/boot/dts/da850-evm.dts                    |   40 +++++++++++++++
 arch/arm/boot/dts/da850.dtsi                       |   18 +++++++
 arch/arm/mach-davinci/da8xx-dt.c                   |    1 +
 4 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt

-- 
1.7.4.1
