From: anilkumar.v@ti.com (Kumar, Anil)
Date: Tue, 29 Jan 2013 10:49:54 +0530
Subject: [PATCH 0/2] DaVinci: da850: Add NOR flash DT node support
Message-ID: <1359436796-25135-1-git-send-email-anilkumar.v@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NOR flash DT node support for DA850 EVM and related pin mux.
Configure 16 bit data bus width for CS2(aemif) to use the norflash on
DA850.

This series is based on top of 3.8-rc4 and the following patches.

 -drivers/pinctrl: grab default handles from device core
  https://patchwork.kernel.org/patch/1862231/
 -ARM: davinci: da850: add pinctrl driver DT entries

Tested on DA850 EVM.

Kumar, Anil (2):
  ARM: davinci: da850 evm: add norflash DT node
  ARM: davinci: da850: configure CS2(aemif) for norflash

 arch/arm/boot/dts/da850-evm.dts  |   25 +++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     |   41 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |   17 +++++++++++++++
 3 files changed, 83 insertions(+), 0 deletions(-)

-- 
1.7.4.1
