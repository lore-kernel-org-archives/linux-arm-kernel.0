From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Mon, 25 Feb 2013 16:14:06 +0530
Subject: [PATCH 0/4] Enable SPI flash support on da850-evm DT kernel
Message-ID: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch enables support for m25p80 SPI flash support on
da850-EVM.

Testing information:
da850-evm comes with partitions specified in DT blob.
Able to mount/umount and create/delete files on filesystem partition.

Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
"spi/davinci: add OF support for the spi controller"

Applies on top of below patch under community review:
http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg25184.html

Manjunathappa, Prakash (4):
  spi/davinci: fix module build error
  ARM: davinci: da850: add SPI1 DT node
  ARM: davinci: da850: override SPI DT node device name
  ARM: davinci: da850-evm: add SPI flash support

 arch/arm/boot/dts/da850-evm.dts  |   40 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     |   18 +++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |    1 +
 drivers/spi/spi-davinci.c        |    2 +-
 4 files changed, 60 insertions(+), 1 deletions(-)

-- 
1.7.4.1
