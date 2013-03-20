From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Wed, 20 Mar 2013 16:16:54 +0530
Subject: [PATCH v4 0/5] Enable SPI flash support on da850-evm DT kernel
Message-ID: <1363776419-10563-1-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch enables support for m25p64 SPI flash support on
da850-EVM.

Testing information:
da850-evm comes with partitions specified in DT blob.
Able to mount/umount and create/delete files on filesystem partition.

Applies on top of linux_davinci/master tree:
git://gitorious.org/linux-davinci/linux-davinci.git

Since v3:
Minor nit, fix tabs and commit message of 2/5.

Since v2:
Fix compatible property DT naming convention.

Since v1:
Look for m25p64 instead of m25p80 flash chip and correct partition information.
Dropped below accepted patch:
"spi/davinci: fix module build error"
Considered below missed out patch:
spi/davinci: add DT binding documentation

Manjunathappa, Prakash (4):
  spi/davinci: no wildcards in DT compatible property
  ARM: davinci: da850: add SPI1 DT node
  ARM: davinci: da850: override SPI DT node device name
  ARM: davinci: da850-evm: add SPI flash support

Murali Karicheri (1):
  spi/davinci: add DT binding documentation

 .../devicetree/bindings/spi/spi-davinci.txt        |   51 ++++++++++++++++++++
 arch/arm/boot/dts/da850-evm.dts                    |   40 +++++++++++++++
 arch/arm/boot/dts/da850.dtsi                       |   18 +++++++
 arch/arm/mach-davinci/da8xx-dt.c                   |    1 +
 drivers/spi/spi-davinci.c                          |    4 +-
 5 files changed, 112 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt

-- 
1.7.4.1
