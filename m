From: vigneshr@ti.com (Vignesh R)
Date: Wed, 20 Apr 2016 17:02:58 +0530
Subject: [PATCH v2 0/2] DRA7x: Increase QSPI frequency to 64MHz
Message-ID: <1461151980-28139-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



This patch series increases QSPI bus frequency to 64MHz and switch to
SPI mode 0 in order to increase read/write throughput.
First patch removes QSPI pinmux from DT as pinmux can only be done in
U-Boot(see patch commit message for more info). Second patch does the
dts changes to support 64MHz mode 0 operation.


Tested on DRA74 and DRA72 EVM with U-Boot 2016.05-rc1.


Vignesh R (2):
  ARM: dts: dra7x: Remove QSPI pinmux
  ARM: dts: dra7x: Support QSPI MODE-0 operation at 64MHz

 Documentation/devicetree/bindings/spi/ti_qspi.txt |  7 +++++++
 arch/arm/boot/dts/dra7-evm.dts                    | 23 ++---------------------
 arch/arm/boot/dts/dra72-evm-common.dtsi           | 20 ++------------------
 3 files changed, 11 insertions(+), 39 deletions(-)

-- 
2.8.1
